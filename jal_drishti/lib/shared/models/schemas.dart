import 'package:isar/isar.dart';

part 'schemas.g.dart';

@collection
class MapNode {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String nodeId;

  late double latitude;
  late double longitude;
  late String nodeType;

  late int upvotes;
  late int downvotes;
  late DateTime timestamp;

  late bool isVerified;
}

@collection
class ChatMessage {
  Id id = Isar.autoIncrement;

  @Index()
  late String messageId;

  late String senderId;
  late String textPayload;
  late DateTime timestamp;
  late int hopCount;
}

@collection
class WeatherForecast {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String locationKey;

  late String forecastJson;
  late DateTime lastUpdated;
}

@collection
class HydrometObservation {
  Id id = Isar.autoIncrement;

  late String source; // e.g. Open-Meteo
  @Index()
  late DateTime observedAt;
  late DateTime receivedAt;
  
  late double latitude;
  late double longitude;
  
  // Variables
  late double? rainfallMm;
  late double? soilMoistureVolumetric;

  late String qualityStatus; // NORMAL, SUSPICIOUS, MISSING
  late String freshnessStatus; // LIVE, RECENT, STALE, OFFLINE
}

@collection
class AnomalyResult {
  Id id = Isar.autoIncrement;

  late DateTime evaluatedAt;
  
  // Methodology used
  late String methodology; // e.g. Z-Score

  // Input variables
  late double rainfallValue;
  late double soilMoistureValue;

  // Evaluated scores
  late double rainfallZScore;
  late double soilMoistureZScore;

  // Overall State
  late String state; // NORMAL, ELEVATED, HIGH, EXTREME
}

@collection
class SosQueueMessage {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String sosId;

  late String senderId;
  late DateTime timestamp;

  late double latitude;
  late double longitude;

  late int distressType;
  
  String? message;
  String? name;
  String? phone;

  late int peopleTrapped;
  late int battery;

  late int meshHops;
  late int ttl;

  String? deviceId;

  late bool isDelivered;

  DateTime? lastAttemptAt;
  late int uploadAttempts;

  String? lastError;
}
