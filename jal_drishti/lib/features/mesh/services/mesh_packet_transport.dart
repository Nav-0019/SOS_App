import 'dart:typed_data';

/// Handles BLE MTU negotiation, packet fragmentation, and frame reassembly
/// for the JALD 128-byte mesh protocol.
class MeshPacketTransport {
  // Fragment Header:
  // [0..1] Magic identifier 'FR' (0x46, 0x52)
  // [2..3] Packet ID sequence token (16-bit uint)
  // [4]    Total fragment count (1..255)
  // [5]    Fragment index (0-based: 0..total-1)
  // [6..N] Chunk Payload
  static const int fragmentHeaderSize = 6;
  static const int defaultAttMtu = 23;
  static const int attOverhead = 3; // ATT opcode (1) + attribute handle (2)
  static const int defaultMaxPayloadPerWrite = defaultAttMtu - attOverhead; // 20 bytes

  /// Fragments [data] into a list of byte arrays suitable for transmission
  /// over BLE with the given [mtu].
  ///
  /// If [mtu] is large enough to transmit [data] in a single write without
  /// fragmentation, and [data] already conforms to the JALD frame specification,
  /// returns a single item containing [data].
  /// Otherwise, partitions [data] into indexed fragments with integrity headers.
  static List<Uint8List> fragmentPacket(
    Uint8List data, {
    int mtu = defaultAttMtu,
    int? sequenceToken,
  }) {
    if (data.isEmpty) return [];

    final maxChunkPayload = (mtu - attOverhead) - fragmentHeaderSize;
    if (maxChunkPayload <= 0) {
      throw ArgumentError('MTU $mtu is too small for fragmentation header ($fragmentHeaderSize bytes).');
    }

    // If MTU is large enough for unfragmented single-frame transfer
    if (data.length <= (mtu - attOverhead)) {
      return [Uint8List.fromList(data)];
    }

    final totalFragments = (data.length / maxChunkPayload).ceil();
    if (totalFragments > 255) {
      throw ArgumentError('Data size ${data.length} exceeds maximum 255 fragments.');
    }

    final seq = sequenceToken ?? _generateSequenceToken(data);
    final fragments = <Uint8List>[];

    for (int i = 0; i < totalFragments; i++) {
      final start = i * maxChunkPayload;
      final end = (start + maxChunkPayload < data.length)
          ? start + maxChunkPayload
          : data.length;
      final chunkLen = end - start;

      final frag = Uint8List(fragmentHeaderSize + chunkLen);
      // Header
      frag[0] = 0x46; // 'F'
      frag[1] = 0x52; // 'R'
      frag[2] = (seq >> 8) & 0xFF;
      frag[3] = seq & 0xFF;
      frag[4] = totalFragments;
      frag[5] = i;

      // Body
      for (int b = 0; b < chunkLen; b++) {
        frag[fragmentHeaderSize + b] = data[start + b];
      }

      fragments.add(frag);
    }

    return fragments;
  }

  /// Determines whether [bytes] is a fragmented chunk ('FR' header).
  static bool isFragment(Uint8List bytes) {
    if (bytes.length < fragmentHeaderSize) return false;
    return bytes[0] == 0x46 && bytes[1] == 0x52;
  }

  static int _generateSequenceToken(Uint8List data) {
    int hash = 0x811c9dc5;
    for (int i = 0; i < data.length; i++) {
      hash ^= data[i];
      hash = (hash * 0x01000193) & 0xFFFF;
    }
    return hash;
  }
}

/// In-memory reassembler for incoming BLE fragments with missing/duplicate/malformed handling.
class MeshPacketReassembler {
  final Map<int, _FragmentAssemblySession> _sessions = {};
  final Duration sessionTimeout;

  MeshPacketReassembler({this.sessionTimeout = const Duration(seconds: 30)});

  /// Ingests an incoming raw byte frame.
  ///
  /// If the frame is an unfragmented packet, returns the bytes immediately.
  /// If the frame is a valid fragment:
  /// - If all fragments have arrived, completes and returns the full reconstituted [Uint8List].
  /// - If still incomplete, returns `null`.
  /// If the frame is malformed, returns `null` safely without throwing.
  Uint8List? processIncomingBytes(Uint8List raw) {
    _cleanupExpiredSessions();

    if (!MeshPacketTransport.isFragment(raw)) {
      // Unfragmented frame
      return raw;
    }

    if (raw.length < MeshPacketTransport.fragmentHeaderSize) {
      // Malformed
      return null;
    }

    final seq = (raw[2] << 8) | raw[3];
    final total = raw[4];
    final index = raw[5];

    // Validation: Total must be >= 1, index must be in [0, total - 1]
    if (total == 0 || index >= total) {
      return null;
    }

    final chunkPayload = raw.sublist(MeshPacketTransport.fragmentHeaderSize);

    final session = _sessions.putIfAbsent(
      seq,
      () => _FragmentAssemblySession(total: total, expiresAt: DateTime.now().add(sessionTimeout)),
    );

    // If total fragment count changes unexpectedly for same sequence, reject
    if (session.total != total) {
      return null;
    }

    // Idempotent assignment (duplicate fragment does not corrupt)
    session.fragments[index] = chunkPayload;

    // Check if all fragments [0..total-1] have been collected
    if (session.fragments.length == session.total) {
      // Reassemble in sequence
      int totalBytes = 0;
      for (int i = 0; i < session.total; i++) {
        final f = session.fragments[i];
        if (f == null) return null; // Missing fragment
        totalBytes += f.length;
      }

      final assembled = Uint8List(totalBytes);
      int offset = 0;
      for (int i = 0; i < session.total; i++) {
        final f = session.fragments[i]!;
        assembled.setRange(offset, offset + f.length, f);
        offset += f.length;
      }

      _sessions.remove(seq);
      return assembled;
    }

    return null;
  }

  void _cleanupExpiredSessions() {
    final now = DateTime.now();
    _sessions.removeWhere((_, session) => session.expiresAt.isBefore(now));
  }

  /// Clears all pending assembly sessions.
  void clear() {
    _sessions.clear();
  }
}

class _FragmentAssemblySession {
  final int total;
  final DateTime expiresAt;
  final Map<int, Uint8List> fragments = {};

  _FragmentAssemblySession({required this.total, required this.expiresAt});
}
