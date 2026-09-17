import 'dart:async';
import 'package:jal_drishti/shared/models/schemas.dart';
import 'package:jal_drishti/features/sos/models/sos_ble_packet.dart';
import 'package:jal_drishti/shared/database/isar_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:isar/isar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:uuid/uuid.dart' as app_uuid;

import '../../../shared/database/isar_service.dart';
import '../../../shared/models/schemas.dart';
import '../models/mesh_packet.dart';
import 'mesh_packet_transport.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Typed result for startPeerDiscovery()
// ─────────────────────────────────────────────────────────────────────────────
sealed class BleStartResult {}

class BleStartSuccess extends BleStartResult {}

class BleStartPermissionDenied extends BleStartResult {
  final Map<String, bool> permanentlyDenied;
  BleStartPermissionDenied(this.permanentlyDenied);
}

class BleStartUnsupported extends BleStartResult {}

// ─────────────────────────────────────────────────────────────────────────────
/// BLE Mesh Service — simultaneous central (scanner) + peripheral (advertiser).
///
/// Features:
/// - Scanning via [FlutterReactiveBle] (Central)
/// - Advertising & GATT server via native Kotlin [MethodChannel] (Peripheral)
/// - JALD 128-byte packet protocol with TTL, message ID, timestamp
/// - Dedup cache (~500 IDs) & relay-on-receive forwarding
// ─────────────────────────────────────────────────────────────────────────────
class BleMeshService {
  static final BleMeshService _instance = BleMeshService._internal();
  factory BleMeshService() => _instance;

  BleMeshService._internal() {
    _nativeBleChannel.setMethodCallHandler(_handleNativeCall);
  }

  // ── Native BLE Peripheral Method Channel ──────────────────────────────────
  static const MethodChannel _nativeBleChannel =
      MethodChannel('com.jaldrishti.app/ble_peripheral');

  // ── BLE Central Driver ─────────────────────────────────────────────────────
  final FlutterReactiveBle _ble = FlutterReactiveBle();

  // ── Secure Storage ─────────────────────────────────────────────────────────
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const String _deviceIdStorageKey = 'mesh_device_id';

  // ── Nordic UART Service UUIDs ───────────────────────────────────────────────
  static const String _serviceUuid = '6E400001-B5A3-F393-E0A9-E50E24DCCA9E';
  static const String _txCharUuid = '6E400002-B5A3-F393-E0A9-E50E24DCCA9E';
  static const String _rxCharUuid = '6E400003-B5A3-F393-E0A9-E50E24DCCA9E';

  // ── Reactive State ─────────────────────────────────────────────────────────
  final activePeerCountSignal = signal<int>(0);
  final isScanningSignal = signal<bool>(false);
  final discoveredPeers = signal<Map<String, DiscoveredDevice>>({});
  final meshMessages = listSignal<ChatMessage>([]);

  // ── Per-session State ──────────────────────────────────────────────────────
  String? _deviceId;
  StreamSubscription<DiscoveredDevice>? _scanSubscription;
  final Map<String, StreamSubscription<ConnectionStateUpdate>> _connSubs = {};
  final Map<String, StreamSubscription<List<int>>> _notifySubs = {};

  // ── Fragment Reassembly Engine ─────────────────────────────────────────────
  final MeshPacketReassembler _reassembler = MeshPacketReassembler();

  // ── Dedup Cache (~500 recent packet IDs + persistent cross-check) ──────────
  final Set<String> _seenPacketIds = <String>{};
  final List<String> _seenPacketOrder = <String>[];
  static const int _maxDedupCacheSize = 500;

  bool _isDuplicate(String packetId) {
    if (_seenPacketIds.contains(packetId)) {
      return true;
    }
    // Cross-check persistent store to prevent replay across app restarts
    try {
      final isar = IsarService().db;
      final existing =
          isar.chatMessages.filter().messageIdEqualTo(packetId).findFirstSync();
      if (existing != null) {
        _seenPacketIds.add(packetId);
        return true;
      }
    } catch (_) {}

    _seenPacketIds.add(packetId);
    _seenPacketOrder.add(packetId);
    if (_seenPacketOrder.length > _maxDedupCacheSize) {
      final oldest = _seenPacketOrder.removeAt(0);
      _seenPacketIds.remove(oldest);
    }
    return false;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PUBLIC API
  // ═══════════════════════════════════════════════════════════════════════════

  /// Loads persisted chat messages from Isar database on screen initialization.
  Future<void> loadSavedMessages() async {
    final isar = IsarService().db;
    final saved = await isar.chatMessages.where().sortByTimestamp().findAll();
    meshMessages.value = saved;
    for (final msg in saved) {
      _seenPacketIds.add(msg.messageId);
    }
  }

  /// Starts both Central scanning and Peripheral advertising.
  Future<BleStartResult> startPeerDiscovery() async {
    final permResult = await _requestBlePermissions();
    if (permResult != null) return permResult;

    if (_ble.status == BleStatus.unsupported) return BleStartUnsupported();

    discoveredPeers.value = {};
    activePeerCountSignal.value = 0;

    // Start Native BLE Peripheral (Advertiser + GATT Server)
    await _startAdvertising();
    await _startBleForeground();

    // Start Central Scanner
    await _scanSubscription?.cancel();
    _scanSubscription = null;

    isScanningSignal.value = true;

    _scanSubscription = _ble.scanForDevices(
      withServices: [Uuid.parse(_serviceUuid)],
      scanMode: ScanMode.lowLatency,
    ).listen(
      _onDeviceDiscovered,
      onError: (Object e) {
        debugPrint('[BLE] Scan error: $e');
        isScanningSignal.value = false;
      },
    );

    return BleStartSuccess();
  }

  Future<void> stopPeerDiscovery() async {
    await _scanSubscription?.cancel();
    _scanSubscription = null;
    isScanningSignal.value = false;
    await _stopAdvertising();
    await _stopBleForeground();
  }

  /// Broadcasts an initial chat message with authoritative TTL = 3.
  Future<void> sendChatMessage(String text) async {
    final myId = await _getDeviceId();
    final msgId = const app_uuid.Uuid().v4();

    // Mark own message as seen so it won't be re-saved if echoed back
    _isDuplicate(msgId);

    final packet = MeshPacket(
      id: msgId,
      senderId: myId,
      ttl: MeshPacket.defaultInitialTtl,
      timestamp: DateTime.now(),
      payload: text,
      type: MeshPacketType.chat,
    );

    final msg = ChatMessage()
      ..messageId = msgId
      ..senderId = myId
      ..textPayload = text
      ..timestamp = packet.timestamp
      ..hopCount = 0;

    final isar = IsarService().db;
    await isar.writeTxn(() => isar.chatMessages.put(msg));
    meshMessages.value = [...meshMessages.value, msg];

    // Broadcast across all connected central peers + notify connected centrals
    await _broadcastPacket(packet.toBytes());
  }

  /// Broadcasts a raw 128-byte JALD packet to all connected peers and centrals.
  Future<void> broadcastRawPacket(Uint8List packet) async {
    if (!isScanningSignal.value) await startPeerDiscovery();
    await _broadcastPacket(packet);
  }

  Future<String> getDeviceId() => _getDeviceId();

  Future<void> dispose() async {
    await _scanSubscription?.cancel();
    _scanSubscription = null;

    for (final sub in _notifySubs.values) {
      await sub.cancel();
    }
    _notifySubs.clear();

    for (final sub in _connSubs.values) {
      await sub.cancel();
    }
    _connSubs.clear();

    await _stopAdvertising();
    await _stopBleForeground();

    isScanningSignal.value = false;
    discoveredPeers.value = {};
    activePeerCountSignal.value = 0;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PRIVATE HELPERS & RELAY ENGINE
  // ═══════════════════════════════════════════════════════════════════════════

  Future<dynamic> _handleNativeCall(MethodCall call) async {
    if (call.method == 'onPacketReceived') {
      try {
        final dynamic rawArg = call.arguments;
        Uint8List rawBytes;
        if (rawArg is Uint8List) {
          rawBytes = rawArg;
        } else if (rawArg is List) {
          rawBytes = Uint8List.fromList(rawArg.cast<int>());
        } else {
          return;
        }

        final assembled = _reassembler.processIncomingBytes(rawBytes);
        if (assembled != null) {
          await _onIncomingPacket(assembled);
        }
      } catch (e, st) {
        debugPrint('[BLE Native] Error processing incoming packet: $e\n$st');
      }
    }
  }

  Future<void> _startBleForeground() async {
    try {
      await _nativeBleChannel.invokeMethod('startBleForeground');
    } catch (_) {}
  }

  Future<void> _stopBleForeground() async {
    try {
      await _nativeBleChannel.invokeMethod('stopBleForeground');
    } catch (_) {}
  }

  Future<void> _startAdvertising() async {
    try {
      final success =
          await _nativeBleChannel.invokeMethod<bool>('startAdvertising');
      debugPrint('[BLE Peripheral] startAdvertising result: $success');
    } catch (e) {
      debugPrint('[BLE Peripheral] startAdvertising error: $e');
    }
  }

  Future<void> _stopAdvertising() async {
    try {
      await _nativeBleChannel.invokeMethod('stopAdvertising');
      debugPrint('[BLE Peripheral] stopAdvertising called');
    } catch (e) {
      debugPrint('[BLE Peripheral] stopAdvertising error: $e');
    }
  }

  void _onDeviceDiscovered(DiscoveredDevice device) {
    final updated = Map<String, DiscoveredDevice>.from(discoveredPeers.value);
    updated[device.id] = device;
    discoveredPeers.value = updated;
    activePeerCountSignal.value = updated.length;
    _connectToPeer(device.id);
  }

  void _connectToPeer(String deviceId) {
    if (_connSubs.containsKey(deviceId)) return;

    final sub = _ble
        .connectToDevice(
      id: deviceId,
      connectionTimeout: const Duration(seconds: 10),
    )
        .listen(
      (update) => _onConnectionStateUpdate(deviceId, update),
      onError: (Object e) {
        debugPrint('[BLE] Connection error ($deviceId): $e');
        _cleanupPeer(deviceId);
      },
    );

    _connSubs[deviceId] = sub;
  }

  void _onConnectionStateUpdate(String deviceId, ConnectionStateUpdate update) {
    debugPrint('[BLE] $deviceId → ${update.connectionState}');

    switch (update.connectionState) {
      case DeviceConnectionState.connected:
        _requestMtuAndSubscribe(deviceId);
      case DeviceConnectionState.disconnected:
        _cleanupPeer(deviceId);
        final updated =
            Map<String, DiscoveredDevice>.from(discoveredPeers.value);
        updated.remove(deviceId);
        discoveredPeers.value = updated;
        activePeerCountSignal.value = updated.length;
      default:
        break;
    }
  }

  Future<void> _requestMtuAndSubscribe(String deviceId) async {
    try {
      await _ble.requestMtu(deviceId: deviceId, mtu: 185);
    } catch (_) {}
    _subscribeToCharacteristic(deviceId);
  }

  void _subscribeToCharacteristic(String deviceId) {
    if (_notifySubs.containsKey(deviceId)) return;

    final char = QualifiedCharacteristic(
      serviceId: Uuid.parse(_serviceUuid),
      characteristicId: Uuid.parse(_txCharUuid),
      deviceId: deviceId,
    );

    final sub = _ble.subscribeToCharacteristic(char).listen(
      (data) async {
        final rawBytes = Uint8List.fromList(data);
        final assembled = _reassembler.processIncomingBytes(rawBytes);
        if (assembled != null) {
          await _onIncomingPacket(assembled);
        }
      },
      onError: (Object e) {
        debugPrint('[BLE] Notify error ($deviceId): $e');
        _cleanupPeer(deviceId);
      },
    );

    _notifySubs[deviceId] = sub;
  }

  Future<void> _cleanupPeer(String deviceId) async {
    await _notifySubs.remove(deviceId)?.cancel();
    await _connSubs.remove(deviceId)?.cancel();
  }

  /// Processes an incoming validated packet:
  /// 1. Validates JALD binary format
  /// 2. Deduplicates via persistent & volatile cache
  /// 3. Validates timestamp freshness window (within 24 hours)
  /// 4. Saves & renders message
  /// 5. Relays (rebroadcasts) with decremented TTL if TTL > 0
  /// 6. Terminates forwarding when TTL reaches 0
  Future<void> _onIncomingPacket(Uint8List rawBytes) async {
    try {
      if (!MeshPacket.validate(rawBytes)) {
        debugPrint(
            '[BLE] Packet dropped: invalid frame format (len=${rawBytes.length})');
        return;
      }

      final packet = MeshPacket.fromBytes(rawBytes);

      // Check timestamp freshness window (reject packets older than 24h)
      final age = DateTime.now().difference(packet.timestamp).abs();
      if (age.inHours > 24) {
        debugPrint(
            '[BLE] Dropping packet ${packet.id}: timestamp outside 24h validity window');
        return;
      }

      // Check dedup cache (persistent + volatile)
      if (_isDuplicate(packet.id)) {
        debugPrint('[BLE] Dropping duplicate packet: ${packet.id}');
        return;
      }

      final myId = await _getDeviceId();
      if (packet.senderId == myId) {
        // Drop echoed packet originated from this device
        return;
      }

      // Calculate hops taken
      final hopCount =
          (MeshPacket.defaultInitialTtl - packet.ttl).clamp(0, MeshPacket.defaultInitialTtl);

      final isar = IsarService().db;
      
      if (packet.type == MeshPacketType.sos && packet.rawPayload != null) {
        try {
          final sosBle = SosBlePacket.decode(packet.rawPayload!);
          final queueMsg = SosQueueMessage()
            ..sosId = packet.id
            ..senderId = packet.senderId
            ..timestamp = packet.timestamp
            ..latitude = sosBle.latitude
            ..longitude = sosBle.longitude
            ..distressType = sosBle.distressType
            ..message = sosBle.message
            ..peopleTrapped = sosBle.peopleTrapped
            ..battery = sosBle.battery
            ..meshHops = hopCount
            ..ttl = packet.ttl
            ..isDelivered = false
            ..uploadAttempts = 0;

          await isar.writeTxn(() => isar.sosQueueMessages.put(queueMsg));
          debugPrint('[BLE] Saved incoming SOS $packet.id to offline queue (hop=$hopCount)');
        } catch (e) {
          debugPrint('[BLE] Failed to decode incoming SOS: $e');
        }
      } else {
        final msg = ChatMessage()
          ..messageId = packet.id
          ..senderId = packet.senderId.isEmpty ? 'UNKNOWN' : packet.senderId
          ..textPayload = packet.payload
          ..timestamp = packet.timestamp
          ..hopCount = hopCount;

        await isar.writeTxn(() => isar.chatMessages.put(msg));
        meshMessages.value = [...meshMessages.value, msg];
        debugPrint(
            '[BLE] Received new message ${packet.id} from ${packet.senderId} (TTL=${packet.ttl}, hop=$hopCount)');
      }

      // Authoritative TTL Forwarding Specification:
      // Initial message (TTL=3) -> Hop 1 (TTL=2) -> Hop 2 (TTL=1) -> Hop 3 (TTL=0) -> Stop
      // A node must NOT forward a message when TTL reaches zero.
      if (packet.ttl <= 0) {
        debugPrint(
            '[BLE] Packet ${packet.id} reached TTL=0 — forwarding terminated.');
      } else {
        final relayTtl = packet.ttl - 1;
        final relayPacket = packet.copyWith(ttl: relayTtl);
        debugPrint(
            '[BLE] Relaying packet ${packet.id} with decremented TTL=$relayTtl');
        await _broadcastPacket(relayPacket.toBytes());
      }
    } catch (e, st) {
      debugPrint('[BLE] Packet processing error: $e\n$st');
    }
  }

  /// Sends packet bytes to all connected Central peers (via GATT RX write)
  /// and connected Peripheral clients (via GATT TX notify) using MTU-safe fragments.
  Future<void> _broadcastPacket(Uint8List bytes) async {
    final fragments = MeshPacketTransport.fragmentPacket(bytes, mtu: 23);

    // 1. Central writes to connected Peripheral peers
    for (final peerId in _connSubs.keys.toList()) {
      final char = QualifiedCharacteristic(
        serviceId: Uuid.parse(_serviceUuid),
        characteristicId: Uuid.parse(_rxCharUuid),
        deviceId: peerId,
      );
      for (final frag in fragments) {
        try {
          await _ble.writeCharacteristicWithResponse(char, value: frag);
        } catch (e) {
          debugPrint('[BLE] Write failed for peer $peerId: $e');
        }
      }
    }

    // 2. Peripheral notifies connected Central clients
    for (final frag in fragments) {
      try {
        await _nativeBleChannel.invokeMethod('notifyCentrals', frag);
      } catch (e) {
        debugPrint('[BLE Peripheral] Notify centrals error: $e');
      }
    }
  }

  Future<BleStartResult?> _requestBlePermissions() async {
    final statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
      Permission.locationWhenInUse,
    ].request();

    final denied = <String, bool>{};
    for (final entry in statuses.entries) {
      if (entry.value.isDenied || entry.value.isPermanentlyDenied) {
        denied[entry.key.toString()] = entry.value.isPermanentlyDenied;
      }
    }
    if (denied.isNotEmpty) return BleStartPermissionDenied(denied);
    return null;
  }

  Future<String> _getDeviceId() async {
    if (_deviceId != null) return _deviceId!;

    final stored = await _storage.read(key: _deviceIdStorageKey);
    if (stored != null && stored.isNotEmpty) {
      _deviceId = stored;
    } else {
      _deviceId = const app_uuid.Uuid().v4();
      await _storage.write(key: _deviceIdStorageKey, value: _deviceId);
    }
    return _deviceId!;
  }
}



