import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:torch_light/torch_light.dart';

enum SosHardwareState { idle, active }

/// Controls the physical SOS beacon: looped siren audio + SOS Morse strobe.
class HardwareSosService {
  static final HardwareSosService _instance = HardwareSosService._internal();
  factory HardwareSosService() => _instance;
  HardwareSosService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();
  Timer? _morseTimer;
  SosHardwareState _state = SosHardwareState.idle;

  // Cached once per session start; torch hardware does not change at runtime.
  bool _torchAvailable = false;

  SosHardwareState get state => _state;

  // SOS in Morse code (... --- ...): alternating ON (ms) and OFF (ms) durations
  static const List<int> _morsePatternMs = [
    200, 200, // Dot 1 ON, pause OFF
    200, 200, // Dot 2 ON, pause OFF
    200, 600, // Dot 3 ON, letter-space OFF ('S')
    600, 200, // Dash 1 ON, pause OFF
    600, 200, // Dash 2 ON, pause OFF
    600, 600, // Dash 3 ON, letter-space OFF ('O')
    200, 200, // Dot 1 ON, pause OFF
    200, 200, // Dot 2 ON, pause OFF
    200, 1400, // Dot 3 ON, word/repeat-space OFF ('S')
  ];

  Future<void> startEmergencyBeacon() async {
    if (_state == SosHardwareState.active) return;
    _state = SosHardwareState.active;

    // Cache torch availability once — eliminates platform-channel round-trip
    // latency from the tight Morse timing loop.
    try {
      _torchAvailable = await TorchLight.isTorchAvailable();
    } catch (_) {
      _torchAvailable = false;
    }

    try {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.setVolume(1.0);
      await _audioPlayer.play(AssetSource('audio/siren.wav'));
    } catch (_) {}

    _runMorseStrobeLoop();
  }

  Future<void> stopEmergencyBeacon() async {
    _state = SosHardwareState.idle;
    _morseTimer?.cancel();
    _morseTimer = null;

    try {
      await _audioPlayer.stop();
    } catch (_) {}

    if (_torchAvailable) {
      try {
        await TorchLight.disableTorch();
      } catch (_) {}
    }
  }

  Future<void> _runMorseStrobeLoop() async {
    int stepIndex = 0;
    while (_state == SosHardwareState.active) {
      final duration = _morsePatternMs[stepIndex];
      final bool isOn = stepIndex % 2 == 0;

      if (_torchAvailable) {
        try {
          if (isOn) {
            await TorchLight.enableTorch();
          } else {
            await TorchLight.disableTorch();
          }
        } catch (_) {}
      }

      await Future.delayed(Duration(milliseconds: duration));
      if (_state != SosHardwareState.active) break;
      stepIndex = (stepIndex + 1) % _morsePatternMs.length;
    }

    if (_torchAvailable) {
      try {
        await TorchLight.disableTorch();
      } catch (_) {}
    }
  }

  void dispose() {
    stopEmergencyBeacon();
    _audioPlayer.dispose();
  }
}
