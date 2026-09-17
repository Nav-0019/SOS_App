import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jal_drishti/app/theme/amoled_theme.dart';

void main() {
  testWidgets('AmoledTheme design tokens test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AmoledTheme.theme,
        home: Scaffold(
          backgroundColor: AmoledColors.background,
          body: Container(
            color: AmoledColors.surface,
            child: const Text(
              'OFFLINE EMERGENCY ASSISTANT',
              style: TextStyle(color: AmoledColors.textPrimary),
            ),
          ),
        ),
      ),
    );

    expect(find.text('OFFLINE EMERGENCY ASSISTANT'), findsOneWidget);
  });
}
