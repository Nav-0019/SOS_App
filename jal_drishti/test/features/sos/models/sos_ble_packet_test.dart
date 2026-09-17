import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:jal_drishti/features/sos/models/sos_ble_packet.dart';

void main() {
  group('SosBlePacket', () {
    test('Byte length is constrained to 82 bytes', () {
      final packet = SosBlePacket(
        version: 1,
        distressType: 2, // LANDSLIDE
        latitude: 30.12345,
        longitude: 78.12345,
        peopleTrapped: 4,
        battery: 42,
        message: 'A very long message that definitely exceeds the 69 byte maximum limit of the payload string capacity in the BLE packet so we can see if it truncates properly.',
      );

      final encoded = packet.encode();
      
      expect(encoded.length, 82);
      
      final decoded = SosBlePacket.decode(encoded);
      expect(decoded.version, 1);
      expect(decoded.distressType, 2);
      expect(decoded.latitude, closeTo(30.12345, 0.0001));
      expect(decoded.longitude, closeTo(78.12345, 0.0001));
      expect(decoded.peopleTrapped, 4);
      expect(decoded.battery, 42);
      expect(decoded.message.length, lessThanOrEqualTo(69));
    });

    test('Round trip handles exact values correctly', () {
      final packet = SosBlePacket(
        version: 1,
        distressType: 1,
        latitude: 30.12345,
        longitude: 78.12345,
        peopleTrapped: 1,
        battery: 100,
        message: 'Help',
      );

      final encoded = packet.encode();
      final decoded = SosBlePacket.decode(encoded);
      
      expect(decoded.message, 'Help');
    });
  });
}
