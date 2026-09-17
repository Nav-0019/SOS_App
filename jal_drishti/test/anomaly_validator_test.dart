import 'package:flutter_test/flutter_test.dart';
import 'package:jal_drishti/features/anomaly_monitoring/data/anomaly_validator.dart';
import 'package:jal_drishti/shared/models/schemas.dart';

void main() {
  group('AnomalyValidator Data Validation Stress Test', () {
    test('Valid data within Uttarakhand is NORMAL and LIVE', () {
      final obs = HydrometObservation()
        ..latitude = 30.0668
        ..longitude = 79.0193
        ..rainfallMm = 10.0
        ..soilMoistureVolumetric = 0.3
        ..observedAt = DateTime.now().toUtc(); // Just now

      AnomalyValidator.validate(obs);
      expect(obs.qualityStatus, 'NORMAL');
      expect(obs.freshnessStatus, 'LIVE');
    });

    test('Negative rainfall is SUSPICIOUS', () {
      final obs = HydrometObservation()
        ..latitude = 30.0
        ..longitude = 79.0
        ..rainfallMm = -5.0
        ..soilMoistureVolumetric = 0.3
        ..observedAt = DateTime.now().toUtc();

      AnomalyValidator.validate(obs);
      expect(obs.qualityStatus, 'SUSPICIOUS');
    });

    test('Null values are MISSING', () {
      final obs = HydrometObservation()
        ..latitude = 30.0
        ..longitude = 79.0
        ..rainfallMm = null
        ..soilMoistureVolumetric = 0.3
        ..observedAt = DateTime.now().toUtc();

      AnomalyValidator.validate(obs);
      expect(obs.qualityStatus, 'MISSING');
    });

    test('Coordinates outside Uttarakhand bounds are SUSPICIOUS', () {
      final obs = HydrometObservation()
        ..latitude = 12.0 // Outside (Kerala approx)
        ..longitude = 79.0
        ..rainfallMm = 10.0
        ..soilMoistureVolumetric = 0.3
        ..observedAt = DateTime.now().toUtc();

      AnomalyValidator.validate(obs);
      expect(obs.qualityStatus, 'SUSPICIOUS');
    });

    test('Future timestamp is SUSPICIOUS', () {
      final obs = HydrometObservation()
        ..latitude = 30.0
        ..longitude = 79.0
        ..rainfallMm = 10.0
        ..soilMoistureVolumetric = 0.3
        ..observedAt = DateTime.now().toUtc().add(const Duration(hours: 2));

      AnomalyValidator.validate(obs);
      expect(obs.qualityStatus, 'SUSPICIOUS');
    });

    test('Old timestamp is STALE', () {
      final obs = HydrometObservation()
        ..latitude = 30.0
        ..longitude = 79.0
        ..rainfallMm = 10.0
        ..soilMoistureVolumetric = 0.3
        ..observedAt = DateTime.now().toUtc().subtract(const Duration(hours: 13));

      AnomalyValidator.validate(obs);
      expect(obs.qualityStatus, 'NORMAL');
      expect(obs.freshnessStatus, 'STALE');
    });

    test('Recent timestamp is RECENT', () {
      final obs = HydrometObservation()
        ..latitude = 30.0
        ..longitude = 79.0
        ..rainfallMm = 10.0
        ..soilMoistureVolumetric = 0.3
        ..observedAt = DateTime.now().toUtc().subtract(const Duration(hours: 5));

      AnomalyValidator.validate(obs);
      expect(obs.qualityStatus, 'NORMAL');
      expect(obs.freshnessStatus, 'RECENT');
    });
  });
}
