import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'config/dependencies.dart';

Future<void> main() async {
  // Keep the native splash (flutter_native_splash.yaml) up while loading.
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  // Web: clean URLs (/projects, not /#/projects). No-op elsewhere; the
  // host rewrites unknown paths to index.html (see vercel.json).
  usePathUrlStrategy();

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['Google Sans'], license);
  });

  final preferences = await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(),
  );

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
      child: const TempoApp(),
    ),
  );
  // Lets the first frame through; on the web it also removes the HTML splash.
  FlutterNativeSplash.remove();
}
