import 'dart:convert';
import 'dart:typed_data';
import 'package:uuid/uuid.dart';

/// JALD BLE Mesh packet types.
enum MeshPacketType {
  chat(0x01),
  hazard(0x02),
  sos(0x03),
  adminHazardReport(0x04);

  final int value;
  const MeshPacketType(this.value);

  static MeshPacketType? fromValue(int value) {
    for (final type in MeshPacketType.values) {
      if (type.value == value) return type;
    }
    return null;
  }
}

/// Fixed 128-byte packet model for JALD BLE Mesh protocol.
///
/// Binary Layout:
///   [0..3]    Protocol Header "JALD" (4 bytes: 0x4A, 0x41, 0x4C, 0x44)
///   [4..19]   Message ID             (16 bytes raw UUID)
///   [20..35]  Sender ID              (16 bytes raw UUID / token)
///   [36]      TTL                    (1 byte uint8, starts at 3)
///   [37..44]  Timestamp              (8 bytes int64 millisecondsSinceEpoch, big-endian)
///   [45]      Packet Type            (1 byte uint8)
///   [46..127] Payload                (82 bytes payload, null-padded)
class MeshPacket {
  static final Uint8List protocolHeader =
      Uint8List.fromList([0x4A, 0x41, 0x4C, 0x44]); // "JALD"
  static const int packetLength = 128;
  static const int defaultInitialTtl = 3;

  final String id;
  final String senderId;
  final int ttl;
  final DateTime timestamp;
  final String payload;
  final Uint8List? rawPayload;
  final MeshPacketType type;

  String get text => payload;
  int get hopCount => (defaultInitialTtl - ttl).clamp(0, defaultInitialTtl);

  MeshPacket({
    String? id,
    required this.senderId,
    int? ttl,
    int? hopCount,
    DateTime? timestamp,
    String? payload,
    String? text,
    this.rawPayload,
    this.type = MeshPacketType.chat,
  })  : id = id ?? const Uuid().v4(),
        ttl = ttl ??
            (hopCount != null
                ? (defaultInitialTtl - hopCount).clamp(0, defaultInitialTtl)
                : defaultInitialTtl),
        payload = payload ?? text ?? '',
        timestamp = timestamp ?? DateTime.now();

  MeshPacket copyWith({
    String? id,
    String? senderId,
    int? ttl,
    DateTime? timestamp,
    String? payload,
    Uint8List? rawPayload,
    MeshPacketType? type,
  }) {
    return MeshPacket(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      ttl: ttl ?? this.ttl,
      timestamp: timestamp ?? this.timestamp,
      payload: payload ?? this.payload,
      rawPayload: rawPayload ?? this.rawPayload,
      type: type ?? this.type,
    );
  }

  /// Serializes this packet to exactly 128 bytes.
  Uint8List toBytes() {
    final bytes = Uint8List(packetLength);
    final byteData = ByteData.sublistView(bytes);

    // [0..3] Header
    bytes[0] = protocolHeader[0];
    bytes[1] = protocolHeader[1];
    bytes[2] = protocolHeader[2];
    bytes[3] = protocolHeader[3];

    // [4..19] Message ID (16 bytes)
    final idBytes = _uuidTo16Bytes(id);
    for (var i = 0; i < 16; i++) {
      bytes[4 + i] = idBytes[i];
    }

    // [20..35] Sender ID (16 bytes)
    final senderBytes = _uuidTo16Bytes(senderId);
    for (var i = 0; i < 16; i++) {
      bytes[20 + i] = senderBytes[i];
    }

    // [36] TTL
    bytes[36] = ttl.clamp(0, 255);

    // [37..44] Timestamp
    byteData.setInt64(37, timestamp.millisecondsSinceEpoch, Endian.big);

    // [45] Packet type
    bytes[45] = type.value;

    // [46..127] Payload (max 82 bytes)
    final encodedPayload = rawPayload ?? utf8.encode(payload);
    const maxPayloadLength = packetLength - 46;
    final writeLen = encodedPayload.length < maxPayloadLength
        ? encodedPayload.length
        : maxPayloadLength;

    for (var i = 0; i < writeLen; i++) {
      bytes[46 + i] = encodedPayload[i];
    }

    return bytes;
  }

  /// Validates raw binary data against the JALD protocol specification.
  static bool validate(Uint8List bytes) {
    if (bytes.lengthInBytes != packetLength) return false;

    if (bytes[0] != protocolHeader[0] ||
        bytes[1] != protocolHeader[1] ||
        bytes[2] != protocolHeader[2] ||
        bytes[3] != protocolHeader[3]) {
      return false;
    }

    final typeValue = bytes[45];
    if (MeshPacketType.fromValue(typeValue) == null) return false;

    return true;
  }

  /// Deserializes a 128-byte binary frame into a [MeshPacket].
  static MeshPacket fromBytes(Uint8List bytes) {
    if (!validate(bytes)) {
      throw ArgumentError('Invalid JALD mesh packet');
    }

    final byteData = ByteData.sublistView(bytes);

    final id = _bytesToUuid16(bytes.sublist(4, 20));
    final senderId = _bytesToUuid16(bytes.sublist(20, 36));
    final ttl = bytes[36];
    final tsMillis = byteData.getInt64(37, Endian.big);
    final timestamp = DateTime.fromMillisecondsSinceEpoch(tsMillis);
    final type = MeshPacketType.fromValue(bytes[45]) ?? MeshPacketType.chat;

    // Payload slice
    final payloadBytes = bytes.sublist(46, 128);
    // for text representation, stop at null byte
    final textPayloadBytes = payloadBytes.takeWhile((b) => b != 0).toList();
    final payload = utf8.decode(textPayloadBytes, allowMalformed: true);

    return MeshPacket(
      id: id,
      senderId: senderId,
      ttl: ttl,
      timestamp: timestamp,
      payload: payload,
      rawPayload: payloadBytes,
      type: type,
    );
  }

  static Uint8List _uuidTo16Bytes(String value) {
    try {
      final parsed = Uuid.parse(value);
      return Uint8List.fromList(parsed);
    } catch (_) {
      // Fallback: hash or slice string to 16 bytes
      final raw = utf8.encode(value);
      final out = Uint8List(16);
      for (var i = 0; i < 16 && i < raw.length; i++) {
        out[i] = raw[i];
      }
      return out;
    }
  }

  static String _bytesToUuid16(Uint8List bytes) {
    try {
      return Uuid.unparse(bytes);
    } catch (_) {
      return bytes
          .takeWhile((b) => b != 0)
          .map((b) => b.toRadixString(16).padLeft(2, '0'))
          .join();
    }
  }
}
