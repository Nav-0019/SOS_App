import 'package:flutter_test/flutter_test.dart';
import 'package:jal_drishti/features/sos/admin_contacts.dart';
import 'package:jal_drishti/features/sos/config/emergency_test_config.dart';
import 'package:jal_drishti/features/sos/services/admin_routing_service.dart';

void main() {
  group('Emergency Test Mode Safety Suite', () {
    test('Central EmergencyTestConfig validation', () {
      expect(EmergencyTestConfig.testMode, isTrue);
      expect(EmergencyTestConfig.testNumber, '7310347742');
    });

    test('resolveDispatchNumbers() returns ONLY [7310347742] in test mode', () {
      // Dehradun GPS coordinates
      final dehradunTargets = AdminRoutingService.resolveDispatchNumbers(30.3165, 78.0322);
      expect(dehradunTargets, equals(['7310347742']));

      // Uttarkashi GPS coordinates
      final uttarkashiTargets = AdminRoutingService.resolveDispatchNumbers(30.7268, 78.4432);
      expect(uttarkashiTargets, equals(['7310347742']));

      // Chamoli GPS coordinates
      final chamoliTargets = AdminRoutingService.resolveDispatchNumbers(30.4088, 79.3243);
      expect(chamoliTargets, equals(['7310347742']));

      // Outside coordinates (fallback)
      final fallbackTargets = AdminRoutingService.resolveDispatchNumbers(12.9716, 77.5946);
      expect(fallbackTargets, equals(['7310347742']));
    });

    test('District-resolution logic remains fully intact for GPS routing tests', () {
      // Verifies district identification works accurately
      expect(AdminRoutingService.resolveDistrictName(30.3165, 78.0322), 'Dehradun');
      expect(AdminRoutingService.resolveDistrictName(30.7268, 78.4432), 'Uttarkashi');
      expect(AdminRoutingService.resolveDistrictName(30.4088, 79.3243), 'Chamoli');
      expect(AdminRoutingService.resolveDistrictName(30.2844, 78.9811), 'Rudraprayag');
      expect(AdminRoutingService.resolveDistrictName(29.9457, 78.1642), 'Haridwar');

      // Verifies district DEOC lookup retains authentic mapping
      expect(AdminRoutingService.resolveDistrictDeoc(30.3165, 78.0322), '0135-2726066');
      expect(AdminRoutingService.resolveDistrictDeoc(30.7268, 78.4432), '01374-222722');
      expect(AdminRoutingService.resolveDistrictDeoc(30.4088, 79.3243), '01372-251437');
    });

    test('AdminContacts blocks real emergency services when testMode is true', () {
      expect(AdminContacts.stateSeocMobile, EmergencyTestConfig.testNumber);
      expect(AdminContacts.localDeocTollFree, EmergencyTestConfig.testNumber);

      // Verify active registry contains ONLY the test number
      for (final contact in AdminContacts.registry) {
        expect(contact.numbers, equals([EmergencyTestConfig.testNumber]));
        expect(contact.level, contains('[TEST MODE]'));
        expect(contact.numbers.contains('1077'), isFalse);
        expect(contact.numbers.contains('+919412079088'), isFalse);
        expect(contact.numbers.contains('0135-2710334'), isFalse);
        expect(contact.numbers.contains('0135-2412192'), isFalse);
        expect(contact.numbers.contains('011-24363260'), isFalse);
      }

      // Verify authentic productionRegistry is preserved separately
      expect(AdminContacts.productionRegistry.length, 4);
      expect(AdminContacts.productionRegistry.any((c) => c.numbers.contains('+919412079088')), isTrue);
    });
  });
}
