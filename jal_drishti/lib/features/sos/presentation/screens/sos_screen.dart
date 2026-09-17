import 'dart:async';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../../../../app/router/app_router.dart';
import '../../../../app/theme/amoled_theme.dart';
import '../../controllers/sos_controller.dart';
import '../../../../shared/localization/locale_service.dart';
import '../../../../shared/localization/language_toggle_button.dart';
import '../../../../shared/services/tts_service.dart';

class SosScreen extends StatefulWidget {
  const SosScreen({super.key});

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> {
  final _controller = SosController();
  Timer? _pulseTimer;
  bool _pulseRed = true;
  String _currentMessage = 'Trapped near ridge trail, need help. GPS locked.';

  @override
  void initState() {
    super.initState();
    _pulseTimer = Timer.periodic(const Duration(milliseconds: 250), (_) {
      if (sosStateSignal.value == SosState.active) {
        if (mounted) setState(() => _pulseRed = !_pulseRed);
      }
    });
  }

  @override
  void dispose() {
    _pulseTimer?.cancel();
    super.dispose();
  }

  void _onQuickAction(String title, String message) {
    setState(() {
      _currentMessage = message;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${AppStrings.tr('selected_preset')}"$title"'),
        backgroundColor: AmoledColors.surface,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showEditMessageDialog() {
    final textController = TextEditingController(text: _currentMessage);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AmoledColors.surface,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AmoledColors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          AppStrings.tr('edit_message'),
          style: const TextStyle(color: AmoledColors.textPrimary, fontSize: 15),
        ),
        content: TextField(
          controller: textController,
          maxLines: 3,
          style: const TextStyle(color: AmoledColors.textPrimary, fontSize: 13),
          decoration: InputDecoration(
            filled: true,
            fillColor: AmoledColors.cardDark,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AmoledColors.border),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(AppStrings.tr('cancel'),
                style: const TextStyle(color: AmoledColors.textSecondary)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AmoledColors.safeShelter,
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              if (textController.text.trim().isNotEmpty) {
                setState(() {
                  _currentMessage = textController.text.trim();
                });
              }
              Navigator.of(ctx).pop();
            },
            child: Text(AppStrings.tr('update')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      // Rebuild on locale changes
      final _ = localeSignal.value;
      final state = sosStateSignal.value;
      final countdown = countdownRemainingSignal.value;

      if (state == SosState.active) {
        return _buildActiveSosView();
      }

      if (state == SosState.countdown) {
        return _buildCountdownView(countdown);
      }

      return _buildIdleView();
    });
  }

  Widget _buildIdleView() {
    final lang = localeSignal.value;
    final isSpeakingSos = ttsSpeakingSignal.value && ttsActiveIdSignal.value == 'SOS_VOICE_BROADCAST';

    return Scaffold(
      backgroundColor: AmoledColors.background,
      appBar: AppBar(
        title: Text('${AppStrings.tr('nav_sos')} — ${AppStrings.tr('sos_ready')}'),
        centerTitle: true,
        actions: const [
          LanguageToggleButton(),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Emergency Message Card
              InkWell(
                onTap: _showEditMessageDialog,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AmoledColors.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AmoledColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.tr('edit_message'),
                            style: const TextStyle(
                              color: AmoledColors.textSecondary,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.edit_outlined,
                            size: 13,
                            color: AmoledColors.textSecondary
                                .withValues(alpha: 0.7),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _currentMessage,
                        style: const TextStyle(
                          color: AmoledColors.textPrimary,
                          fontSize: 13,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Voice Announcement Pill
              const SizedBox(height: 10),
              Center(
                child: InkWell(
                  onTap: () {
                    if (isSpeakingSos) {
                      TtsService().stop();
                    } else {
                      final announcement = lang == 'hi'
                          ? 'आपातकालीन सहायता सूचना! स्थिति: $_currentMessage। सहायता दल तुरंत संपर्क करें।'
                          : 'Emergency distress announcement! Status: $_currentMessage. Rescue teams respond immediately.';
                      TtsService().speak(
                        announcement,
                        id: 'SOS_VOICE_BROADCAST',
                        language: lang == 'hi' ? 'hi-IN' : 'en-IN',
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSpeakingSos
                          ? AmoledColors.sosDanger.withValues(alpha: 0.18)
                          : AmoledColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSpeakingSos
                            ? AmoledColors.sosDanger
                            : AmoledColors.safeShelter.withValues(alpha: 0.6),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSpeakingSos ? Icons.stop_circle : Icons.volume_up,
                          size: 15,
                          color: isSpeakingSos
                              ? AmoledColors.sosDanger
                              : AmoledColors.safeShelter,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isSpeakingSos ? AppStrings.tr('stop') : AppStrings.tr('voice_read_distress'),
                          style: TextStyle(
                            color: isSpeakingSos
                                ? AmoledColors.sosDanger
                                : AmoledColors.safeShelter,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 1),

              // SOS Beacon Circle
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _controller.triggerSosWithAdminRouting();
                    },
                    child: Container(
                      width: 124,
                      height: 124,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AmoledColors.sosDanger,
                        boxShadow: [
                          BoxShadow(
                            color:
                                AmoledColors.sosDanger.withValues(alpha: 0.45),
                            blurRadius: 32,
                            spreadRadius: 6,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'SOS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppStrings.tr('tap_to_activate'),
                    style: const TextStyle(
                      fontSize: 11,
                      color: AmoledColors.textSecondary,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 1),

              // Quick presets
              Row(
                children: [
                  Expanded(
                    child: _buildQuickActionCard(
                      icon: Icons.location_on,
                      iconColor: AmoledColors.safeShelter,
                      label: lang == 'hi' ? 'फंसे हैं!' : 'Trapped!',
                      onTap: () => _onQuickAction(
                        lang == 'hi' ? 'फंसे हैं!' : 'Trapped!',
                        AppStrings.tr('preset_trapped'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildQuickActionCard(
                      icon: Icons.medical_services_outlined,
                      iconColor: AmoledColors.warningYellow,
                      label: lang == 'hi' ? 'चिकित्सा' : 'Medical',
                      onTap: () => _onQuickAction(
                        lang == 'hi' ? 'चिकित्सा' : 'Medical',
                        AppStrings.tr('preset_medical'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildQuickActionCard(
                      icon: Icons.water_drop_outlined,
                      iconColor: AmoledColors.hazardOrange,
                      label: lang == 'hi' ? 'बाढ़ जल' : 'Flooding',
                      onTap: () => _onQuickAction(
                        lang == 'hi' ? 'बाढ़ जल' : 'Flooding',
                        AppStrings.tr('preset_flood'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  AppRouter.switchTab(2); // Tab 2 = Mesh
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: AmoledColors.cardDark,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AmoledColors.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.tr('reach_out'),
                        style: const TextStyle(
                          color: AmoledColors.textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: AmoledColors.safeShelter,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        decoration: BoxDecoration(
          color: AmoledColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AmoledColors.border),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: iconColor),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                color: AmoledColors.textPrimary,
                fontSize: 10.5,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountdownView(int countdown) {
    return Scaffold(
      backgroundColor: AmoledColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$countdown',
                style: const TextStyle(
                  color: AmoledColors.sosDanger,
                  fontSize: 110,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.tr('sos_active'),
                style: const TextStyle(
                  color: AmoledColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () => _controller.cancelSosCountdown(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AmoledColors.surface,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: AmoledColors.border),
                  ),
                ),
                child: Text(
                  AppStrings.tr('cancel'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveSosView() {
    final bgColor =
        _pulseRed ? AmoledColors.sosDanger : AmoledColors.background;
    final fgColor = _pulseRed ? Colors.black : AmoledColors.sosDanger;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SOS',
                style: TextStyle(
                  color: fgColor,
                  fontSize: 84,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 6,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.tr('sos_active'),
                style: TextStyle(
                  color: fgColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () => _controller.deactivateSos(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.white38),
                  ),
                ),
                child: Text(
                  AppStrings.tr('tap_to_cancel'),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
