import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';

class HospitalPoi {
  final String id;
  final String name;
  final String type;
  final LatLng location;
  final String phone;

  HospitalPoi({
    required this.id,
    required this.name,
    required this.type,
    required this.location,
    required this.phone,
  });

  factory HospitalPoi.fromJson(Map<String, dynamic> json) {
    return HospitalPoi(
      id: json['id'] as String,
      name: json['name'] as String? ?? 'Hospital',
      type: json['type'] as String? ?? 'hospital',
      location: LatLng(
        (json['latitude'] as num).toDouble(),
        (json['longitude'] as num).toDouble(),
      ),
      phone: json['phone'] as String? ?? '+91 108',
    );
  }
}

class ShelterPoi {
  final String id;
  final String name;
  final String type;
  final String capacity;
  final LatLng location;
  final String phone;

  ShelterPoi({
    required this.id,
    required this.name,
    required this.type,
    required this.capacity,
    required this.location,
    required this.phone,
  });

  factory ShelterPoi.fromJson(Map<String, dynamic> json) {
    return ShelterPoi(
      id: json['id'] as String,
      name: json['name'] as String? ?? 'Emergency Shelter',
      type: json['type'] as String? ?? 'shelter',
      capacity: json['capacity']?.toString() ?? '50-200',
      location: LatLng(
        (json['latitude'] as num).toDouble(),
        (json['longitude'] as num).toDouble(),
      ),
      phone: json['phone'] as String? ?? '+91 1070',
    );
  }
}

class RiverLine {
  final String id;
  final String name;
  final String type;
  final List<LatLng> points;

  RiverLine({
    required this.id,
    required this.name,
    required this.type,
    required this.points,
  });

  factory RiverLine.fromJson(Map<String, dynamic> json) {
    final rawCoords = json['coordinates'] as List<dynamic>? ?? [];
    final pts = <LatLng>[];
    for (final pt in rawCoords) {
      if (pt is List && pt.length >= 2) {
        pts.add(LatLng((pt[1] as num).toDouble(), (pt[0] as num).toDouble()));
      }
    }
    return RiverLine(
      id: json['id'] as String,
      name: json['name'] as String? ?? 'River',
      type: json['type'] as String? ?? 'river',
      points: pts,
    );
  }
}

class BoundaryLine {
  final String id;
  final String name;
  final String level;
  final List<LatLng> points;

  BoundaryLine({
    required this.id,
    required this.name,
    required this.level,
    required this.points,
  });

  factory BoundaryLine.fromJson(Map<String, dynamic> json) {
    final rawCoords = json['coordinates'] as List<dynamic>? ?? [];
    final pts = <LatLng>[];
    for (final pt in rawCoords) {
      if (pt is List && pt.length >= 2) {
        pts.add(LatLng((pt[1] as num).toDouble(), (pt[0] as num).toDouble()));
      }
    }
    return BoundaryLine(
      id: json['id'] as String,
      name: json['name'] as String? ?? 'Boundary',
      level: json['level'] as String? ?? '4',
      points: pts,
    );
  }
}

class StateCapitalPoi {
  final String id;
  final String name;
  final String fullName;
  final String stateCode;
  final String district;
  final bool isStateCapital;
  final LatLng location;

  StateCapitalPoi({
    required this.id,
    required this.name,
    required this.fullName,
    required this.stateCode,
    required this.district,
    required this.isStateCapital,
    required this.location,
  });

  factory StateCapitalPoi.fromJson(Map<String, dynamic> json) {
    return StateCapitalPoi(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      stateCode: json['stateCode'] as String? ?? '',
      district: json['district'] as String? ?? '',
      isStateCapital: json['isStateCapital'] as bool? ?? false,
      location: LatLng(
        (json['latitude'] as num).toDouble(),
        (json['longitude'] as num).toDouble(),
      ),
    );
  }
}

class RoadLine {
  final String id;
  final String name;
  final String type; // trunk, primary, secondary, tertiary
  final List<LatLng> points;

  RoadLine({
    required this.id,
    required this.name,
    required this.type,
    required this.points,
  });

  factory RoadLine.fromJson(Map<String, dynamic> json) {
    final rawCoords = json['coordinates'] as List<dynamic>? ?? [];
    final pts = <LatLng>[];
    for (final pt in rawCoords) {
      if (pt is List && pt.length >= 2) {
        pts.add(LatLng((pt[1] as num).toDouble(), (pt[0] as num).toDouble()));
      }
    }
    return RoadLine(
      id: json['id'] as String,
      name: json['name'] as String? ?? 'Road',
      type: json['type'] as String? ?? 'secondary',
      points: pts,
    );
  }
}

class HelipadPoi {
  final String id;
  final String name;
  final String type;
  final LatLng location;

  HelipadPoi({
    required this.id,
    required this.name,
    required this.type,
    required this.location,
  });

  factory HelipadPoi.fromJson(Map<String, dynamic> json) {
    return HelipadPoi(
      id: json['id'] as String,
      name: json['name'] as String? ?? 'Helipad',
      type: json['type'] as String? ?? 'helipad',
      location: LatLng(
        (json['latitude'] as num).toDouble(),
        (json['longitude'] as num).toDouble(),
      ),
    );
  }
}

class BlockagePoi {
  final String id;
  final String note;
  final LatLng location;
  final DateTime timestamp;

  BlockagePoi({
    required this.id,
    required this.note,
    required this.location,
    required this.timestamp,
  });
}

class PoiSearchItem {
  final String name;
  final String category;
  final LatLng location;

  PoiSearchItem({
    required this.name,
    required this.category,
    required this.location,
  });

  factory PoiSearchItem.fromJson(Map<String, dynamic> json) {
    return PoiSearchItem(
      name: json['name'] as String? ?? '',
      category: json['category'] as String? ?? '',
      location: LatLng(
        (json['latitude'] as num).toDouble(),
        (json['longitude'] as num).toDouble(),
      ),
    );
  }
}

class MapDataService {
  static final MapDataService _instance = MapDataService._internal();
  factory MapDataService() => _instance;
  MapDataService._internal();

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  List<HospitalPoi> hospitals = [];
  List<ShelterPoi> shelters = [];
  List<RiverLine> rivers = [];
  List<BoundaryLine> boundaries = [];
  List<StateCapitalPoi> capitals = [];
  List<RoadLine> roads = [];
  List<HelipadPoi> helipads = [];
  List<PoiSearchItem> searchIndex = [];

  Future<void> loadAll() async {
    if (_isLoaded) return;

    try {
      final capStr =
          await rootBundle.loadString('assets/data/state_capitals.json');
      final capList = json.decode(capStr) as List<dynamic>;
      capitals = capList
          .map((e) => StateCapitalPoi.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {}

    try {
      final hospStr =
          await rootBundle.loadString('assets/data/uttarakhand_hospitals.json');
      final hospList = json.decode(hospStr) as List<dynamic>;
      hospitals = hospList
          .map((e) => HospitalPoi.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {}

    try {
      final shStr =
          await rootBundle.loadString('assets/data/uttarakhand_shelters.json');
      final shList = json.decode(shStr) as List<dynamic>;
      shelters = shList
          .map((e) => ShelterPoi.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {}

    try {
      final rivStr =
          await rootBundle.loadString('assets/data/uttarakhand_rivers.json');
      final rivList = json.decode(rivStr) as List<dynamic>;
      rivers = rivList
          .map((e) => RiverLine.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {}

    try {
      final boundStr = await rootBundle
          .loadString('assets/data/uttarakhand_boundaries.json');
      final boundList = json.decode(boundStr) as List<dynamic>;
      boundaries = boundList
          .map((e) => BoundaryLine.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {}

    try {
      final roadStr = await rootBundle
          .loadString('assets/data/uttarakhand_roads.json');
      final roadList = json.decode(roadStr) as List<dynamic>;
      roads = roadList
          .map((e) => RoadLine.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {}

    try {
      final heliStr = await rootBundle
          .loadString('assets/data/uttarakhand_helipads.json');
      final heliList = json.decode(heliStr) as List<dynamic>;
      helipads = heliList
          .map((e) => HelipadPoi.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {}

    try {
      final poiStr = await rootBundle
          .loadString('assets/data/uttarakhand_poi_search.json');
      final poiList = json.decode(poiStr) as List<dynamic>;
      searchIndex = poiList
          .map((e) => PoiSearchItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {}

    _isLoaded = true;
  }

  List<PoiSearchItem> search(String query) {
    if (query.trim().isEmpty) return [];
    final q = query.toLowerCase().trim();
    return searchIndex
        .where((item) =>
            item.name.toLowerCase().contains(q) ||
            item.category.toLowerCase().contains(q))
        .take(8)
        .toList();
  }
}
