import 'config/emergency_test_config.dart';

class AdminContact {
  final String level;
  final List<String> numbers;
  final String role;

  const AdminContact(this.level, this.numbers, this.role);
}

/// Emergency contact registry for Uttarakhand disaster response chain.
///
/// In [EmergencyTestConfig.testMode] all registry entries and resolved numbers
/// point to [EmergencyTestConfig.testNumber] — real government services blocked.
class AdminContacts {
  static const List<AdminContact> productionRegistry = [
    AdminContact('State SEOC Admin', ['0135-2710334', '+919412079088'],
        'State Emergency Operation Centre (USDMA HQ)'),
    AdminContact('SDRF Battalion HQ Admin', ['0135-2412192', '+918077880808'],
        'Tactical Search & Rescue Operations Center'),
    AdminContact('NDRF Control Room Admin', ['011-24363260', '+919711077372'],
        'National Response Force Central Dispatch'),
    AdminContact('Local District Admin (DEOC)', ['1077'],
        'Local District Magistrate Control Room'),
  ];

  static const List<AdminContact> testRegistry = [
    AdminContact(
        'State SEOC Admin [TEST MODE]',
        [EmergencyTestConfig.testNumber],
        'Test Simulation Dispatch (Real Services BLOCKED)'),
    AdminContact(
        'SDRF Battalion HQ Admin [TEST MODE]',
        [EmergencyTestConfig.testNumber],
        'Test Simulation Dispatch (Real Services BLOCKED)'),
    AdminContact(
        'NDRF Control Room Admin [TEST MODE]',
        [EmergencyTestConfig.testNumber],
        'Test Simulation Dispatch (Real Services BLOCKED)'),
    AdminContact(
        'Local District Admin (DEOC) [TEST MODE]',
        [EmergencyTestConfig.testNumber],
        'Test Simulation Dispatch (Real Services BLOCKED)'),
  ];

  static List<AdminContact> get registry =>
      EmergencyTestConfig.testMode ? testRegistry : productionRegistry;

  static String get stateSeocMobile => EmergencyTestConfig.testMode
      ? EmergencyTestConfig.testNumber
      : '+919412079088';

  static String get localDeocTollFree =>
      EmergencyTestConfig.testMode ? EmergencyTestConfig.testNumber : '1077';

  static String get userMobile => EmergencyTestConfig.testNumber;
}
