import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../../app/theme/amoled_theme.dart';
import 'locale_service.dart';

/// Clean AMOLED-styled language switch toggle pill (EN | हिन्दी).
class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      final isHindi = localeSignal.value == 'hi';
      return Tooltip(
        message: AppStrings.tr('lang_switch_hint'),
        child: InkWell(
          onTap: () => LocaleService().toggleLocale(),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: AmoledColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AmoledColors.safeShelter.withValues(alpha: 0.6),
                width: 1.0,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.translate,
                  size: 13,
                  color: AmoledColors.safeShelter,
                ),
                const SizedBox(width: 5),
                Text(
                  isHindi ? 'हिन्दी' : 'EN',
                  style: const TextStyle(
                    color: AmoledColors.safeShelter,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  isHindi ? '| EN' : '| हि',
                  style: const TextStyle(
                    color: AmoledColors.textMuted,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
