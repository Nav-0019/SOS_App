import 'package:isar/isar.dart';
import 'dart:math' as math;
import '../models/sos_resource.dart';

class OfflineSosService {
  final Isar isar;

  OfflineSosService(this.isar);

  /// Find nearest resources around a given GPS coordinate (e.g., from BLE SOS packet)
  Future<List<SosResource>> findNearestResources({
    required double lat,
    required double lng,
    double searchRadiusKm = 10.0,
    int limit = 5,
  }) async {
    // 1 degree of latitude is ~111 km.
    // 1 degree of longitude is ~111 km * cos(lat).
    final latDelta = searchRadiusKm / 111.0;
    final lngDelta = searchRadiusKm / (111.0 * math.cos(lat * math.pi / 180.0));

    final minLat = lat - latDelta;
    final maxLat = lat + latDelta;
    final minLng = lng - lngDelta;
    final maxLng = lng + lngDelta;

    // Use Isar's bounding box query to filter down the pan-India dataset quickly
    final candidates = await isar.sosResources
        .filter()
        .latitudeBetween(minLat, maxLat)
        .and()
        .longitudeBetween(minLng, maxLng)
        .findAll();

    // Sort by actual distance squared (Haversine approx) and take top 'limit'
    candidates.sort((a, b) => 
        a.distanceSquaredTo(lat, lng).compareTo(b.distanceSquaredTo(lat, lng)));

    return candidates.take(limit).toList();
  }

  /// Categorized lookup for the SOS Dashboard
  Future<Map<String, SosResource?>> getEmergencyDashboard(double lat, double lng) async {
    final nearest = await findNearestResources(lat: lat, lng: lng, searchRadiusKm: 20.0, limit: 100);
    
    SosResource? nearestHospital;
    SosResource? nearestShelter;
    SosResource? nearestHelipad;
    SosResource? nearestRoad;

    for (final res in nearest) {
      if (nearestHospital == null && res.type == 'hospital') nearestHospital = res;
      if (nearestShelter == null && res.type == 'shelter') nearestShelter = res;
      if (nearestHelipad == null && res.type == 'helipad') nearestHelipad = res;
      if (nearestRoad == null && res.type == 'road') nearestRoad = res;
    }

    return {
      'hospital': nearestHospital,
      'shelter': nearestShelter,
      'helipad': nearestHelipad,
      'road': nearestRoad,
    };
  }
}
