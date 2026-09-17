class AdminCannedMessages {
  static const String admRescue = 'ADM_RESCUE';
  static const String admMeshBridge = 'ADM_MESH_BRIDGE';

  static const Map<String, String> templates = {
    admRescue: '''[JALDRISHTI-ALERT] CRITICAL RESCUE REQ
User: {USER_NAME} ({USER_PHONE})
Location: https://maps.google.com/?q={LAT},{LNG} (Alt: {ALT}m)
Victim Count: {GROUP_COUNT}
Medical Hazard: {HAZARD_TYPE}
Device Batt: {BATTERY}%''',
    admMeshBridge: '''[JALDRISHTI-MESH-RELAY] HAZARD REPORT
Source Node: {NODE_ID} | Hops: {HOP_COUNT}
Incident: {HAZARD_TYPE} @ {LAT},{LNG}
Timestamp: {TIMESTAMP}
Status: Unverified (Mesh Upvotes: {UPVOTES})''',
  };

  static const Set<String> allowedFields = {
    'USER_NAME',
    'USER_PHONE',
    'LAT',
    'LNG',
    'ALT',
    'GROUP_COUNT',
    'HAZARD_TYPE',
    'BATTERY',
    'NODE_ID',
    'HOP_COUNT',
    'TIMESTAMP',
    'UPVOTES',
  };

  static String render(String shortCode, Map<String, String> fields) {
    final template = templates[shortCode];
    if (template == null) {
      throw ArgumentError('Unknown template short code: $shortCode');
    }

    var rendered = template;
    for (final key in allowedFields) {
      rendered = rendered.replaceAll('{$key}', fields[key] ?? '');
    }
    return rendered;
  }
}
