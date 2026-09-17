import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:jal_drishti/shared/models/schemas.dart';
import 'package:jal_drishti/shared/database/isar_service.dart';
import 'package:jal_drishti/features/mesh/services/ble_mesh_service.dart';

class SosGatewayService {
  static final SosGatewayService _instance = SosGatewayService._internal();
  factory SosGatewayService() => _instance;
  SosGatewayService._internal();

  Timer? _syncTimer;
  bool _isSyncing = false;

  static const String apiBaseUrl = 'http://192.168.137.1:8000';
  static const String endpoint = '/api/v1/sos/incoming';
  static const int maxRetries = 5;

  void start() {
    if (_syncTimer != null) return;
    _syncTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      _syncPendingSos();
    });
    _syncPendingSos();
  }

  void stop() {
    _syncTimer?.cancel();
    _syncTimer = null;
  }

  Future<void> _syncPendingSos() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      final isar = IsarService().db;
      final pendingMessages = await isar.sosQueueMessages
          .filter()
          .isDeliveredEqualTo(false)
          .uploadAttemptsLessThan(maxRetries)
          .findAll();

      if (pendingMessages.isEmpty) {
        _isSyncing = false;
        return;
      }

      final deviceId = await BleMeshService().getDeviceId();

      for (final msg in pendingMessages) {
        final success = await _uploadSos(msg, deviceId);
        if (success) {
          await isar.writeTxn(() async {
            msg.isDelivered = true;
            msg.lastError = null;
            await isar.sosQueueMessages.put(msg);
          });
          debugPrint('[SosGateway] Successfully uploaded SOS');
        } else {
          await isar.writeTxn(() async {
            msg.uploadAttempts += 1;
            msg.lastAttemptAt = DateTime.now();
            await isar.sosQueueMessages.put(msg);
          });
        }
      }
    } catch (e, stackTrace) {
      debugPrint('[SosGateway] Sync error: $e\n$stackTrace');
    } finally {
      _isSyncing = false;
    }
  }

  String _mapDistressType(int type) {
    switch (type) {
      case 0: return 'RISING_WATER';
      case 1: return 'EARTHQUAKE';
      case 2: return 'FIRE';
      case 3: return 'STRUCTURAL_COLLAPSE';
      case 4: return 'TRAUMA';
      case 5: return 'EVACUATION';
      default: return 'GENERAL_EMERGENCY';
    }
  }

  Future<bool> _uploadSos(SosQueueMessage msg, String gatewayDeviceId) async {
    try {
      final battery = Battery();
      final batteryLevel = await battery.batteryLevel;

      final payload = {
        'sos_id': msg.sosId.isNotEmpty ? msg.sosId : 'UNKNOWN_SOS',
        'sender_id': msg.senderId.isNotEmpty ? msg.senderId : 'UNKNOWN_SENDER',
        'timestamp': msg.timestamp.toUtc().toIso8601String(),
        'name': msg.name ?? '',
        'phone': msg.phone ?? '',
        'latitude': msg.latitude,
        'longitude': msg.longitude,
        'distress_type': _mapDistressType(msg.distressType),
        'message': msg.message ?? '',
        'people_trapped': msg.peopleTrapped,
        'battery': batteryLevel,
        'mesh_hops': msg.meshHops,
        'device_id': msg.deviceId ?? gatewayDeviceId,
        'gateway_id': gatewayDeviceId,
        'source': 'BLE_MESH',
      };

      final uri = Uri.parse(apiBaseUrl + endpoint);
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'X-Gateway-Key': 'gateway_secret_123',
        },
        body: jsonEncode(payload),
      ).timeout(const Duration(seconds: 10));

      debugPrint('SOS SENT! Status: ${response.statusCode} Response: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final body = jsonDecode(response.body);
        if (body['success'] == true) {
          return true;
        }
      } else {
        msg.lastError = 'HTTP error: ${response.statusCode}';
      }
    } catch (e) {
      msg.lastError = 'Error: $e';
      debugPrint('[SosGateway] Upload failed: $e');
    }
    return false;
  }
}
