import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../app/theme/amoled_theme.dart';
import '../../services/ble_mesh_service.dart';
import '../../../../shared/localization/locale_service.dart';
import '../../../../shared/localization/language_toggle_button.dart';
import '../../../../shared/services/tts_service.dart';

class MeshChatScreen extends StatefulWidget {
  const MeshChatScreen({super.key});

  @override
  State<MeshChatScreen> createState() => _MeshChatScreenState();
}

class _MeshChatScreenState extends State<MeshChatScreen> {
  final _meshService = BleMeshService();
  final _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _meshService.loadSavedMessages();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _meshService.dispose();
    super.dispose();
  }

  Future<void> _toggleScan() async {
    if (_meshService.isScanningSignal.value) {
      await _meshService.stopPeerDiscovery();
    } else {
      final result = await _meshService.startPeerDiscovery();
      if (!mounted) return;
      switch (result) {
        case BleStartSuccess():
          break;
        case BleStartPermissionDenied(:final permanentlyDenied):
          final hasPermanent = permanentlyDenied.values.any((v) => v);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                hasPermanent
                    ? 'Bluetooth permission permanently denied. Open Settings to allow it.'
                    : 'Bluetooth & Location permissions are required for mesh networking.',
              ),
              backgroundColor: AmoledColors.sosDanger,
              duration: const Duration(seconds: 6),
            ),
          );
        case BleStartUnsupported():
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('BLE is not supported on this device.'),
              backgroundColor: AmoledColors.sosDanger,
            ),
          );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      final lang = localeSignal.value;
      final isTtsSpeaking = ttsSpeakingSignal.value;
      final activeTtsId = ttsActiveIdSignal.value;

      return Scaffold(
        backgroundColor: AmoledColors.background,
        appBar: AppBar(
          title: Text(AppStrings.tr('mesh_title')),
          actions: [
            const LanguageToggleButton(),
            Watch((context) {
              final isScanning = _meshService.isScanningSignal.value;
              return IconButton(
                icon: Icon(
                  isScanning ? Icons.stop_circle_outlined : Icons.radar,
                  color: isScanning
                      ? AmoledColors.sosDanger
                      : AmoledColors.safeShelter,
                ),
                tooltip: isScanning
                    ? AppStrings.tr('scanTooltipStop')
                    : AppStrings.tr('scanTooltipStart'),
                onPressed: _toggleScan,
              );
            }),
          ],
        ),
        body: Column(
          children: [
            Watch((context) {
              final count = _meshService.activePeerCountSignal.value;
              final scanning = _meshService.isScanningSignal.value;
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                color: AmoledColors.surface,
                child: Row(
                  children: [
                    if (scanning)
                      const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AmoledColors.safeShelter,
                        ),
                      )
                    else
                      Icon(
                        count > 0
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        size: 14,
                        color: count > 0
                            ? AmoledColors.safeShelter
                            : AmoledColors.textSecondary,
                      ),
                    const SizedBox(width: 8),
                    Text(
                      lang == 'hi'
                          ? '$count उपकरण जुड़े हैं ${scanning ? '— खोज जारी…' : ''}'
                          : '$count PEER${count == 1 ? '' : 'S'} CONNECTED'
                              '${scanning ? ' — SCANNING…' : ''}',
                      style: const TextStyle(
                        color: AmoledColors.textPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            }),
            Expanded(
              child: Watch((context) {
                final msgs = _meshService.meshMessages.value;
                if (msgs.isEmpty) {
                  return Center(
                    child: Text(
                      AppStrings.tr('mesh_empty'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: AmoledColors.textSecondary, fontSize: 13),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: msgs.length,
                  itemBuilder: (ctx, idx) {
                    final m = msgs[idx];
                    final isSpeakingThis = isTtsSpeaking && activeTtsId == m.messageId;

                    return Card(
                      color: AmoledColors.surface,
                      margin: const EdgeInsets.only(bottom: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: isSpeakingThis
                              ? AmoledColors.safeShelter
                              : AmoledColors.border,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    m.senderId,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: AmoledColors.safeShelter,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    // TTS button to read message aloud
                                    InkWell(
                                      onTap: () {
                                        if (isSpeakingThis) {
                                          TtsService().stop();
                                        } else {
                                          TtsService().speak(
                                            m.textPayload,
                                            id: m.messageId,
                                            language: lang == 'hi' ? 'hi-IN' : 'en-IN',
                                          );
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(12),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        child: Icon(
                                          isSpeakingThis ? Icons.stop_circle : Icons.volume_up,
                                          size: 15,
                                          color: isSpeakingThis
                                              ? AmoledColors.sosDanger
                                              : AmoledColors.safeShelter,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              m.textPayload,
                              style: const TextStyle(
                                  color: AmoledColors.textPrimary, fontSize: 13.5),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            Container(
              color: AmoledColors.surface,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      style: const TextStyle(color: AmoledColors.textPrimary),
                      decoration: InputDecoration(
                        hintText: AppStrings.tr('mesh_input_hint'),
                        hintStyle: const TextStyle(color: AmoledColors.textSecondary),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: AmoledColors.safeShelter),
                    onPressed: () {
                      final text = _inputController.text.trim();
                      if (text.isNotEmpty) {
                        _meshService.sendChatMessage(text);
                        _inputController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
