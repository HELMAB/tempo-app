import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/app.dart';
import 'package:tempo_app/config/dependencies.dart';

import '../testing/test_dependencies.dart';

void main() {
  Future<void> pumpApp(
    WidgetTester tester, {
    Map<String, Object> preferences = const {},
  }) async {
    final prefs = await createTestPreferences(preferences);
    final database = createTestDatabase();
    addTearDown(database.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          appDatabaseProvider.overrideWithValue(database),
        ],
        child: const TempoApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('first launch shows onboarding, Get started opens Today', (
    tester,
  ) async {
    await pumpApp(tester);

    expect(find.text('Know where your hours go.'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);

    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Know where your hours go.'), findsNothing);
  });

  testWidgets('returning user lands on Today and can switch tabs', (
    tester,
  ) async {
    await pumpApp(tester, preferences: {'onboarding_complete': true});

    expect(find.byType(NavigationBar), findsOneWidget);

    for (final tab in ['Projects', 'Reports', 'Settings', 'Today']) {
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(tab),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.widgetWithText(SafeArea, tab), findsWidgets);
    }
  });

  testWidgets('New project opens as a sheet over the tabs', (tester) async {
    await pumpApp(tester, preferences: {'onboarding_complete': true});

    await tester.tap(find.text('Projects').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('New project'));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsOneWidget);
  });
}
