import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/l10n/app_localizations.dart';

import '../testing/app_tester.dart';

void main() {
  final km = lookupAppLocalizations(const Locale('km'));
  final en = lookupAppLocalizations(const Locale('en'));

  testApp(
    'first launch shows onboarding in Khmer, the default language',
    (tester, _) async {
      expect(find.text(km.onboardingHeadline), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);

      await tester.tap(find.text(km.onboardingGetStarted));
      await tester.pumpAndSettle();

      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.text(km.navToday), findsWidgets);
    },
    preferences: const {},
  );

  testApp('returning user lands on Today and can switch tabs', (
    tester,
    _,
  ) async {
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text(en.quickStartHint), findsOneWidget);

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

  testApp('New project opens as a sheet over the tabs', (tester, _) async {
    await tester.tap(find.text('Projects').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('New project'));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsOneWidget);
  });

  testApp(
    'the language can be switched in Settings',
    (tester, _) async {
      await tester.tap(find.text(km.navSettings).last);
      await tester.pumpAndSettle();
      expect(find.text('ខ្មែរ'), findsOneWidget);

      await tester.ensureVisible(find.text(km.settingsLanguage));
      await tester.pumpAndSettle();
      await tester.tap(find.text(km.settingsLanguage));
      await tester.pumpAndSettle();
      await tester.tap(find.text('English'));
      await tester.pumpAndSettle();

      expect(find.text(en.navSettings), findsWidgets);
      expect(find.text(en.navToday), findsOneWidget);
      expect(find.text(km.navToday), findsNothing);
    },
    preferences: const {'onboarding_complete': true},
  );
}
