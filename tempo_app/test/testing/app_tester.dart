import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tempo_app/app.dart';
import 'package:tempo_app/config/dependencies.dart';
import 'package:tempo_app/data/services/database/app_database.dart';

import 'test_dependencies.dart';

/// Widget test running the whole app on an in-memory database.
///
/// The app is unmounted at the end of [body] so drift can finish cancelling
/// its stream queries before the test checks for pending timers.
@isTest
void testApp(
  String description,
  Future<void> Function(WidgetTester tester, AppDatabase database) body, {
  // English, so tests read naturally; Khmer (the default) is covered by
  // tests that pass their own preferences.
  Map<String, Object> preferences = const {
    'onboarding_complete': true,
    'language': 'english',
  },
  DateTime Function()? clock,
  List<Override> overrides = const [],
  // As if the OS "reduce motion" setting were on: no launch intro and no
  // repeating animations, so pumpAndSettle can finish.
  bool reduceMotion = true,
}) {
  testWidgets(description, (tester) async {
    if (reduceMotion) {
      tester.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(disableAnimations: true);
      addTearDown(
        tester.platformDispatcher.clearAccessibilityFeaturesTestValue,
      );
    }
    // Prototype frame: 390 × 844.
    tester.view
      ..physicalSize = const Size(1170, 2532)
      ..devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    PackageInfo.setMockInitialValues(
      appName: 'Tempo',
      packageName: 'com.example.tempo_app',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '',
    );
    final prefs = await createTestPreferences(preferences);
    final database = createTestDatabase();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          appDatabaseProvider.overrideWithValue(database),
          if (clock != null) clockProvider.overrideWithValue(clock),
          ...overrides,
        ],
        child: const TempoApp(),
      ),
    );
    await tester.pumpAndSettle();

    await body(tester, database);

    await tester.pumpWidget(const SizedBox());
    await tester.pump(Duration.zero);
    await database.close();
  });
}
