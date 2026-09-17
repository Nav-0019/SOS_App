import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/schemas.dart';

/// Centralized Isar database singleton. Call [initialize] once at app start.
class IsarService {
  static final IsarService _instance = IsarService._internal();
  factory IsarService() => _instance;
  IsarService._internal();

  Isar? _isar;

  Isar get db {
    if (_isar == null) {
      throw StateError('IsarService must be initialized before accessing db.');
    }
    return _isar!;
  }

  Future<void> initialize() async {
    if (_isar != null) return;
    try {
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open(
        [
          MapNodeSchema,
          ChatMessageSchema,
          WeatherForecastSchema,
          HydrometObservationSchema,
          AnomalyResultSchema,
          SosQueueMessageSchema,
        ],
        directory: dir.path,
        name: 'jal_drishti',
      );
    } catch (_) {}
  }

  Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }
}
