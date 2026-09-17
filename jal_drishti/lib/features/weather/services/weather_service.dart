import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:geolocator/geolocator.dart';
import '../../../shared/database/isar_service.dart';
import '../../../shared/models/schemas.dart';

class WeatherService {
  static const String _apiKey = 'c35686a27f506310cadfda8efd175fcd';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/forecast';
  static const String _defaultCity = 'Dehradun';
  static const double _defaultLat = 30.3165;
  static const double _defaultLon = 78.0322;

  Future<Map<String, dynamic>?> getForecast() async {
    double lat = _defaultLat;
    double lon = _defaultLon;

    // Try to get current location
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled) {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }
        if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
          Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
          lat = position.latitude;
          lon = position.longitude;
        }
      }
    } catch (e) {
      // Fallback to default Dehradun coordinates
    }

    final locationKey = '${lat.toStringAsFixed(2)}_${lon.toStringAsFixed(2)}';
    final url = Uri.parse('$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey&units=metric');

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final jsonString = response.body;

        // Cache in Isar
        final isar = IsarService().db;
        final weather = WeatherForecast()
          ..locationKey = 'latest'
          ..forecastJson = jsonString
          ..lastUpdated = DateTime.now();

        await isar.writeTxn(() async {
          await isar.weatherForecasts.put(weather);
        });

        final data = json.decode(jsonString);
        data['isCached'] = false;
        return data;
      }
    } catch (e) {
      // Network error, read from cache
    }

    return _getOfflineForecast();
  }

  Future<Map<String, dynamic>?> _getOfflineForecast() async {
    final isar = IsarService().db;
    final cached = await isar.weatherForecasts.filter().locationKeyEqualTo('latest').findFirst();
    if (cached != null) {
      final data = json.decode(cached.forecastJson);
      data['isCached'] = true;
      data['lastUpdated'] = cached.lastUpdated.toIso8601String();
      return data;
    }
    return null;
  }
}
