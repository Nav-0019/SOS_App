import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:jal_drishti/app/theme/amoled_theme.dart';
import 'package:jal_drishti/app/router/app_router.dart';
import 'package:jal_drishti/features/map/controllers/map_signal_controller.dart';
import 'package:jal_drishti/features/map/services/map_data_service.dart';

class _FakeHttpOverrides extends HttpOverrides {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = _FakeHttpOverrides();

  group('Amoled Theme & Colors', () {
    test('AMOLED colors match redesign specification', () {
      expect(AmoledColors.background, const Color(0xFF0C0C0C));
      expect(AmoledColors.surface, const Color(0xFF151515));
      expect(AmoledColors.cardDark, const Color(0xFF111111));
      expect(AmoledColors.border, const Color(0xFF2A2A2A));
      expect(AmoledColors.navBorder, const Color(0xFF1E1E1E));
      expect(AmoledColors.mapBackground, const Color(0xFF0F1A12));
      expect(AmoledColors.sosDanger, const Color(0xFFE0273F));
      expect(AmoledColors.safeShelter, const Color(0xFF4ADE80));
      expect(AmoledColors.warningYellow, const Color(0xFFFACC15));
      expect(AmoledColors.hazardOrange, const Color(0xFFF97316));
    });
  });

  group('MapSignalController & Features', () {
    final controller = MapSignalController();

    test('Initializes with Dehradun default center and redesign defaults', () {
      expect(controller.currentLocationSignal.value.latitude, closeTo(30.3165, 0.01));
      expect(controller.currentLocationSignal.value.longitude, closeTo(78.0322, 0.01));
      expect(controller.showHospitalsSignal.value, isTrue);
      expect(controller.showRiversSignal.value, isTrue);
      expect(controller.showSheltersSignal.value, isFalse);
      expect(controller.showBoundariesSignal.value, isFalse);
      expect(controller.isMarkingBlockageSignal.value, isFalse);
    });

    test('Toggles layer visibility correctly', () {
      controller.toggleShelters(true);
      expect(controller.showSheltersSignal.value, isTrue);
      controller.toggleShelters(false);
      expect(controller.showSheltersSignal.value, isFalse);
    });

    test('Supports adding and removing blockage flags', () {
      const pos = LatLng(30.1234, 78.5678);
      controller.addBlockage(pos, note: 'Landslide on bypass');
      expect(controller.blockagesSignal.value.length, greaterThanOrEqualTo(1));
      final lastBlockage = controller.blockagesSignal.value.last;
      expect(lastBlockage.note, 'Landslide on bypass');
      expect(lastBlockage.location, pos);

      controller.removeBlockage(lastBlockage.id);
      expect(
        controller.blockagesSignal.value.any((b) => b.id == lastBlockage.id),
        isFalse,
      );
    });

    test('POI Model JSON deserialization', () {
      final jsonHospital = {
        'id': 'hosp_test',
        'name': 'AIIMS Rishikesh',
        'type': 'hospital',
        'latitude': 30.0754,
        'longitude': 78.2882,
        'phone': '+91 135 2462929',
      };
      final hospital = HospitalPoi.fromJson(jsonHospital);
      expect(hospital.name, 'AIIMS Rishikesh');
      expect(hospital.location.latitude, closeTo(30.0754, 0.001));

      final jsonCapital = {
        'id': 'cap_uk',
        'name': 'Dehradun',
        'fullName': 'Dehradun (M.Corp)',
        'stateCode': 'UK',
        'district': 'Dehradun',
        'isStateCapital': true,
        'latitude': 30.3243,
        'longitude': 78.0419,
      };
      final capital = StateCapitalPoi.fromJson(jsonCapital);
      expect(capital.name, 'Dehradun');
      expect(capital.isStateCapital, isTrue);
    });
  });

  group('App Navigation Shell', () {
    test('AppRouter programmatic tab switching', () {
      expect(activeTabSignal.value, 0); // Initially Map
      AppRouter.switchTab(1); // Switch to SOS
      expect(activeTabSignal.value, 1);
      AppRouter.switchTab(2); // Switch to Mesh
      expect(activeTabSignal.value, 2);
      AppRouter.switchTab(3); // Switch to Assistant
      expect(activeTabSignal.value, 3);
      AppRouter.switchTab(0); // Back to Map
      expect(activeTabSignal.value, 0);
    });
  });
}
