/// Central Emergency Test Configuration.
///
/// When [testMode] is true, ALL emergency calls, SMS, messages, and dispatches
/// generated during development/testing are routed ONLY to [testNumber].
/// Real emergency services (DEOC, SEOC, SDRF, NDRF, police, etc.) are strictly BLOCKED.
class EmergencyTestConfig {
  static const bool testMode = true;
  static const String testNumber = '7310347742';
}
