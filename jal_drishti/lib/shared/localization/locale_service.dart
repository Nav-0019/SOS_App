import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// Reactive signal holding the active language code ('en' or 'hi').
final localeSignal = signal<String>('en');

/// Service to manage app language and provide localized strings.
class LocaleService {
  static final LocaleService _instance = LocaleService._internal();
  factory LocaleService() => _instance;
  LocaleService._internal();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const String _storageKey = 'app_locale';

  bool get isHindi => localeSignal.value == 'hi';
  String get currentLanguage => localeSignal.value;

  /// Initializes stored locale preference on app startup.
  Future<void> initialize() async {
    try {
      final savedLocale = await _storage.read(key: _storageKey);
      if (savedLocale != null && (savedLocale == 'en' || savedLocale == 'hi')) {
        localeSignal.value = savedLocale;
      }
    } catch (_) {}
  }

  /// Sets language code ('en' or 'hi') and persists choice.
  Future<void> setLocale(String langCode) async {
    if (langCode != 'en' && langCode != 'hi') return;
    localeSignal.value = langCode;
    try {
      await _storage.write(key: _storageKey, value: langCode);
    } catch (_) {}
  }

  /// Toggles between English and Hindi.
  Future<void> toggleLocale() async {
    final next = isHindi ? 'en' : 'hi';
    await setLocale(next);
  }
}

/// Central translation dictionary for English and Hindi.
class AppStrings {
  AppStrings._();

  static String tr(String key) {
    final lang = localeSignal.value;
    final dict = lang == 'hi' ? _hi : _en;
    return dict[key] ?? _en[key] ?? key;
  }

  static const Map<String, String> _en = {
    // Navigation
    'nav_map': 'Map',
    'nav_sos': 'SOS',
    'nav_mesh': 'Mesh',
    'nav_assistant': 'Assistant',
    'nav_weather': 'Weather',
    'nav_anomalies': 'Anomalies',

    // Language Toggle
    'lang_name': 'English',
    'lang_switch_hint': 'Switch to हिन्दी',

    // Assistant Screen
    'assistant_title': 'EMERGENCY ASSISTANT',
    'search_hint': 'Search procedures',
    'boarding_info': 'Boarding info',
    'procedures_count': 'procedures (zero-cloud)',
    'reach_out': 'Reach out',
    'directory_info': 'Info',
    'no_procedures_found': 'No matching emergency procedure found.',
    'action_steps': 'ACTION STEPS:',
    'warnings': 'WARNINGS:',
    'listen': 'Listen',
    'listening': 'Speaking...',
    'stop': 'Stop',
    'understood': 'Understood',
    'close': 'Close',

    // Boarding Modal
    'boarding_modal_title': 'Boarding & Evacuation Info',
    'boarding_modal_subtitle': 'Essential Flash-Flood Emergency Kit (Zero-Cloud Offline Checklist):',
    'listen_checklist': 'Listen to Checklist',
    'check_doc': 'Government Photo ID & Family Documents in sealed pouch',
    'check_ration': '3-day dry rations & 3 liters bottled drinking water per person',
    'check_med': 'Essential prescription medications, antiseptic, gauze bandage',
    'check_power': 'Charged power bank, whistle, and waterproof torch',
    'check_poncho': 'High-visibility poncho / warm waterproof layer for mountain terrain',

    // Directory Modal
    'directory_modal_title': 'Emergency Directory (Uttarakhand)',
    'hotline_national': 'National Emergency Helpline',
    'hotline_seoc': 'Uttarakhand State Disaster Control (SEOC)',
    'hotline_ambulance': 'State Emergency Medical / Ambulance',
    'hotline_sdrf': 'State Disaster Response Force (SDRF UK)',
    'hotline_women': 'Women Safety Helpline',
    'test_mode_notice': 'TEST MODE: Real Emergency Services BLOCKED. All dispatches -> 7310347742.',

    // SOS Screen
    'sos_active': 'SOS ACTIVE',
    'sos_ready': 'SOS READY',
    'tap_to_activate': 'TAP TO ACTIVATE',
    'tap_to_cancel': 'TAP TO CANCEL',
    'sos_siren': 'SIREN',
    'sos_strobe': 'STROBE',
    'sos_sms': 'SMS',
    'sos_mesh': 'MESH',
    'quick_presets': 'QUICK RESCUE PRESETS',
    'selected_preset': 'Selected preset: ',
    'edit_message': 'Edit Emergency Message',
    'update': 'Update',
    'cancel': 'Cancel',
    'voice_alert': 'Voice Broadcast',
    'voice_alert_on': 'Voice Alert ON',
    'voice_alert_off': 'Voice Alert OFF',
    'voice_read_distress': 'Announce SOS via Speaker',
    'sos_default_msg': 'Trapped near ridge trail, need help. GPS locked.',
    'preset_trapped': 'Trapped near ridge trail, need help. GPS locked.',
    'preset_medical': 'Severe medical emergency, immediate medical evacuation required.',
    'preset_flood': 'Flood water rising fast, stranded on high ground or roof.',
    'preset_rubble': 'Trapped under rubble or debris after landslide.',

    // Mesh Chat Screen
    'mesh_title': 'BLE MESH NETWORK',
    'mesh_scanning': 'Scanning for nearby peers...',
    'mesh_not_scanning': 'Scanner Idle',
    'mesh_input_hint': 'Broadcast emergency message...',
    'mesh_empty': 'No mesh packets received yet.\nStart scanning to discover peers.',
    'mesh_read_aloud': 'Read Aloud',
    'mesh_canned_title': 'Canned Broadcasts',

    // Map Screen
    'map_search_hint': 'Search shelters, hospitals, rivers...',
    'map_blockage': 'Report Blockage',
    'map_shelter': 'Shelter',
    'map_hospital': 'Hospital',
    'map_river': 'River',
    'map_navigate': 'Directions',
    'map_distance': 'Distance',
  };

  static const Map<String, String> _hi = {
    // Navigation
    'nav_map': 'मानचित्र',
    'nav_sos': 'आपातकाल',
    'nav_mesh': 'मेश',
    'nav_assistant': 'सहायक',
    'nav_weather': 'मौसम',
    'nav_anomalies': 'विसंगतियां',

    // Language Toggle
    'lang_name': 'हिन्दी',
    'lang_switch_hint': 'Switch to English',

    // Assistant Screen
    'assistant_title': 'आपातकालीन सहायक',
    'search_hint': 'प्राथमिक उपचार खोजें...',
    'boarding_info': 'निकासी व तैयारी जानकारी',
    'procedures_count': 'प्रक्रियाएं (ऑफ़लाइन उपलब्ध)',
    'reach_out': 'मदद मांगें',
    'directory_info': 'हेल्पलाइन जानकारी',
    'no_procedures_found': 'कोई संबंधित आपातकालीन प्रक्रिया नहीं मिली।',
    'action_steps': 'कार्रवाई के चरण:',
    'warnings': 'सावधानियां:',
    'listen': 'सुनें',
    'listening': 'चल रहा है...',
    'stop': 'रोकें',
    'understood': 'समझ गया',
    'close': 'बंद करें',

    // Boarding Modal
    'boarding_modal_title': 'निकासी और तैयारी जानकारी',
    'boarding_modal_subtitle': 'फ्लैश-फ्लड आपातकालीन किट (पूर्ण ऑफ़लाइन चेकलिस्ट):',
    'listen_checklist': 'चेकलिस्ट सुनें',
    'check_doc': 'सील बंद वाटरप्रूफ बैग में सरकारी पहचान पत्र व पारिवारिक दस्तावेज',
    'check_ration': 'प्रति व्यक्ति 3 दिन का सूखा राशन और 3 लीटर पीने का पानी',
    'check_med': 'आवश्यक दवाएं, एंटीसेप्टिक लोशन व रोगाणुरोधी पट्टी',
    'check_power': 'चार्ज किया हुआ पावर बैंक, सीटी और वाटरप्रूफ टॉर्च',
    'check_poncho': 'पहाड़ी इलाके के लिए वाटरप्रूफ रेनकोट या गर्म वाटरप्रूफ कपड़े',

    // Directory Modal
    'directory_modal_title': 'आपातकालीन निर्देशिका (उत्तराखंड)',
    'hotline_national': 'राष्ट्रीय आपातकालीन हेल्पलाइन',
    'hotline_seoc': 'उत्तराखंड राज्य आपदा नियंत्रण (SEOC)',
    'hotline_ambulance': 'राज्य आपातकालीन चिकित्सा / एम्बुलेंस',
    'hotline_sdrf': 'राज्य आपदा प्रतिवादन बल (SDRF UK)',
    'hotline_women': 'महिला सुरक्षा हेल्पलाइन',
    'test_mode_notice': 'परीक्षण मोड: आपातकालीन सेवाएं अवरुद्ध हैं। सभी कॉल 7310347742 पर जाएंगी।',

    // SOS Screen
    'sos_active': 'आपातकाल सक्रिय',
    'sos_ready': 'SOS तैयार है',
    'tap_to_activate': 'सक्रिय करने के लिए दबाएं',
    'tap_to_cancel': 'रद्द करने के लिए दबाएं',
    'sos_siren': 'सायरन',
    'sos_strobe': 'फ़्लैश',
    'sos_sms': 'एसएमएस',
    'sos_mesh': 'मेश',
    'quick_presets': 'त्वरित बचाव संदेश',
    'selected_preset': 'चयनित संदेश: ',
    'edit_message': 'आपातकालीन संदेश बदलें',
    'update': 'अपडेट करें',
    'cancel': 'रद्द करें',
    'voice_alert': 'ध्वनि प्रसारण',
    'voice_alert_on': 'ध्वनि चेतावनी चालू',
    'voice_alert_off': 'ध्वनि चेतावनी बंद',
    'voice_read_distress': 'स्पीकर पर SOS संदेश बोलें',
    'sos_default_msg': 'पहाड़ी रास्ते के पास फंसे हैं, तुरंत सहायता चाहिए। जीपीएस लॉक।',
    'preset_trapped': 'पहाड़ी रास्ते के पास फंसे हैं, तुरंत सहायता चाहिए। जीपीएस लॉक।',
    'preset_medical': 'गंभीर चिकित्सा आपातकाल, तत्काल एयरलिफ्ट/एंबुलेंस आवश्यक है।',
    'preset_flood': 'बाढ़ का पानी तेजी से बढ़ रहा है, छत या ऊंचाई पर फंसे हैं।',
    'preset_rubble': 'भूस्खलन के बाद मलबे में फंसे हैं, बचाव दल तुरंत भेजें।',

    // Mesh Chat Screen
    'mesh_title': 'ब्लूटूथ मेश नेटवर्क',
    'mesh_scanning': 'आसपास के उपकरणों की खोज जारी...',
    'mesh_not_scanning': 'स्कैनर बंद है',
    'mesh_input_hint': 'मेश पर आपातकालीन संदेश भेजें...',
    'mesh_empty': 'अभी तक कोई मेश संदेश नहीं मिला।\nउपकरण खोजने के लिए स्कैन शुरू करें।',
    'mesh_read_aloud': 'संदेश सुनें',
    'mesh_canned_title': 'पूर्वनिर्धारित संदेश',

    // Map Screen
    'map_search_hint': 'राहत शिविर, अस्पताल, नदियां खोजें...',
    'map_blockage': 'सड़क अवरोध दर्ज करें',
    'map_shelter': 'राहत शिविर',
    'map_hospital': 'अस्पताल',
    'map_river': 'नदी',
    'map_navigate': 'दिशा-निर्देश',
    'map_distance': 'दूरी',
  };
}
