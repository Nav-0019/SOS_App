import 'dart:typed_data';
import 'dart:convert';

/// Strict 82-byte SOS BLE packet encoding.
/// 
/// Format:
/// [0] Version (uint8)
/// [1] Distress Type Enum (uint8)
/// [2..5] Latitude (int32, lat * 1e5)
/// [6..9] Longitude (int32, lng * 1e5)
/// [10] People Trapped (uint8)
/// [11] Battery % (uint8)
/// [12] Message Length (uint8)
/// [13..81] Optional Message (UTF-8)
class SosBlePacket {
  static const int maxPayloadBytes = 82;
  static const int headerBytes = 13;
  static const int maxMessageBytes = maxPayloadBytes - headerBytes; // 69 bytes

  final int version;
  final int distressType;
  final double latitude;
  final double longitude;
  final int peopleTrapped;
  final int battery;
  final String message;

  SosBlePacket({
    this.version = 1,
    required this.distressType,
    required this.latitude,
    required this.longitude,
    required this.peopleTrapped,
    required this.battery,
    this.message = '',
  });

  Uint8List encode() {
    final buffer = Uint8List(maxPayloadBytes);
    final data = ByteData.view(buffer.buffer);

    data.setUint8(0, version);
    data.setUint8(1, distressType);
    
    data.setInt32(2, (latitude * 1e5).round(), Endian.little);
    data.setInt32(6, (longitude * 1e5).round(), Endian.little);
    
    data.setUint8(10, peopleTrapped.clamp(0, 255));
    data.setUint8(11, battery.clamp(0, 100));

    final msgBytes = utf8.encode(message);
    final lengthToCopy = msgBytes.length > maxMessageBytes ? maxMessageBytes : msgBytes.length;
    data.setUint8(12, lengthToCopy);
    
    for (int i = 0; i < lengthToCopy; i++) {
      buffer[13 + i] = msgBytes[i];
    }

    return buffer;
  }

  static SosBlePacket decode(Uint8List payload) {
    if (payload.length < headerBytes) {
      throw FormatException('Invalid SOS payload length');
    }

    final data = ByteData.view(payload.buffer);
    
    final version = data.getUint8(0);
    final distressType = data.getUint8(1);
    final latitude = data.getInt32(2, Endian.little) / 1e5;
    final longitude = data.getInt32(6, Endian.little) / 1e5;
    final peopleTrapped = data.getUint8(10);
    final battery = data.getUint8(11);
    final msgLength = data.getUint8(12);

    String message = '';
    if (msgLength > 0 && payload.length >= headerBytes + msgLength) {
      message = utf8.decode(payload.sublist(headerBytes, headerBytes + msgLength), allowMalformed: true);
    }

    return SosBlePacket(
      version: version,
      distressType: distressType,
      latitude: latitude,
      longitude: longitude,
      peopleTrapped: peopleTrapped,
      battery: battery,
      message: message,
    );
  }
}
