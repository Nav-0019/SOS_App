import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../../../../app/router/app_router.dart';
import '../../../../app/theme/amoled_theme.dart';
import '../../services/assistant_search_service.dart';
import '../../../sos/config/emergency_test_config.dart';
import '../../../../shared/localization/locale_service.dart';
import '../../../../shared/localization/language_toggle_button.dart';
import '../../../../shared/services/tts_service.dart';

class AssistantScreen extends StatefulWidget {
  const AssistantScreen({super.key});

  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {
  final _searchService = AssistantSearchService();
  final _searchController = TextEditingController();
  List<MedicalQaItem> _filteredResults = [];
  String? _expandedItemId;

  @override
  void initState() {
    super.initState();
    _searchService.initialize().then((_) {
      if (mounted) {
        setState(() {
          _filteredResults = _searchService.search('');
        });
      }
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _filteredResults = _searchService.search(query);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    TtsService().stop();
    super.dispose();
  }

  void _showBoardingInfoModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AmoledColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        side: BorderSide(color: AmoledColors.border),
      ),
      builder: (ctx) => Watch((context) {
        final lang = localeSignal.value;
        final isSpeakingChecklist = ttsSpeakingSignal.value && ttsActiveIdSignal.value == 'CHECKLIST_MODAL';

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.luggage,
                      color: AmoledColors.warningYellow, size: 22),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      AppStrings.tr('boarding_modal_title'),
                      style: const TextStyle(
                        color: AmoledColors.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  // TTS Checklist Speak Button
                  InkWell(
                    onTap: () {
                      if (isSpeakingChecklist) {
                        TtsService().stop();
                      } else {
                        final buffer = StringBuffer();
                        buffer.writeln(AppStrings.tr('boarding_modal_title'));
                        buffer.writeln(AppStrings.tr('boarding_modal_subtitle'));
                        buffer.writeln('1. ${AppStrings.tr('check_doc')}');
                        buffer.writeln('2. ${AppStrings.tr('check_ration')}');
                        buffer.writeln('3. ${AppStrings.tr('check_med')}');
                        buffer.writeln('4. ${AppStrings.tr('check_power')}');
                        buffer.writeln('5. ${AppStrings.tr('check_poncho')}');

                        TtsService().speak(
                          buffer.toString(),
                          id: 'CHECKLIST_MODAL',
                          language: lang == 'hi' ? 'hi-IN' : 'en-IN',
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSpeakingChecklist
                            ? AmoledColors.sosDanger.withValues(alpha: 0.2)
                            : AmoledColors.cardDark,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSpeakingChecklist
                              ? AmoledColors.sosDanger
                              : AmoledColors.safeShelter.withValues(alpha: 0.6),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isSpeakingChecklist ? Icons.stop : Icons.volume_up,
                            size: 14,
                            color: isSpeakingChecklist
                                ? AmoledColors.sosDanger
                                : AmoledColors.safeShelter,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isSpeakingChecklist ? AppStrings.tr('stop') : AppStrings.tr('listen'),
                            style: TextStyle(
                              color: isSpeakingChecklist
                                  ? AmoledColors.sosDanger
                                  : AmoledColors.safeShelter,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.tr('boarding_modal_subtitle'),
                style: const TextStyle(color: AmoledColors.textSecondary, fontSize: 11.5),
              ),
              const SizedBox(height: 10),
              _buildChecklistItem(AppStrings.tr('check_doc')),
              _buildChecklistItem(AppStrings.tr('check_ration')),
              _buildChecklistItem(AppStrings.tr('check_med')),
              _buildChecklistItem(AppStrings.tr('check_power')),
              _buildChecklistItem(AppStrings.tr('check_poncho')),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AmoledColors.warningYellow,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    if (isSpeakingChecklist) TtsService().stop();
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    AppStrings.tr('understood'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildChecklistItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle,
              color: AmoledColors.safeShelter, size: 15),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  color: AmoledColors.textPrimary, fontSize: 11.5),
            ),
          ),
        ],
      ),
    );
  }

  void _showEmergencyInfoModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AmoledColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        side: BorderSide(color: AmoledColors.border),
      ),
      builder: (ctx) => Watch((context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.info_outline,
                      color: AmoledColors.safeShelter, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    AppStrings.tr('directory_modal_title'),
                    style: const TextStyle(
                      color: AmoledColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (EmergencyTestConfig.testMode) ...[
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AmoledColors.warningYellow.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: AmoledColors.warningYellow.withValues(alpha: 0.6)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.shield_outlined,
                          color: AmoledColors.warningYellow, size: 16),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          AppStrings.tr('test_mode_notice'),
                          style: const TextStyle(
                            color: AmoledColors.warningYellow,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildHotlineRow(AppStrings.tr('hotline_national'),
                    EmergencyTestConfig.testNumber),
                _buildHotlineRow(AppStrings.tr('hotline_seoc'),
                    EmergencyTestConfig.testNumber),
                _buildHotlineRow(AppStrings.tr('hotline_ambulance'),
                    EmergencyTestConfig.testNumber),
                _buildHotlineRow(AppStrings.tr('hotline_sdrf'),
                    EmergencyTestConfig.testNumber),
                _buildHotlineRow(
                    AppStrings.tr('hotline_women'), EmergencyTestConfig.testNumber),
              ] else ...[
                _buildHotlineRow(AppStrings.tr('hotline_national'), '112'),
                _buildHotlineRow(AppStrings.tr('hotline_seoc'),
                    '1070 / 0135-2710334'),
                _buildHotlineRow(AppStrings.tr('hotline_ambulance'), '108'),
                _buildHotlineRow(
                    AppStrings.tr('hotline_sdrf'), '0135-2710335'),
                _buildHotlineRow(AppStrings.tr('hotline_women'), '1090'),
              ],
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AmoledColors.surface,
                    foregroundColor: AmoledColors.safeShelter,
                    side: const BorderSide(color: AmoledColors.border),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(AppStrings.tr('close')),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHotlineRow(String title, String number) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style:
                  const TextStyle(color: AmoledColors.textPrimary, fontSize: 12),
            ),
          ),
          Text(
            number,
            style: const TextStyle(
              color: AmoledColors.safeShelter,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      final currentLang = localeSignal.value;
      final activeTtsId = ttsActiveIdSignal.value;
      final isTtsSpeaking = ttsSpeakingSignal.value;

      return Scaffold(
        backgroundColor: AmoledColors.background,
        appBar: AppBar(
          title: Text(AppStrings.tr('assistant_title')),
          centerTitle: true,
          actions: const [
            LanguageToggleButton(),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: AmoledColors.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AmoledColors.border),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Row(
                    children: [
                      const Icon(Icons.search,
                          size: 16, color: AmoledColors.safeShelter),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: _onSearchChanged,
                          style: const TextStyle(
                              color: AmoledColors.textPrimary, fontSize: 12),
                          decoration: InputDecoration(
                            hintText: AppStrings.tr('search_hint'),
                            hintStyle: const TextStyle(
                                color: AmoledColors.textSecondary, fontSize: 12),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                      if (_searchController.text.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.clear,
                              size: 14, color: AmoledColors.textSecondary),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            _searchController.clear();
                            _onSearchChanged('');
                          },
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // Boarding Info Button
                InkWell(
                  onTap: _showBoardingInfoModal,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: AmoledColors.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AmoledColors.border),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.luggage,
                            size: 16, color: AmoledColors.warningYellow),
                        const SizedBox(width: 8),
                        Text(
                          AppStrings.tr('boarding_info'),
                          style: const TextStyle(
                            color: AmoledColors.textSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.chevron_right,
                            size: 16, color: AmoledColors.textMuted),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Procedures count
                Text(
                  '${_filteredResults.length} ${AppStrings.tr('procedures_count')}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AmoledColors.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),

                // Procedure list with bilingual cards and TTS
                Expanded(
                  child: _filteredResults.isEmpty
                      ? Center(
                          child: Text(
                            AppStrings.tr('no_procedures_found'),
                            style: const TextStyle(
                                color: AmoledColors.textSecondary,
                                fontSize: 12),
                          ),
                        )
                      : ListView.separated(
                          itemCount: _filteredResults.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                          itemBuilder: (ctx, idx) {
                            final item = _filteredResults[idx];
                            final isExpanded = _expandedItemId == item.id;
                            final isSpeakingThis =
                                isTtsSpeaking && activeTtsId == item.id;

                            final displayTitle =
                                item.localizedTitle(currentLang);
                            final displayCategory =
                                item.localizedCategory(currentLang);
                            final displaySteps =
                                item.localizedSteps(currentLang);
                            final displayWarnings =
                                item.localizedWarnings(currentLang);

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _expandedItemId =
                                      isExpanded ? null : item.id;
                                });
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AmoledColors.cardDark,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSpeakingThis
                                        ? AmoledColors.safeShelter
                                        : (isExpanded
                                            ? AmoledColors.safeShelter
                                                .withValues(alpha: 0.6)
                                            : AmoledColors.border),
                                    width: isSpeakingThis ? 1.5 : 1.0,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                displayTitle,
                                                style: const TextStyle(
                                                  color:
                                                      AmoledColors.textPrimary,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 3),
                                              Text(
                                                displayCategory.toUpperCase(),
                                                style: const TextStyle(
                                                  color:
                                                      AmoledColors.safeShelter,
                                                  fontSize: 9.5,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8),

                                        // Text-to-Speech Speak/Stop button
                                        InkWell(
                                          onTap: () {
                                            if (isSpeakingThis) {
                                              TtsService().stop();
                                            } else {
                                              final speechText = item
                                                  .buildSpeechTranscript(
                                                      currentLang);
                                              TtsService().speak(
                                                speechText,
                                                id: item.id,
                                                language: currentLang == 'hi'
                                                    ? 'hi-IN'
                                                    : 'en-IN',
                                              );
                                            }
                                          },
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: isSpeakingThis
                                                  ? AmoledColors.sosDanger
                                                      .withValues(alpha: 0.2)
                                                  : AmoledColors.surface,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              border: Border.all(
                                                color: isSpeakingThis
                                                    ? AmoledColors.sosDanger
                                                    : AmoledColors.safeShelter
                                                        .withValues(alpha: 0.7),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  isSpeakingThis
                                                      ? Icons.stop_circle
                                                      : Icons.volume_up,
                                                  size: 13,
                                                  color: isSpeakingThis
                                                      ? AmoledColors.sosDanger
                                                      : AmoledColors
                                                          .safeShelter,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  isSpeakingThis
                                                      ? AppStrings.tr('stop')
                                                      : AppStrings.tr('listen'),
                                                  style: TextStyle(
                                                    color: isSpeakingThis
                                                        ? AmoledColors.sosDanger
                                                        : AmoledColors
                                                            .safeShelter,
                                                    fontSize: 10.5,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Icon(
                                          isExpanded
                                              ? Icons.expand_less
                                              : Icons.expand_more,
                                          size: 18,
                                          color: isExpanded
                                              ? AmoledColors.safeShelter
                                              : AmoledColors.textMuted,
                                        ),
                                      ],
                                    ),
                                    if (isExpanded) ...[
                                      const SizedBox(height: 10),
                                      const Divider(
                                          color: AmoledColors.border,
                                          height: 1),
                                      if (displayWarnings.isNotEmpty) ...[
                                        const SizedBox(height: 8),
                                        Text(
                                          AppStrings.tr('warnings'),
                                          style: const TextStyle(
                                            color: AmoledColors.warningYellow,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.8,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        ...displayWarnings.map(
                                          (warning) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 4.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Icon(
                                                  Icons.warning_amber_rounded,
                                                  color: AmoledColors
                                                      .warningYellow,
                                                  size: 13,
                                                ),
                                                const SizedBox(width: 6),
                                                Expanded(
                                                  child: Text(
                                                    warning,
                                                    style: const TextStyle(
                                                      color: AmoledColors
                                                          .warningYellow,
                                                      fontSize: 11,
                                                      height: 1.3,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                      const SizedBox(height: 8),
                                      Text(
                                        AppStrings.tr('action_steps'),
                                        style: const TextStyle(
                                          color: AmoledColors.textSecondary,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      ...displaySteps.map(
                                        (step) => Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                '• ',
                                                style: TextStyle(
                                                  color:
                                                      AmoledColors.safeShelter,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  step,
                                                  style: const TextStyle(
                                                    color: AmoledColors
                                                        .textPrimary,
                                                    fontSize: 11.5,
                                                    height: 1.35,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                const SizedBox(height: 8),

                // Reach out button
                InkWell(
                  onTap: () {
                    AppRouter.switchTab(2);
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
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
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          size: 14,
                          color: AmoledColors.safeShelter,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6),

                // Info button
                InkWell(
                  onTap: _showEmergencyInfoModal,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: AmoledColors.cardDark,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AmoledColors.border),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.tr('directory_info'),
                          style: const TextStyle(
                            color: AmoledColors.textPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          Icons.info_outline,
                          size: 14,
                          color: AmoledColors.safeShelter,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ),
      );
    });
  }
}
