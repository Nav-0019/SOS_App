import '../admin_contacts.dart';
import '../config/emergency_test_config.dart';

class DistrictBoundingBox {
  final String district;
  final String deocNumber;
  final double minLat;
  final double maxLat;
  final double minLng;
  final double maxLng;

  const DistrictBoundingBox(
    this.district,
    this.deocNumber,
    this.minLat,
    this.maxLat,
    this.minLng,
    this.maxLng,
  );

  bool contains(double lat, double lng) =>
      lat >= minLat && lat <= maxLat && lng >= minLng && lng <= maxLng;
}

/// Resolves GPS coordinates to the appropriate district DEOC dispatch numbers.
///
/// In [EmergencyTestConfig.testMode], all dispatch is redirected to
/// [EmergencyTestConfig.testNumber] — real emergency services are blocked.
class AdminRoutingService {
  static const List<DistrictBoundingBox> districtBoxes = [
    DistrictBoundingBox(
        'Uttarkashi', '01374-222722', 30.45, 31.45, 77.80, 79.40),
    DistrictBoundingBox('Chamoli', '01372-251437', 30.00, 31.10, 79.00, 80.15),
    DistrictBoundingBox(
        'Rudraprayag', '01364-233727', 30.15, 30.85, 78.80, 79.35),
    DistrictBoundingBox(
        'Tehri Garhwal', '01376-233433', 30.10, 30.90, 78.15, 79.05),
    DistrictBoundingBox('Dehradun', '0135-2726066', 29.95, 30.95, 77.55, 78.35),
    DistrictBoundingBox(
        'Pauri Garhwal', '01368-221840', 29.70, 30.30, 78.40, 79.20),
    DistrictBoundingBox('Haridwar', '01334-223999', 29.55, 30.15, 77.90, 78.40),
    DistrictBoundingBox('Almora', '01396-230007', 29.40, 29.90, 79.20, 80.00),
    DistrictBoundingBox(
        'Pithoragarh', '01396-226388', 29.40, 30.80, 79.90, 81.10),
    DistrictBoundingBox(
        'Bageshwar', '01363-220817', 29.70, 30.25, 79.60, 80.20),
    DistrictBoundingBox('Nainital', '01394-231178', 29.10, 29.60, 78.90, 79.80),
    DistrictBoundingBox(
        'Champawat', '01396-230819', 29.10, 29.60, 79.90, 80.40),
    DistrictBoundingBox(
        'Udham Singh Nagar', '01394-250250', 28.70, 29.35, 78.75, 80.10),
  ];

  static const String defaultDeocNumber = '01374-222722';

  static String resolveDistrictName(double lat, double lng) {
    for (final box in districtBoxes) {
      if (box.contains(lat, lng)) return box.district;
    }
    return 'Uttarkashi (Default)';
  }

  static String resolveDistrictDeoc(double lat, double lng) {
    for (final box in districtBoxes) {
      if (box.contains(lat, lng)) return box.deocNumber;
    }
    return defaultDeocNumber;
  }

  /// Returns the SMS dispatch list for the resolved district.
  ///
  /// In test mode, returns only [EmergencyTestConfig.testNumber].
  static List<String> resolveDispatchNumbers(double lat, double lng) {
    if (EmergencyTestConfig.testMode) {
      return [EmergencyTestConfig.testNumber];
    }
    return [
      resolveDistrictDeoc(lat, lng),
      AdminContacts.localDeocTollFree,
      AdminContacts.stateSeocMobile,
    ];
  }

  /// Checks whether a phone number is capable of receiving SMS (mobile numbers in India).
  /// Landline numbers with STD codes (e.g. 01374-222722) and 4-digit toll-free codes (1077)
  /// are voice-only lines and cannot receive SMS.
  static bool isSmsCapable(String number) {
    final cleaned = number.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');
    if (cleaned.startsWith('91') && cleaned.length == 12) {
      final sub = cleaned.substring(2);
      return RegExp(r'^[6-9]\d{9}$').hasMatch(sub);
    }
    if (cleaned.startsWith('0') && cleaned.length == 11) {
      final sub = cleaned.substring(1);
      return RegExp(r'^[6-9]\d{9}$').hasMatch(sub);
    }
    return RegExp(r'^[6-9]\d{9}$').hasMatch(cleaned);
  }

  /// Returns only verified SMS-capable numbers from the resolved dispatch targets.
  static List<String> resolveSmsCapableDispatchNumbers(double lat, double lng) {
    return resolveDispatchNumbers(lat, lng).where(isSmsCapable).toList();
  }
}
