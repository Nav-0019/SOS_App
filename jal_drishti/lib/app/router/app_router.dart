import 'package:flutter/material.dart';

import '../../features/map/presentation/screens/map_screen.dart';
import '../../features/sos/presentation/screens/sos_screen.dart';
import '../../features/mesh/presentation/screens/mesh_chat_screen.dart';
import '../../features/assistant/presentation/screens/assistant_screen.dart';
import '../../features/weather/presentation/screens/weather_screen.dart';
import '../theme/amoled_theme.dart';
import '../../shared/localization/locale_service.dart';

import 'package:signals_flutter/signals_flutter.dart';

final activeTabSignal = signal<int>(0);

class AppRouter {
  AppRouter._();

  static const String map = '/map';
  static const String sos = '/sos';
  static const String mesh = '/mesh';
  static const String assistant = '/assistant';
  static const String weather = '/weather';

  static void switchTab(int index) {
    activeTabSignal.value = index;
  }

  static Map<String, WidgetBuilder> get routes => {
        '/': (_) => const MainShell(),
        map: (_) => const MapScreen(),
        sos: (_) => const SosScreen(),
        mesh: (_) => const MeshChatScreen(),
        assistant: (_) => const AssistantScreen(),
        weather: (_) => const WeatherScreen(),
        
      };
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  final List<Widget> _screens = const [
    MapScreen(),
    SosScreen(),
    MeshChatScreen(),
    AssistantScreen(),
    WeatherScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      final currentIndex = activeTabSignal.value;

      return Scaffold(
        backgroundColor: AmoledColors.background,
        body: IndexedStack(
          index: currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: AmoledColors.background,
            border: Border(
              top: BorderSide(color: AmoledColors.navBorder, width: 1.0),
            ),
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 56,
              child: Watch((context) {
                // Track localeSignal so nav bar updates instantly on language switch
                final _ = localeSignal.value;
                return Row(
                  children: [
                    _buildNavItem(
                      index: 0,
                      icon: Icons.map_outlined,
                      activeIcon: Icons.map,
                      label: AppStrings.tr('nav_map'),
                      currentIndex: currentIndex,
                      activeColor: AmoledColors.safeShelter,
                    ),
                    _buildNavItem(
                      index: 1,
                      icon: Icons.warning_amber_rounded,
                      activeIcon: Icons.warning_rounded,
                      label: AppStrings.tr('nav_sos'),
                      currentIndex: currentIndex,
                      activeColor: AmoledColors.sosDanger,
                    ),
                    _buildNavItem(
                      index: 2,
                      icon: Icons.bluetooth_searching,
                      activeIcon: Icons.bluetooth_connected,
                      label: AppStrings.tr('nav_mesh'),
                      currentIndex: currentIndex,
                      activeColor: AmoledColors.safeShelter,
                    ),
                    _buildNavItem(
                      index: 3,
                      icon: Icons.medical_services_outlined,
                      activeIcon: Icons.medical_services,
                      label: AppStrings.tr('nav_assistant'),
                      currentIndex: currentIndex,
                      activeColor: AmoledColors.safeShelter,
                    ),
                    _buildNavItem(
                      index: 4,
                      icon: Icons.cloud_outlined,
                      activeIcon: Icons.cloud,
                      label: AppStrings.tr('nav_weather'),
                      currentIndex: currentIndex,
                      activeColor: Colors.blueAccent,
                    ),

                  ],
                );
              }),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int currentIndex,
    required Color activeColor,
  }) {
    final isSelected = index == currentIndex;
    final color = isSelected ? activeColor : AmoledColors.textMuted;

    return Expanded(
      child: InkWell(
        onTap: () => activeTabSignal.value = index,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: color,
              size: 20,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


