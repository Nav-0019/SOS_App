import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../app/theme/amoled_theme.dart';
import '../../controllers/map_signal_controller.dart';
import '../../services/map_data_service.dart';
import '../../../../shared/localization/locale_service.dart';
import '../../../../shared/localization/language_toggle_button.dart';
import '../../../../main.dart' show fmtcReady;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _controller = MapSignalController();
  final _mapController = MapController();
  final _searchController = TextEditingController();
  List<PoiSearchItem> _searchResults = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _controller.initialize();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }
    final results = _controller.dataService.search(query);
    setState(() {
      _searchResults = results;
      _isSearching = true;
    });
  }

  void _selectSearchResult(PoiSearchItem item) {
    _searchController.text = item.name;
    setState(() {
      _searchResults = [];
      _isSearching = false;
    });
    FocusScope.of(context).unfocus();
    _mapController.move(item.location, 12.0);
    _controller.selectItem(item.name, item.category, item.location);
  }

  void _downloadMapTiles() {
    final bounds = _mapController.camera.visibleBounds;
    _controller.startTileDownload(
      bounds: bounds,
      onSuccess: (msg) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg)),
          );
        }
      },
      onError: (err) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(err)),
          );
        }
      },
    );
  }

  void _onMapTap(TapPosition tapPosition, LatLng point) {
    if (_controller.isMarkingBlockageSignal.value) {
      _showAddBlockageDialog(point);
    } else {
      _controller.clearSelection();
    }
  }

  void _showAddBlockageDialog(LatLng point) {
    final noteController =
        TextEditingController(text: 'Road Blocked / Landslide');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AmoledColors.surface,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AmoledColors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Row(
          children: [
            Icon(Icons.flag, color: AmoledColors.hazardOrange, size: 20),
            SizedBox(width: 8),
            Text(
              'Mark Road Blockage',
              style: TextStyle(color: AmoledColors.textPrimary, fontSize: 16),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location: ${point.latitude.toStringAsFixed(4)}, ${point.longitude.toStringAsFixed(4)}',
              style: const TextStyle(
                  color: AmoledColors.textSecondary, fontSize: 12),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: noteController,
              style: const TextStyle(
                  color: AmoledColors.textPrimary, fontSize: 13),
              decoration: InputDecoration(
                labelText: 'Hazard Description',
                labelStyle: const TextStyle(color: AmoledColors.textSecondary),
                filled: true,
                fillColor: AmoledColors.cardDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AmoledColors.border),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _controller.isMarkingBlockageSignal.value = false;
            },
            child: const Text('Cancel',
                style: TextStyle(color: AmoledColors.textSecondary)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AmoledColors.hazardOrange,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              _controller.addBlockage(point, note: noteController.text.trim());
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Blockage marked on map and synced to offline database.'),
                  backgroundColor: AmoledColors.surface,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      final isHindi = localeSignal.value == 'hi';

      return Scaffold(
        backgroundColor: AmoledColors.background,
        appBar: AppBar(
          title: Text(isHindi ? 'ऑफलाइन मानचित्र' : 'OFFLINE MAP'),
          centerTitle: true,
          actions: const [
            LanguageToggleButton(),
          ],
        ),
      body: SafeArea(
        child: Watch((context) {
          final isReady = _controller.isOfflineMapReadySignal.value;
          final showHospitals = _controller.showHospitalsSignal.value;
          final showRivers = _controller.showRiversSignal.value;
          final showShelters = _controller.showSheltersSignal.value;
          final showBoundaries = _controller.showBoundariesSignal.value;
          final showRoads = _controller.showRoadsSignal.value;
          final showHelipads = _controller.showHelipadsSignal.value;
          final isMarkingBlockage = _controller.isMarkingBlockageSignal.value;
          final blockages = _controller.blockagesSignal.value;
          final selectedTitle = _controller.selectedItemTitleSignal.value;
          final selectedSubtitle = _controller.selectedItemSubtitleSignal.value;
          final isDownloading = _controller.isDownloadingTilesSignal.value;
          final downloadProgress = _controller.downloadProgressSignal.value;
          final downloadStatus = _controller.downloadStatusSignal.value;
          final cachedTiles = _controller.cachedTilesCountSignal.value;
          final cachedKiB = _controller.cachedSizeKiBSignal.value;

          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSearchBar(),
                if (_isSearching && _searchResults.isNotEmpty)
                  _buildSearchResultsOverlay(),
                const SizedBox(height: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AmoledColors.mapBackground,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isMarkingBlockage
                            ? AmoledColors.hazardOrange
                            : AmoledColors.mapBorder,
                        width: isMarkingBlockage ? 2 : 1,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                            initialCenter:
                                _controller.currentLocationSignal.value,
                            initialZoom: _controller.zoomLevelSignal.value,
                            minZoom: 4,
                            maxZoom: 18,
                            backgroundColor: const Color(0xFFE0E0E0),
                            onTap: _onMapTap,
                          ),
                          children: [
                            // Base Map Tiles (Online / Cached)
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.jaldrishti.app',
                              tileProvider: fmtcReady
                                  ? const FMTCStore('mapStore').getTileProvider()
                                  : null,
                            ),

                            // Roads layer (trunk/primary/secondary)
                            if (showRoads && isReady)
                              PolylineLayer(
                                polylines: _controller.dataService.roads
                                    .map(
                                      (r) => Polyline(
                                        points: r.points,
                                        strokeWidth: r.type == 'trunk'
                                            ? 2.5
                                            : r.type == 'primary'
                                                ? 1.8
                                                : 1.2,
                                        color: r.type == 'trunk'
                                            ? const Color(0xFFE0E0E0)
                                            : r.type == 'primary'
                                                ? const Color(0xFFB0B8C8)
                                                : const Color(0xFF6B7894),
                                      ),
                                    )
                                    .toList(),
                              ),

                            // Boundaries
                            if (showBoundaries && isReady)
                              PolylineLayer(
                                polylines: _controller.dataService.boundaries
                                    .map(
                                      (b) => Polyline(
                                        points: b.points,
                                        strokeWidth: 2.0,
                                        color: Colors.purpleAccent
                                            .withValues(alpha: 0.6),
                                      ),
                                    )
                                    .toList(),
                              ),

                            // Rivers
                            if (showRivers && isReady)
                              PolylineLayer(
                                polylines: _controller.dataService.rivers
                                    .map(
                                      (r) => Polyline(
                                        points: r.points,
                                        strokeWidth: 2.2,
                                        color: AmoledColors.riverCyan,
                                      ),
                                    )
                                    .toList(),
                              ),

                            // State Capitals
                            if (isReady)
                              MarkerLayer(
                                markers: _controller.dataService.capitals
                                    .where((c) =>
                                        c.isStateCapital ||
                                        c.name == 'Dehradun')
                                    .map(
                                      (c) => Marker(
                                        point: c.location,
                                        width: 80,
                                        height: 40,
                                        child: GestureDetector(
                                          onTap: () {
                                            _controller.selectItem(
                                              c.fullName,
                                              'State Capital (Uttarakhand)',
                                              c.location,
                                            );
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: AmoledColors.sosDanger,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Colors.black54,
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                ),
                                                child: Text(
                                                  c.name,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 8.5,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              const Icon(
                                                Icons.star,
                                                color:
                                                    AmoledColors.warningYellow,
                                                size: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),

                            // Hospitals
                            if (showHospitals && isReady)
                              MarkerLayer(
                                markers: _controller.dataService.hospitals
                                    .take(120)
                                    .map(
                                      (h) => Marker(
                                        point: h.location,
                                        width: 28,
                                        height: 28,
                                        child: GestureDetector(
                                          onTap: () {
                                            _controller.selectItem(
                                              h.name,
                                              'Hospital • ${h.phone}',
                                              h.location,
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AmoledColors.surface,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: AmoledColors.safeShelter,
                                                width: 1.5,
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.local_hospital,
                                              color: AmoledColors.safeShelter,
                                              size: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),

                            // Shelters
                            if (showShelters && isReady)
                              MarkerLayer(
                                markers: _controller.dataService.shelters
                                    .map(
                                      (s) => Marker(
                                        point: s.location,
                                        width: 28,
                                        height: 28,
                                        child: GestureDetector(
                                          onTap: () {
                                            _controller.selectItem(
                                              s.name,
                                              'Capacity: ${s.capacity} • ${s.phone}',
                                              s.location,
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AmoledColors.surface,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color:
                                                    AmoledColors.warningYellow,
                                                width: 1.5,
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.home_work,
                                              color: AmoledColors.warningYellow,
                                              size: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),

                            // Helipads
                            if (showHelipads && isReady)
                              MarkerLayer(
                                markers: _controller.dataService.helipads
                                    .map(
                                      (h) => Marker(
                                        point: h.location,
                                        width: 26,
                                        height: 26,
                                        child: GestureDetector(
                                          onTap: () {
                                            _controller.selectItem(
                                              h.name,
                                              'Emergency Helipad',
                                              h.location,
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFB71C1C),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.white70,
                                                width: 1.2,
                                              ),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'H',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),

                            // User-Marked Blockages
                            MarkerLayer(
                              markers: blockages
                                  .map(
                                    (b) => Marker(
                                      point: b.location,
                                      width: 32,
                                      height: 32,
                                      child: GestureDetector(
                                        onTap: () {
                                          _controller.selectItem(
                                            'ROAD BLOCKAGE',
                                            b.note,
                                            b.location,
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AmoledColors.cardDark,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: AmoledColors.hazardOrange,
                                              width: 2,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.flag,
                                            color: AmoledColors.hazardOrange,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),

                            // GPS Location Marker (Only rendered when a real GPS fix is acquired)
                            if (_controller.hasGpsFixSignal.value &&
                                _controller.userGpsLocationSignal.value != null)
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point:
                                        _controller.userGpsLocationSignal.value!,
                                    width: 36,
                                    height: 36,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AmoledColors.safeShelter
                                                .withValues(alpha: 0.25),
                                          ),
                                        ),
                                        Container(
                                          width: 14,
                                          height: 14,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AmoledColors.safeShelter,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        // GPS Unavailable Indicator
                        if (!_controller.hasGpsFixSignal.value)
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AmoledColors.surface
                                    .withValues(alpha: 0.9),
                                borderRadius: BorderRadius.circular(6),
                                border:
                                    Border.all(color: AmoledColors.border),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.location_off,
                                      size: 12,
                                      color: AmoledColors.warningYellow),
                                  const SizedBox(width: 4),
                                  Text(
                                    isHindi
                                        ? 'जीपीएस अनुपलब्ध'
                                        : 'GPS Unavailable',
                                    style: const TextStyle(
                                      color: AmoledColors.textSecondary,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: InkWell(
                            onTap: () {
                              if (_controller.hasGpsFixSignal.value &&
                                  _controller.userGpsLocationSignal.value !=
                                      null) {
                                _mapController.move(
                                  _controller.userGpsLocationSignal.value!,
                                  12.0,
                                );
                              } else {
                                _mapController.move(
                                  MapSignalController.defaultViewportCenter,
                                  5.0,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isHindi
                                          ? 'जीपीएस अनुपलब्ध — भारत दृश्य पर रीसेट किया गया'
                                          : 'GPS unavailable — Reset to India viewport',
                                    ),
                                    backgroundColor: AmoledColors.surface,
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color:
                                    AmoledColors.surface.withValues(alpha: 0.9),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: AmoledColors.border),
                              ),
                              child: Icon(
                                Icons.my_location,
                                size: 18,
                                color: _controller.hasGpsFixSignal.value
                                    ? AmoledColors.safeShelter
                                    : AmoledColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                        if (isMarkingBlockage)
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: AmoledColors.hazardOrange,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.touch_app,
                                      size: 14, color: Colors.white),
                                  SizedBox(width: 4),
                                  Text(
                                    'TAP ANYWHERE ON MAP TO PLACE BLOCKAGE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (selectedTitle != null)
                          Positioned(
                            bottom: 10,
                            left: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AmoledColors.surface,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AmoledColors.border),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black87, blurRadius: 10),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.info_outline,
                                      color: AmoledColors.safeShelter,
                                      size: 18),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          selectedTitle,
                                          style: const TextStyle(
                                            color: AmoledColors.textPrimary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        if (selectedSubtitle != null)
                                          Text(
                                            selectedSubtitle,
                                            style: const TextStyle(
                                              color: AmoledColors.textSecondary,
                                              fontSize: 10,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close,
                                        size: 16,
                                        color: AmoledColors.textMuted),
                                    onPressed: () =>
                                        _controller.clearSelection(),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  isHindi ? 'मानचित्र परतें' : 'Checkbox layers',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AmoledColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: _buildCheckboxTile(
                        label: isHindi ? 'अस्पताल' : 'Hospitals',
                        value: showHospitals,
                        onChanged: (val) =>
                            _controller.toggleHospitals(val ?? false),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildCheckboxTile(
                        label: isHindi ? 'नदियां' : 'River lines',
                        value: showRivers,
                        onChanged: (val) =>
                            _controller.toggleRivers(val ?? false),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: _buildCheckboxTile(
                        label: isHindi ? 'राहत शिविर' : 'Shelters',
                        value: showShelters,
                        onChanged: (val) =>
                            _controller.toggleShelters(val ?? false),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildCheckboxTile(
                        label: isHindi ? 'सीमाएं' : 'Boundaries',
                        value: showBoundaries,
                        onChanged: (val) =>
                            _controller.toggleBoundaries(val ?? false),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: _buildCheckboxTile(
                        label: isHindi ? 'सड़कें' : 'Roads',
                        value: showRoads,
                        onChanged: (val) =>
                            _controller.toggleRoads(val ?? false),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildCheckboxTile(
                        label: isHindi ? 'हेलीपैड' : 'Helipads',
                        value: showHelipads,
                        onChanged: (val) =>
                            _controller.toggleHelipads(val ?? false),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                
                // Download Offline Map Button
                if (isDownloading)
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AmoledColors.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AmoledColors.safeShelter.withValues(alpha: 0.6),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                downloadStatus.isNotEmpty
                                    ? downloadStatus
                                    : 'Downloading: ${downloadProgress.toStringAsFixed(1)}%',
                                style: const TextStyle(
                                  color: AmoledColors.safeShelter,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            InkWell(
                              onTap: () => _controller.cancelDownload(),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: AmoledColors.sosDanger,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: downloadProgress > 0
                              ? downloadProgress / 100
                              : null,
                          backgroundColor: AmoledColors.background,
                          color: AmoledColors.safeShelter,
                          minHeight: 4,
                        ),
                      ],
                    ),
                  )
                else
                  InkWell(
                    onTap: _downloadMapTiles,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: AmoledColors.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AmoledColors.border,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isHindi
                                    ? 'दृश्यमान क्षेत्र डाउनलोड करें'
                                    : 'Download Visible Region',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AmoledColors.textPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (cachedTiles > 0) ...[
                                const SizedBox(height: 2),
                                Text(
                                  'Cached: $cachedTiles tiles (${(cachedKiB / 1024).toStringAsFixed(1)} MB)',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: AmoledColors.safeShelter,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const Icon(
                            Icons.download,
                            size: 16,
                            color: AmoledColors.safeShelter,
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () => _controller.toggleBlockageMode(),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: isMarkingBlockage
                          ? AmoledColors.hazardOrange.withValues(alpha: 0.15)
                          : AmoledColors.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isMarkingBlockage
                            ? AmoledColors.hazardOrange
                            : AmoledColors.border,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isMarkingBlockage
                              ? (isHindi ? 'अंकन रद्द करें' : 'Cancel marking')
                              : (isHindi ? 'सड़क अवरोध दर्ज करें' : 'Mark blockage'),
                          style: TextStyle(
                            fontSize: 12,
                            color: isMarkingBlockage
                                ? AmoledColors.hazardOrange
                                : AmoledColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          Icons.flag,
                          size: 16,
                          color: AmoledColors.hazardOrange,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isHindi
                      ? 'अवरोध दर्ज करने के लिए रास्ते पर टैप करें'
                      : 'Tap path to mark as blocked',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AmoledColors.textMuted,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
    });
  }

  Widget _buildSearchBar() {
    final isHindi = localeSignal.value == 'hi';

    return Container(
      decoration: BoxDecoration(
        color: AmoledColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AmoledColors.border),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        children: [
          const Icon(Icons.search, size: 16, color: AmoledColors.textSecondary),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              style: const TextStyle(
                  color: AmoledColors.textPrimary, fontSize: 12),
              decoration: InputDecoration(
                hintText: isHindi
                    ? 'स्थान खोजें (देहरादून, ऋषिकेश, एम्स…)'
                    : 'Search location (Dehradun, Rishikesh, AIIMS…)',
                hintStyle: const TextStyle(
                    color: AmoledColors.textSecondary, fontSize: 12),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear,
                  size: 14, color: AmoledColors.textSecondary),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                _searchController.clear();
                _onSearchChanged('');
              },
            ),
        ],
      ),
    );
  }

  Widget _buildSearchResultsOverlay() {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      constraints: const BoxConstraints(maxHeight: 180),
      decoration: BoxDecoration(
        color: AmoledColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AmoledColors.border),
        boxShadow: const [
          BoxShadow(color: Colors.black87, blurRadius: 10),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: _searchResults.length,
        separatorBuilder: (_, __) =>
            const Divider(color: AmoledColors.border, height: 1),
        itemBuilder: (ctx, idx) {
          final item = _searchResults[idx];
          return ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            leading: Icon(
              item.category == 'Hospital'
                  ? Icons.local_hospital
                  : item.category == 'Shelter'
                      ? Icons.home_work
                      : Icons.location_city,
              size: 16,
              color: item.category == 'Hospital'
                  ? AmoledColors.safeShelter
                  : item.category == 'Shelter'
                      ? AmoledColors.warningYellow
                      : Colors.white70,
            ),
            title: Text(
              item.name,
              style: const TextStyle(
                  color: AmoledColors.textPrimary, fontSize: 12),
            ),
            subtitle: Text(
              item.category,
              style: const TextStyle(
                  color: AmoledColors.textSecondary, fontSize: 10),
            ),
            trailing: const Icon(Icons.arrow_forward_ios,
                size: 10, color: AmoledColors.textMuted),
            onTap: () => _selectSearchResult(item),
          );
        },
      ),
    );
  }

  Widget _buildCheckboxTile({
    required String label,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: AmoledColors.surface,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AmoledColors.border),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                activeColor: AmoledColors.safeShelter,
                checkColor: Colors.black,
                side: const BorderSide(color: AmoledColors.border, width: 1.2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3)),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: AmoledColors.textPrimary,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
