import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/weather_service.dart';
import '../../../../app/theme/amoled_theme.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  Map<String, dynamic>? _weatherData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    setState(() => _isLoading = true);
    final data = await _weatherService.getForecast();
    setState(() {
      _weatherData = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AmoledColors.background,
        body: Center(child: CircularProgressIndicator(color: AmoledColors.riverCyan)),
      );
    }

    if (_weatherData == null) {
      return Scaffold(
        backgroundColor: AmoledColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_off, color: AmoledColors.textMuted, size: 64),
              const SizedBox(height: 16),
              const Text('No weather data available.', style: TextStyle(color: AmoledColors.textPrimary)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _fetchWeather,
                child: const Text('Retry'),
              )
            ],
          ),
        ),
      );
    }

    final isCached = _weatherData!['isCached'] ?? false;
    final city = _weatherData!['city']['name'];
    final list = _weatherData!['list'] as List<dynamic>;
    final current = list.isNotEmpty ? list.first : null;

    return Scaffold(
      backgroundColor: AmoledColors.background,
      appBar: AppBar(
        title: Text(city),
        backgroundColor: AmoledColors.navBorder,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchWeather,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (isCached)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                color: Colors.orange.withOpacity(0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off, color: Colors.orange, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'OFFLINE MODE - Last updated: ${DateFormat('MMM d, h:mm a').format(DateTime.parse(_weatherData!['lastUpdated']).toLocal())}',
                      style: const TextStyle(color: Colors.orange, fontSize: 12),
                    ),
                  ],
                ),
              )
            else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                color: Colors.green.withOpacity(0.2),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi, color: Colors.green, size: 16),
                    SizedBox(width: 8),
                    Text('LIVE DATA', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            if (current != null) ...[
              const SizedBox(height: 32),
              Text(
                '${current['main']['temp'].round()}°C',
                style: const TextStyle(color: AmoledColors.textPrimary, fontSize: 64, fontWeight: FontWeight.w200),
              ),
              Text(
                current['weather'][0]['description'].toString().toUpperCase(),
                style: const TextStyle(color: AmoledColors.riverCyan, fontSize: 18, letterSpacing: 1.2),
              ),
              const SizedBox(height: 8),
              Text(
                'Humidity: ${current['main']['humidity']}%',
                style: const TextStyle(color: AmoledColors.textMuted, fontSize: 14),
              ),
              const SizedBox(height: 32),
            ],
            const Divider(color: AmoledColors.navBorder),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('5-Day Forecast', style: TextStyle(color: AmoledColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final item = list[index];
                  final time = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
                  final temp = item['main']['temp'].round();
                  final desc = item['weather'][0]['main'];

                  return ListTile(
                    leading: const Icon(Icons.cloud, color: AmoledColors.textMuted),
                    title: Text(DateFormat('EEEE, MMM d - h:mm a').format(time), style: const TextStyle(color: AmoledColors.textPrimary)),
                    subtitle: Text(desc, style: const TextStyle(color: AmoledColors.textMuted)),
                    trailing: Text('$temp°C', style: const TextStyle(color: AmoledColors.textPrimary, fontSize: 16)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
