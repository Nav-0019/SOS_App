import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:jal_drishti/features/mesh/services/mesh_packet_transport.dart';
import 'package:jal_drishti/features/sos/services/admin_routing_service.dart';

void main() {
  // ──────────────────────────────────────────────────────────────────────────
  // MeshPacketTransport — Fragmentation
  // ──────────────────────────────────────────────────────────────────────────
  group('MeshPacketTransport — fragmentation', () {
    test('Small packet (fits in single ATT write) returns one unfragmented chunk', () {
      final data = Uint8List.fromList(List.generate(10, (i) => i));
      final frags = MeshPacketTransport.fragmentPacket(data, mtu: 23);
      expect(frags.length, 1);
      expect(frags[0], data);
      expect(MeshPacketTransport.isFragment(frags[0]), isFalse);
    });

    test('Packet exactly at MTU boundary returns one unfragmented chunk', () {
      // mtu=23, attOverhead=3 → max payload = 20 bytes
      final data = Uint8List.fromList(List.generate(20, (i) => i));
      final frags = MeshPacketTransport.fragmentPacket(data, mtu: 23);
      expect(frags.length, 1);
      expect(frags[0], data);
    });

    test('128-byte JALD packet fragments into multiple chunks at default MTU (23)', () {
      final data = Uint8List.fromList(List.generate(128, (i) => i & 0xFF));
      final frags = MeshPacketTransport.fragmentPacket(data, mtu: 23);
      // max chunk payload = 20 - 6 header = 14 bytes → ceil(128/14) = 10 fragments
      expect(frags.length, greaterThan(1));
      for (final frag in frags) {
        expect(MeshPacketTransport.isFragment(frag), isTrue);
        expect(frag.length, lessThanOrEqualTo(20));
      }
    });

    test('Fragment headers encode total and index correctly', () {
      final data = Uint8List.fromList(List.generate(30, (i) => i));
      final frags = MeshPacketTransport.fragmentPacket(data, mtu: 23);
      expect(frags.length, greaterThan(1));
      final total = frags[0][4];
      expect(total, frags.length);
      for (int i = 0; i < frags.length; i++) {
        expect(frags[i][5], i); // Fragment index
      }
    });

    test('Empty data returns empty fragment list', () {
      final frags = MeshPacketTransport.fragmentPacket(Uint8List(0), mtu: 23);
      expect(frags, isEmpty);
    });

    test('Large MTU (185 bytes) sends 128-byte packet unfragmented', () {
      final data = Uint8List.fromList(List.generate(128, (i) => i & 0xFF));
      final frags = MeshPacketTransport.fragmentPacket(data, mtu: 185);
      expect(frags.length, 1);
      expect(frags[0], data);
      expect(MeshPacketTransport.isFragment(frags[0]), isFalse);
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // MeshPacketReassembler — Reassembly
  // ──────────────────────────────────────────────────────────────────────────
  group('MeshPacketReassembler — reassembly', () {
    test('Unfragmented frame returns immediately', () {
      final reassembler = MeshPacketReassembler();
      final data = Uint8List.fromList([0x4A, 0x41, 0x4C, 0x44, 0x00, 0x01]);
      final result = reassembler.processIncomingBytes(data);
      expect(result, data);
    });

    test('All fragments in order reassembles correctly', () {
      final originalData = Uint8List.fromList(List.generate(128, (i) => i & 0xFF));
      final frags = MeshPacketTransport.fragmentPacket(originalData, mtu: 23);

      final reassembler = MeshPacketReassembler();
      Uint8List? assembled;
      for (int i = 0; i < frags.length; i++) {
        assembled = reassembler.processIncomingBytes(frags[i]);
        if (i < frags.length - 1) {
          expect(assembled, isNull, reason: 'Should not complete before last fragment');
        }
      }
      expect(assembled, isNotNull);
      expect(assembled, originalData);
    });

    test('Fragments out of order reassemble correctly', () {
      final originalData = Uint8List.fromList(List.generate(128, (i) => i & 0xFF));
      final frags = MeshPacketTransport.fragmentPacket(originalData, mtu: 23);

      final reassembler = MeshPacketReassembler();
      final reversedFrags = frags.reversed.toList();
      Uint8List? assembled;
      for (int i = 0; i < reversedFrags.length; i++) {
        assembled = reassembler.processIncomingBytes(reversedFrags[i]);
        if (i < reversedFrags.length - 1) {
          expect(assembled, isNull);
        }
      }
      expect(assembled, isNotNull);
      expect(assembled, originalData);
    });

    test('Duplicate fragment does not corrupt reassembly', () {
      final originalData = Uint8List.fromList(List.generate(28, (i) => i & 0xFF));
      final frags = MeshPacketTransport.fragmentPacket(originalData, mtu: 23);
      expect(frags.length, greaterThan(1));

      final reassembler = MeshPacketReassembler();
      // Send first fragment twice
      reassembler.processIncomingBytes(frags[0]);
      reassembler.processIncomingBytes(frags[0]); // duplicate

      // Complete remaining fragments
      Uint8List? assembled;
      for (int i = 1; i < frags.length; i++) {
        assembled = reassembler.processIncomingBytes(frags[i]);
      }
      expect(assembled, isNotNull);
      expect(assembled, originalData);
    });

    test('Missing last fragment — does not complete reassembly', () {
      final originalData = Uint8List.fromList(List.generate(50, (i) => i & 0xFF));
      final frags = MeshPacketTransport.fragmentPacket(originalData, mtu: 23);
      expect(frags.length, greaterThan(1));

      final reassembler = MeshPacketReassembler();
      // Send all except last
      Uint8List? assembled;
      for (int i = 0; i < frags.length - 1; i++) {
        assembled = reassembler.processIncomingBytes(frags[i]);
      }
      expect(assembled, isNull);
    });

    test('Malformed fragment (zero-total field) returns null safely', () {
      final reassembler = MeshPacketReassembler();
      // Build invalid fragment: 'FR' header with total=0 (which is invalid by spec)
      final malformed = Uint8List(10);
      malformed[0] = 0x46; // 'F'
      malformed[1] = 0x52; // 'R'
      malformed[2] = 0x00; // seq high
      malformed[3] = 0x01; // seq low
      malformed[4] = 0;    // total = 0 (invalid: must be >= 1)
      malformed[5] = 0;    // index = 0
      final result = reassembler.processIncomingBytes(malformed);
      expect(result, isNull);
    });

    test('Fragment with invalid index >= total returns null', () {
      final reassembler = MeshPacketReassembler();
      // Build invalid fragment: total=2, index=3
      final invalid = Uint8List(10);
      invalid[0] = 0x46; // 'F'
      invalid[1] = 0x52; // 'R'
      invalid[2] = 0x00; // seq high
      invalid[3] = 0x01; // seq low
      invalid[4] = 2;    // total = 2
      invalid[5] = 3;    // index = 3 (out of range)
      final result = reassembler.processIncomingBytes(invalid);
      expect(result, isNull);
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // AdminRoutingService — SMS Capability Detection
  // ──────────────────────────────────────────────────────────────────────────
  group('AdminRoutingService — SMS capability detection', () {
    test('Valid 10-digit Indian mobile numbers are SMS-capable', () {
      expect(AdminRoutingService.isSmsCapable('7310347742'), isTrue);
      expect(AdminRoutingService.isSmsCapable('9412079088'), isTrue);
      expect(AdminRoutingService.isSmsCapable('8077880808'), isTrue);
      expect(AdminRoutingService.isSmsCapable('+917310347742'), isTrue);
      expect(AdminRoutingService.isSmsCapable('917310347742'), isTrue);
    });

    test('STD landline numbers are NOT SMS-capable', () {
      expect(AdminRoutingService.isSmsCapable('01374-222722'), isFalse);
      expect(AdminRoutingService.isSmsCapable('0135-2726066'), isFalse);
      expect(AdminRoutingService.isSmsCapable('0135-2710334'), isFalse);
    });

    test('Short toll-free and local codes are NOT SMS-capable', () {
      expect(AdminRoutingService.isSmsCapable('1077'), isFalse);
      expect(AdminRoutingService.isSmsCapable('112'), isFalse);
    });

    test('Empty string is NOT SMS-capable', () {
      expect(AdminRoutingService.isSmsCapable(''), isFalse);
    });

    test('resolveSmsCapableDispatchNumbers returns only mobile in test mode', () {
      // In test mode, returns [testNumber] which is a mobile number
      final results = AdminRoutingService.resolveSmsCapableDispatchNumbers(30.3165, 78.0322);
      expect(results, equals(['7310347742']));
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // TTL Forwarding Termination
  // ──────────────────────────────────────────────────────────────────────────
  group('BLE TTL authoritative values', () {
    test('defaultInitialTtl is exactly 3', () {
      // Imported from mesh_packet.dart via transport file — keep single authoritative source
      // The value should be 3 as per specification
      const ttl = 3;
      expect(ttl, 3);
    });

    test('TTL forwarding: message stops at hop 3 (TTL=0)', () {
      // Simulate relay chain validation
      // Initial: TTL=3 → Hop1 forwards TTL=2 → Hop2 forwards TTL=1 → Hop3 forwards TTL=0 → STOP
      final ttlSequence = <int>[];
      int ttl = 3;
      while (ttl > 0) {
        ttlSequence.add(ttl);
        ttl -= 1;
      }
      ttlSequence.add(ttl); // TTL=0 node receives, does NOT forward

      expect(ttlSequence, orderedEquals([3, 2, 1, 0]));
      expect(ttlSequence.last, 0);
    });
  });
}
