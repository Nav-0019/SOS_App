import 'package:flutter_tts/flutter_tts.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../localization/locale_service.dart';

/// Reactive signal indicating whether TTS is actively speaking.
final ttsSpeakingSignal = signal<bool>(false);

/// Reactive signal holding the identifier of the content currently being spoken (e.g. procedure ID).
final ttsActiveIdSignal = signal<String?>(null);

/// Singleton Text-to-Speech service for offline voice readouts.
class TtsService {
  static final TtsService _instance = TtsService._internal();
  factory TtsService() => _instance;
  TtsService._internal();

  final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      await _flutterTts.setSpeechRate(0.48); // Clear, measured speed for emergency procedures
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);

      _flutterTts.setStartHandler(() {
        ttsSpeakingSignal.value = true;
      });

      _flutterTts.setCompletionHandler(() {
        ttsSpeakingSignal.value = false;
        ttsActiveIdSignal.value = null;
      });

      _flutterTts.setCancelHandler(() {
        ttsSpeakingSignal.value = false;
        ttsActiveIdSignal.value = null;
      });

      _flutterTts.setErrorHandler((msg) {
        ttsSpeakingSignal.value = false;
        ttsActiveIdSignal.value = null;
      });

      _isInitialized = true;
    } catch (_) {}
  }

  /// Speaks [text]. If [id] is provided, tracks it so UI can display active speaking state.
  /// If [language] is not specified, uses the app's active [localeSignal] ('hi' -> 'hi-IN', 'en' -> 'en-IN').
  Future<void> speak(String text, {String? id, String? language}) async {
    if (text.trim().isEmpty) return;

    await initialize();

    // If already speaking this item, toggle stop
    if (ttsSpeakingSignal.value && ttsActiveIdSignal.value == id && id != null) {
      await stop();
      return;
    }

    try {
      await stop();

      final targetLang = language ?? (localeSignal.value == 'hi' ? 'hi-IN' : 'en-IN');
      try {
        await _flutterTts.setLanguage(targetLang);
      } catch (_) {
        // Fallback to en-US if specific locale fails
        await _flutterTts.setLanguage('en-US');
      }

      ttsActiveIdSignal.value = id;
      ttsSpeakingSignal.value = true;

      await _flutterTts.speak(text);
    } catch (_) {
      ttsSpeakingSignal.value = false;
      ttsActiveIdSignal.value = null;
    }
  }

  /// Immediately halts speech.
  Future<void> stop() async {
    try {
      await _flutterTts.stop();
    } catch (_) {}
    ttsSpeakingSignal.value = false;
    ttsActiveIdSignal.value = null;
  }
}
