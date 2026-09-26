import 'package:isar/isar.dart';

part 'sos_resource.g.dart';

@collection
class SosResource {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String resourceId; // E.g., 'osm_12345'

  @Index(type: IndexType.hash)
  late String type; // 'hospital', 'shelter', 'helipad', 'river', 'road'

  late String name;

  // Store coordinates as double for fast bounding-box queries
  @Index(type: IndexType.value)
  late double latitude;

  @Index(type: IndexType.value)
  late double longitude;

  // Line geometry for roads/rivers, stored as JSON string or byte array
  // E.g., "[[lat,lng],[lat,lng]]"
  String? geometryJson;

  late String source; // 'OSM', 'Government', 'ISRO'
  
  late String verificationStatus; // 'verified', 'unverified'
  
  String? phone;
  String? capacity;
  String? operatorName;

  /// Fast distance calculation helper (Haversine distance squared approximation for quick sorting)
  double distanceSquaredTo(double targetLat, double targetLng) {
    final dLat = latitude - targetLat;
    final dLng = longitude - targetLng;
    return (dLat * dLat) + (dLng * dLng);
  }
}
