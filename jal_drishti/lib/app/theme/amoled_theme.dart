import 'package:flutter/material.dart';

class AmoledColors {
  AmoledColors._();

  static const background = Color(0xFF0C0C0C);
  static const pureBlack = Color(0xFF000000);
  static const surface = Color(0xFF151515);
  static const cardDark = Color(0xFF111111);
  static const border = Color(0xFF2A2A2A);
  static const navBorder = Color(0xFF1E1E1E);
  static const mapBackground = Color(0xFF0F1A12);
  static const mapBorder = Color(0xFF1E2A20);

  static const sosDanger = Color(0xFFE0273F);
  static const safeShelter = Color(0xFF4ADE80);
  static const warningYellow = Color(0xFFFACC15);
  static const hazardOrange = Color(0xFFF97316);
  static const riverCyan = Color(0xFF38BDF8);

  static const textPrimary = Color(0xFFE5E5E5);
  static const textSecondary = Color(0xFF8A8A8A);
  static const textMuted = Color(0xFF666666);
}

class AmoledTheme {
  AmoledTheme._();

  static ThemeData get theme => ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: AmoledColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AmoledColors.safeShelter,
          surface: AmoledColors.surface,
          error: AmoledColors.sosDanger,
          onPrimary: Colors.black,
          onSurface: AmoledColors.textPrimary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AmoledColors.background,
          foregroundColor: AmoledColors.textPrimary,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AmoledColors.textPrimary,
            letterSpacing: 0.8,
          ),
        ),
        cardTheme: CardThemeData(
          color: AmoledColors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AmoledColors.border, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AmoledColors.background,
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AmoledColors.safeShelter,
              );
            }
            return const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AmoledColors.textMuted,
            );
          }),
        ),
      );
}
