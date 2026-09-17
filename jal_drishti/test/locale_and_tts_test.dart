import 'package:flutter_test/flutter_test.dart';
import 'package:jal_drishti/shared/localization/locale_service.dart';
import 'package:jal_drishti/features/assistant/services/assistant_search_service.dart';
import 'package:jal_drishti/shared/services/tts_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LocaleService & AppStrings tests', () {
    setUp(() {
      localeSignal.value = 'en';
    });

    test('Default locale is English', () {
      expect(localeSignal.value, 'en');
      expect(LocaleService().isHindi, false);
      expect(AppStrings.tr('nav_map'), 'Map');
      expect(AppStrings.tr('nav_sos'), 'SOS');
      expect(AppStrings.tr('listen'), 'Listen');
    });

    test('Switching to Hindi updates strings reactively', () {
      localeSignal.value = 'hi';
      expect(LocaleService().isHindi, true);
      expect(AppStrings.tr('nav_map'), 'मानचित्र');
      expect(AppStrings.tr('nav_sos'), 'आपातकाल');
      expect(AppStrings.tr('nav_mesh'), 'मेश');
      expect(AppStrings.tr('nav_assistant'), 'सहायक');
      expect(AppStrings.tr('listen'), 'सुनें');
      expect(AppStrings.tr('stop'), 'रोकें');
      expect(AppStrings.tr('assistant_title'), 'आपातकालीन सहायक');
    });

    test('toggleLocale switches between English and Hindi', () async {
      localeSignal.value = 'en';
      await LocaleService().toggleLocale();
      expect(localeSignal.value, 'hi');
      await LocaleService().toggleLocale();
      expect(localeSignal.value, 'en');
    });
  });

  group('MedicalQaItem Bilingual & TTS Transcript tests', () {
    final sampleJson = {
      "id": "QA_DROWNING_TEST",
      "category": "Drowning & Submersion",
      "category_hi": "डूबना व जलमग्नता",
      "keywords": ["drowning", "water"],
      "keywords_hi": ["डूबना", "पानी"],
      "title": "Drowning First-Aid",
      "title_hi": "डूबने पर प्राथमिक उपचार",
      "steps": ["1. Check airway", "2. Give breaths"],
      "steps_hi": ["1. वायुमार्ग जांचें", "2. सांस दें"],
      "warnings": ["Do not attempt Heimlich"],
      "warnings_hi": ["हेमलिच पैंतरे का प्रयास न करें"]
    };

    test('Parses English and Hindi fields accurately', () {
      final item = MedicalQaItem.fromJson(sampleJson);

      expect(item.localizedTitle('en'), 'Drowning First-Aid');
      expect(item.localizedTitle('hi'), 'डूबने पर प्राथमिक उपचार');

      expect(item.localizedCategory('en'), 'Drowning & Submersion');
      expect(item.localizedCategory('hi'), 'डूबना व जलमग्नता');

      expect(item.localizedSteps('en').first, '1. Check airway');
      expect(item.localizedSteps('hi').first, '1. वायुमार्ग जांचें');

      expect(item.localizedWarnings('en').first, 'Do not attempt Heimlich');
      expect(item.localizedWarnings('hi').first, 'हेमलिच पैंतरे का प्रयास न करें');
    });

    test('buildSpeechTranscript formats cleanly for TTS engine', () {
      final item = MedicalQaItem.fromJson(sampleJson);

      final enTranscript = item.buildSpeechTranscript('en');
      expect(enTranscript.contains('Drowning First-Aid'), true);
      expect(enTranscript.contains('Critical warnings:'), true);
      expect(enTranscript.contains('Action steps:'), true);

      final hiTranscript = item.buildSpeechTranscript('hi');
      expect(hiTranscript.contains('डूबने पर प्राथमिक उपचार'), true);
      expect(hiTranscript.contains('महत्वपूर्ण चेतावनी:'), true);
      expect(hiTranscript.contains('कार्रवाई के चरण:'), true);
    });
  });

  group('TtsService State & Signal tests', () {
    test('Initial TTS state signals are idle', () {
      expect(ttsSpeakingSignal.value, false);
      expect(ttsActiveIdSignal.value, null);
    });

    test('TtsService stop resets signals', () async {
      ttsSpeakingSignal.value = true;
      ttsActiveIdSignal.value = 'TEST_ID';

      await TtsService().stop();

      expect(ttsSpeakingSignal.value, false);
      expect(ttsActiveIdSignal.value, null);
    });
  });
}
