import 'package:flutter_test/flutter_test.dart';
import 'package:jal_drishti/features/anomaly_monitoring/domain/anomaly_engine.dart';
import 'package:jal_drishti/shared/models/schemas.dart';

void main() {
  group('AnomalyEngine Z-Score Methodology', () {
    test('Zero standard deviation edge case (all baseline values identical)', () {
      List<HydrometObservation> baseline = [];
      for (int i = 0; i < 30; i++) {
        baseline.add(
          HydrometObservation()
            ..rainfallMm = 10.0
            ..soilMoistureVolumetric = 0.5
        );
      }

      HydrometObservation current = HydrometObservation()
        ..rainfallMm = 10.0
        ..soilMoistureVolumetric = 0.5;

      // StdDev should be clamped to 0.01 instead of 0, resulting in Z=0, not NaN or Infinity
      final result = AnomalyEngine.evaluate(current, baseline);

      expect(result.rainfallZScore, 0.0);
      expect(result.soilMoistureZScore, 0.0);
      expect(result.state, 'NORMAL');
    });

    test('Exact Z-Score calculation with known values', () {
      List<HydrometObservation> baseline = [
        HydrometObservation()..rainfallMm = 2.0..soilMoistureVolumetric = 0.2,
        HydrometObservation()..rainfallMm = 4.0..soilMoistureVolumetric = 0.2,
        HydrometObservation()..rainfallMm = 4.0..soilMoistureVolumetric = 0.2,
        HydrometObservation()..rainfallMm = 4.0..soilMoistureVolumetric = 0.2,
        HydrometObservation()..rainfallMm = 5.0..soilMoistureVolumetric = 0.2,
        HydrometObservation()..rainfallMm = 5.0..soilMoistureVolumetric = 0.2,
        HydrometObservation()..rainfallMm = 5.0..soilMoistureVolumetric = 0.2,
        HydrometObservation()..rainfallMm = 7.0..soilMoistureVolumetric = 0.2,
        HydrometObservation()..rainfallMm = 9.0..soilMoistureVolumetric = 0.2,
        HydrometObservation()..rainfallMm = 9.0..soilMoistureVolumetric = 0.2,
        // Need at least 10 items
      ];
      // Mean = 54 / 10 = 5.4
      // Variances:
      // (2-5.4)^2 = 11.56
      // (4-5.4)^2 = 1.96 * 3 = 5.88
      // (5-5.4)^2 = 0.16 * 3 = 0.48
      // (7-5.4)^2 = 2.56
      // (9-5.4)^2 = 12.96 * 2 = 25.92
      // Sum Var = 46.4
      // Pop variance = 46.4 / 10 = 4.64
      // StdDev = sqrt(4.64) = 2.1540659...

      // current = 10.0
      // Z = (10 - 5.4) / 2.1540659 = 2.135496...

      HydrometObservation current = HydrometObservation()
        ..rainfallMm = 10.0
        ..soilMoistureVolumetric = 0.2;

      final result = AnomalyEngine.evaluate(current, baseline);
      
      expect(result.rainfallZScore, closeTo(2.135, 0.01));
      expect(result.state, 'ELEVATED');
    });

    test('Missing baseline values (Insufficient history)', () {
      List<HydrometObservation> baseline = [
        HydrometObservation()..rainfallMm = 10.0..soilMoistureVolumetric = 0.2,
        HydrometObservation()..rainfallMm = 10.0..soilMoistureVolumetric = 0.2,
      ];

      HydrometObservation current = HydrometObservation()
        ..rainfallMm = 100.0
        ..soilMoistureVolumetric = 0.9;

      final result = AnomalyEngine.evaluate(current, baseline);

      expect(result.methodology, 'Z-Score (Insufficient Data)');
      expect(result.rainfallZScore, 0.0);
      expect(result.state, 'NORMAL'); // Fails safe
    });
  });
}
