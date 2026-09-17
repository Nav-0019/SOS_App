import 'dart:async';
import 'package:isar/isar.dart';
import 'package:jal_drishti/shared/models/schemas.dart';
import 'package:jal_drishti/features/sos/models/sos_ble_packet.dart';
import 'package:jal_drishti/shared/database/isar_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:telephony/telephony.dart';
import 'package:battery_plus/battery_plus.dart';
import '../../mesh/models/mesh_packet.dart';
import '../../mesh/services/ble_mesh_service.dart';
import '../admin_canned_messages.dart';
import '../admin_contacts.dart';
import '../config/emergency_test_config.dart';
import '../services/admin_routing_service.dart';
import '../services/hardware_sos_service.dart';

enum SosState { idle, countdown, active }

final sosStateSignal = signal<SosState>(SosState.idle);
final countdownRemainingSignal = signal<int>(3);
final sosErrorSignal = signal<String?>(null);

class _SosContext {
  final double lat;
  final double lng;
  final double alt;
  final String bloodGroup;
  final String medicalId;
  final String userName;
  final String userPhone;
  final String nodeId;

  _SosContext({
    required this.lat,
    required this.lng,
    required this.alt,
    required this.bloodGroup,
    required this.medicalId,
    required this.userName,
    required this.userPhone,
    required this.nodeId,
  });
}

class SosController {
  static final SosController _instance = SosController._internal();
  factory SosController() => _instance;
  SosController._internal();

  Timer? _countdownTimer;
  final HardwareSosService _hardwareService = HardwareSosService();
  final Telephony _telephony = Telephony.instance;
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  /// Triggers a 3-second countdown then dispatches to admin-routed numbers.
  void triggerSosWithAdminRouting() {
    if (sosStateSignal.value != SosState.idle) return;

    sosStateSignal.value = SosState.countdown;
    countdownRemainingSignal.value = 3;

    final contextFuture = _extractLocationAndProfile();

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (countdownRemainingSignal.value > 1) {
        countdownRemainingSignal.value -= 1;
      } else {
        timer.cancel();
        _countdownTimer = null;
        final context = await contextFuture;
        await _executeAdminRoutingDispatch(context);
      }
    });
  }

  void cancelSosCountdown() {
    if (sosStateSignal.value == SosState.countdown) {
      _countdownTimer?.cancel();
      _countdownTimer = null;
      sosStateSignal.value = SosState.idle;
      countdownRemainingSignal.value = 3;
    }
  }

  Future<void> deactivateSos() async {
    await _hardwareService.stopEmergencyBeacon();
    sosStateSignal.value = SosState.idle;
    countdownRemainingSignal.value = 3;
  }

  /// Triggers a countdown then dispatches [formattedPayload] to [targetPhoneNumbers].
  void triggerSosCountdown({
    required List<String> targetPhoneNumbers,
    required String formattedPayload,
  }) {
    if (sosStateSignal.value != SosState.idle) return;

    sosStateSignal.value = SosState.countdown;
    countdownRemainingSignal.value = 3;

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdownRemainingSignal.value > 1) {
        countdownRemainingSignal.value -= 1;
      } else {
        timer.cancel();
        _countdownTimer = null;
        _activateSos(targetPhoneNumbers, formattedPayload);
      }
    });
  }

  Future<_SosContext> _extractLocationAndProfile() async {
    double lat = 30.3165;
    double lng = 78.0322;
    double alt = 640.0;

    try {
      if (await Geolocator.isLocationServiceEnabled()) {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }
        if (permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always) {
          final pos = await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
              timeLimit: Duration(seconds: 3),
            ),
          );
          lat = pos.latitude;
          lng = pos.longitude;
          alt = pos.altitude;
        }
      }
    } catch (_) {
      try {
        final lastKnown = await Geolocator.getLastKnownPosition();
        if (lastKnown != null) {
          lat = lastKnown.latitude;
          lng = lastKnown.longitude;
          alt = lastKnown.altitude;
        }
      } catch (_) {}
    }

    final bloodGroup = await _storage.read(key: 'medical_blood_group') ??
        await _storage.read(key: 'blood_group') ??
        'O+';
    final medicalId = await _storage.read(key: 'medical_id') ??
        await _storage.read(key: 'medical_profile_id') ??
        'MED-01';
    final userName = await _storage.read(key: 'user_name') ?? 'Citizen';
    final userPhone =
        await _storage.read(key: 'user_phone') ?? 'Unknown Number';
    final nodeId = await BleMeshService().getDeviceId();

    return _SosContext(
      lat: lat,
      lng: lng,
      alt: alt,
      bloodGroup: bloodGroup,
      medicalId: medicalId,
      userName: userName,
      userPhone: userPhone,
      nodeId: nodeId,
    );
  }

  Future<void> _executeAdminRoutingDispatch(_SosContext ctx) async {
    sosStateSignal.value = SosState.active;
    await _hardwareService.startEmergencyBeacon();

    final districtName =
        AdminRoutingService.resolveDistrictName(ctx.lat, ctx.lng);
    final targetSmsNumbers =
        AdminRoutingService.resolveDispatchNumbers(ctx.lat, ctx.lng);

    if (kDebugMode && EmergencyTestConfig.testMode) {
      debugPrint(
          '[SOS] Dispatch triggered in TEST MODE (District: $districtName) - Real Emergency Services: BLOCKED');
    }

    final hazardType =
        'Trauma (Blood: ${ctx.bloodGroup}, ID: ${ctx.medicalId})';

    // 1. Attempt SMS Dispatch (SMS does not require internet / mobile data)
    final batteryLevel = await Battery().batteryLevel;
    final rescueMessage = AdminCannedMessages.render(
      AdminCannedMessages.admRescue,
      {
        'USER_NAME': ctx.userName,
        'USER_PHONE': ctx.userPhone,
        'LAT': ctx.lat.toStringAsFixed(4),
        'LNG': ctx.lng.toStringAsFixed(4),
        'ALT': ctx.alt.toStringAsFixed(1),
        'GROUP_COUNT': '1',
        'HAZARD_TYPE': hazardType,
        'BATTERY': batteryLevel.toString(),
      },
    );

    try {
      if (await _telephony.requestSmsPermissions == true) {
        for (final number in targetSmsNumbers) {
          final trimmed = number.trim();
          if (trimmed.isNotEmpty) {
            final masked = _maskPhone(trimmed);
            if (!AdminRoutingService.isSmsCapable(trimmed)) {
              debugPrint('[SOS] Destination $masked is not SMS-capable (voice/landline) — skipping SMS.');
              continue;
            }
            try {
              await _telephony.sendSms(
                to: trimmed,
                message: rescueMessage,
                isMultipart: true,
              );
            } catch (e) {
              sosErrorSignal.value = 'SMS dispatch failed for $masked: $e';
            }
          }
        }
      } else {
        sosErrorSignal.value = 'SMS permission denied by user system.';
      }
    } catch (e) {
      sosErrorSignal.value = 'SMS execution error: $e';
    }

    // 2. Attempt BLE Mesh Broadcast & Offline Queueing
    try {
      // Create binary SosBlePacket
      final bleSos = SosBlePacket(
        version: 1,
        distressType: 4, // 4 = MEDICAL/TRAUMA based on hazardType
        latitude: ctx.lat,
        longitude: ctx.lng,
        peopleTrapped: 1,
        battery: batteryLevel,
        message: rescueMessage,
      );

      final sosPayloadBytes = bleSos.encode();

      final packet = MeshPacket(
        senderId: ctx.nodeId,
        rawPayload: sosPayloadBytes,
        type: MeshPacketType.sos,
        hopCount: 0,
      );

      // Save to Offline Queue (Isar)
      final queueMsg = SosQueueMessage()
        ..sosId = packet.id
        ..senderId = ctx.nodeId
        ..timestamp = packet.timestamp
        ..latitude = ctx.lat
        ..longitude = ctx.lng
        ..distressType = 4
        ..message = rescueMessage
        ..name = ctx.userName
        ..phone = ctx.userPhone
        ..peopleTrapped = 1
        ..battery = batteryLevel
        ..meshHops = 0
        ..ttl = packet.ttl
        ..deviceId = ctx.nodeId
        ..isDelivered = false
        ..uploadAttempts = 0;

      final isar = IsarService().db;
      await isar.writeTxn(() async {
        await isar.sosQueueMessages.put(queueMsg);
      });

      // Broadcast to mesh
      await BleMeshService().broadcastRawPacket(packet.toBytes());
    } catch (e) {
      sosErrorSignal.value = 'BLE mesh dispatch failed: $e';
    }
  }

  Future<void> _activateSos(List<String> targetNumbers, String payload) async {
    sosStateSignal.value = SosState.active;
    await _hardwareService.startEmergencyBeacon();

    final List<String> dispatchTargets;
    if (EmergencyTestConfig.testMode) {
      dispatchTargets = [EmergencyTestConfig.testNumber];
      if (kDebugMode) {
        debugPrint('''
========== SOS TEST MODE ==========
Dispatch Number: ${EmergencyTestConfig.testNumber}
Real Emergency Services: BLOCKED
====================================''');
      }
    } else {
      dispatchTargets = targetNumbers;
    }

    if (await _telephony.requestSmsPermissions == true) {
      for (final number in dispatchTargets) {
        final trimmed = number.trim();
        if (trimmed.isNotEmpty) {
          final masked = _maskPhone(trimmed);
          if (!AdminRoutingService.isSmsCapable(trimmed)) {
            debugPrint('[SOS] Destination $masked is not SMS-capable (voice/landline) — skipping SMS.');
            continue;
          }
          try {
            await _telephony.sendSms(
              to: trimmed,
              message: payload,
              isMultipart: true,
            );
          } catch (e) {
            sosErrorSignal.value = 'SMS dispatch failed for $masked: $e';
          }
        }
      }
    } else {
      sosErrorSignal.value = 'SMS permission denied by user system.';
    }
  }

  static String _maskPhone(String number) {
    if (number.length <= 4) return '****';
    return '***${number.substring(number.length - 4)}';
  }
}




