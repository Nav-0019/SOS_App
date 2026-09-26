import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:latlong2/latlong.dart';
import '../services/map_data_service.dart';
import '../../../main.dart';

class MapSignalController {
  static final MapSignalController _instance = MapSignalController._internal();
  factory MapSignalController() => _instance;
  MapSignalController._internal();

  final MapDataService dataService = MapDataService();

  static const LatLng defaultViewportCenter = LatLng(20.5937, 78.9629);

  final currentLocationSignal = signal<LatLng>(defaultViewportCenter);
  final userGpsLocationSignal = signal<LatLng?>(null);
  final hasGpsFixSignal = signal<bool>(false);
  final zoomLevelSignal = signal<double>(5.0);
  final isOfflineMapReadySignal = signal<bool>(false);

  // Offline tile cache signals
  final isDownloadingTilesSignal = signal<bool>(false);
  final downloadProgressSignal = signal<double>(0.0);
  final downloadStatusSignal = signal<String>('');
  final cachedTilesCountSignal = signal<int>(0);
  final cachedSizeKiBSignal = signal<double>(0.0);

  final showHospitalsSignal = signal<bool>(true);
  final showRiversSignal = signal<bool>(true);
  final showSheltersSignal = signal<bool>(false);
  final showBoundariesSignal = signal<bool>(false);
  final showRoadsSignal = signal<bool>(true);
  final showHelipadsSignal = signal<bool>(true);

  final isMarkingBlockageSignal = signal<bool>(false);
  final blockagesSignal = signal<List<BlockagePoi>>([]);

  final selectedItemTitleSignal = signal<String?>(null);
  final selectedItemSubtitleSignal = signal<String?>(null);
  final selectedItemLocationSignal = signal<LatLng?>(null);

  Future<void> initialize() async {
    await dataService.loadAll();
    isOfflineMapReadySignal.value = true;
    await refreshCacheStats();
  }

  Future<void> refreshCacheStats() async {
    if (!fmtcReady) return;
    try {
      final stats = await const FMTCStore('mapStore').stats.all;
      cachedTilesCountSignal.value = stats.length;
      cachedSizeKiBSignal.value = stats.size;
    } catch (e) {
      debugPrint('Error refreshing cache stats: $e');
    }
  }

  Future<void> cancelDownload() async {
    try {
      await const FMTCStore('mapStore').download.cancel();
    } catch (e) {
      debugPrint('Cancel error: $e');
    }
    isDownloadingTilesSignal.value = false;
    downloadStatusSignal.value = 'Cancelled';
    await refreshCacheStats();
  }

  Future<void> startTileDownload({
    required LatLngBounds bounds,
    required void Function(String) onSuccess,
    required void Function(String) onError,
  }) async {
    if (!fmtcReady) {
      onError('Offline cache not available on this device.');
      return;
    }
    if (isDownloadingTilesSignal.value) return;

    // Proactively cancel any previous/orphaned download instance to avoid "ID 0 already exists"
    try {
      await const FMTCStore('mapStore').download.cancel();
      await Future.delayed(const Duration(milliseconds: 300));
    } catch (_) {}

    isDownloadingTilesSignal.value = true;
    downloadProgressSignal.value = 0.0;
    downloadStatusSignal.value = 'Starting download...';

    final region = RectangleRegion(bounds);

    final downloadableRegion = region.toDownloadable(
      minZoom: 6,
      maxZoom: 12,
      options: TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'com.jaldrishti.app',
      ),
    );

    try {
      final progressStream = const FMTCStore('mapStore').download.startForeground(
        region: downloadableRegion,
        skipExistingTiles: true,
        parallelThreads: 6,
      );

      await for (final progress in progressStream) {
        if (!isDownloadingTilesSignal.value) {
          // User cancelled
          break;
        }
        downloadProgressSignal.value = progress.percentageProgress;
        downloadStatusSignal.value =
            '${progress.percentageProgress.toStringAsFixed(1)}% (${progress.cachedTiles}/${progress.maxTiles} tiles)';
        if (progress.isComplete) break;
      }

      isDownloadingTilesSignal.value = false;
      await refreshCacheStats();
      onSuccess(
          'Offline Map Downloaded! (${cachedTilesCountSignal.value} tiles cached)');
    } catch (e) {
      isDownloadingTilesSignal.value = false;
      await refreshCacheStats();
      if (e.toString().contains('already exists')) {
        try {
          await const FMTCStore('mapStore').download.cancel();
        } catch (_) {}
        onError('Previous download was active. Resetting instance - please tap again.');
      } else {
        onError('Download Error: $e');
      }
    }
  }

  void updateLocation(LatLng newLocation) {
    userGpsLocationSignal.value = newLocation;
    currentLocationSignal.value = newLocation;
    hasGpsFixSignal.value = true;
  }

  void clearGpsFix() {
    userGpsLocationSignal.value = null;
    currentLocationSignal.value = defaultViewportCenter;
    hasGpsFixSignal.value = false;
  }

  void toggleHospitals(bool value) => showHospitalsSignal.value = value;
  void toggleRivers(bool value) => showRiversSignal.value = value;
  void toggleShelters(bool value) => showSheltersSignal.value = value;
  void toggleBoundaries(bool value) => showBoundariesSignal.value = value;
  void toggleRoads(bool value) => showRoadsSignal.value = value;
  void toggleHelipads(bool value) => showHelipadsSignal.value = value;

  void toggleBlockageMode() {
    isMarkingBlockageSignal.value = !isMarkingBlockageSignal.value;
  }

  void addBlockage(LatLng location,
      {String note = 'Road Blocked / Landslide'}) {
    final newBlockage = BlockagePoi(
      id: 'block_${DateTime.now().millisecondsSinceEpoch}',
      note: note,
      location: location,
      timestamp: DateTime.now(),
    );
    blockagesSignal.value = [...blockagesSignal.value, newBlockage];
    isMarkingBlockageSignal.value = false;
  }

  void removeBlockage(String id) {
    blockagesSignal.value =
        blockagesSignal.value.where((b) => b.id != id).toList();
  }

  void selectItem(String title, String subtitle, LatLng location) {
    selectedItemTitleSignal.value = title;
    selectedItemSubtitleSignal.value = subtitle;
    selectedItemLocationSignal.value = location;
  }

  void clearSelection() {
    selectedItemTitleSignal.value = null;
    selectedItemSubtitleSignal.value = null;
    selectedItemLocationSignal.value = null;
  }
}
