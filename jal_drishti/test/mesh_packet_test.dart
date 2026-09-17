import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';
import 'package:jal_drishti/features/mesh/models/mesh_packet.dart';

void main() {
  group('MeshPacket Protocol Specification (128 bytes)', () {
    test('Encodes and decodes packet with exact 128-byte size', () {
      final msgId = const Uuid().v4();
      final senderId = const Uuid().v4();
      final now = DateTime.now();

      final packet = MeshPacket(
        id: msgId,
        senderId: senderId,
        ttl: 3,
        timestamp: now,
        payload: 'Emergency: Need rescue at Kedarnath base camp',
        type: MeshPacketType.chat,
      );

      final bytes = packet.toBytes();
      expect(bytes.lengthInBytes, 128);
      expect(MeshPacket.validate(bytes), isTrue);

      final decoded = MeshPacket.fromBytes(bytes);
      expect(decoded.id, msgId);
      expect(decoded.senderId, senderId);
      expect(decoded.ttl, 3);
      expect(decoded.payload, 'Emergency: Need rescue at Kedarnath base camp');
      expect(decoded.type, MeshPacketType.chat);
      // Millisecond precision for timestamp
      expect(
        decoded.timestamp.millisecondsSinceEpoch,
        now.millisecondsSinceEpoch,
      );
    });

    test('Rejects corrupted or undersized packets', () {
      final validBytes = MeshPacket(
        id: const Uuid().v4(),
        senderId: const Uuid().v4(),
        payload: 'Hello',
      ).toBytes();

      // Undersized
      expect(MeshPacket.validate(validBytes.sublist(0, 100)), isFalse);

      // Corrupted header
      validBytes[0] = 0x00;
      expect(MeshPacket.validate(validBytes), isFalse);
    });

    test('Relay TTL decrement copyWith preserves fields and terminates at 0', () {
      final original = MeshPacket(
        id: const Uuid().v4(),
        senderId: const Uuid().v4(),
        ttl: 3,
        payload: 'Flood warning relay test',
      );

      final hop1 = original.copyWith(ttl: original.ttl - 1);
      expect(hop1.ttl, 2);
      expect(hop1.hopCount, 1);

      final hop2 = hop1.copyWith(ttl: hop1.ttl - 1);
      expect(hop2.ttl, 1);
      expect(hop2.hopCount, 2);

      final hop3 = hop2.copyWith(ttl: hop2.ttl - 1);
      expect(hop3.ttl, 0);
      expect(hop3.hopCount, 3);
      expect(hop3.id, original.id);
      expect(hop3.senderId, original.senderId);
      expect(hop3.payload, original.payload);
    });
  });
}
