import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/theme/amoled_theme.dart';
import 'app/router/app_router.dart';
import 'shared/database/isar_service.dart';
import 'shared/localization/locale_service.dart';
import 'shared/services/tts_service.dart';
import 'features/sos/services/sos_gateway_service.dart';

import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';

/// Global flag – true only when the FMTC backend initialised successfully.
/// Checked by map_screen before using [FMTCTileProvider] or starting downloads.
bool fmtcReady = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AmoledColors.background,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Initialize FMTC tile-cache backend
  try {
    await FMTCObjectBoxBackend().initialise();
    await const FMTCStore('mapStore').manage.create();
    fmtcReady = true;
    debugPrint('FMTC: initialized successfully');
  } catch (e) {
    fmtcReady = false;
    debugPrint('FMTC: initialization failed – $e');
  }

  await IsarService().initialize();
  await LocaleService().initialize();
  await TtsService().initialize();
  SosGatewayService().start();

  runApp(const JalDrishtiApp());
}

class JalDrishtiApp extends StatelessWidget {
  const JalDrishtiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jal Drishti',
      debugShowCheckedModeBanner: false,
      theme: AmoledTheme.theme,
      initialRoute: '/',
      routes: AppRouter.routes,
    );
  }
}

