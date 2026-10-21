import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/config/dependencies.dart';
import 'package:tempo_app/data/repositories/time_entry_repository.dart';
import 'package:tempo_app/domain/models/project.dart';
import 'package:tempo_app/domain/models/time_entry.dart';
import 'package:tempo_app/domain/use_cases/backup_format.dart';

import '../../../testing/app_tester.dart';
import '../../../testing/fakes.dart';

void main() {
  Future<void> openSettings(WidgetTester tester) async {
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Settings'),
      ),
    );
    await tester.pumpAndSettle();
  }

  testApp(
    'shows every section; daily goal and week start can change',
    (tester, _) async {
      await openSettings(tester);
      for (final title in [
        'TRACKING',
        'REMINDERS',
        'APPEARANCE',
        'DATA',
        'Daily goal',
        'Idle detection',
        'Remind me to start',
      ]) {
        expect(find.text(title), findsOneWidget, reason: title);
      }

      await tester.tap(find.text('Daily goal'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Increase'));
      await tester.pump();
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(find.text('8h 30m'), findsOneWidget);

      await tester.tap(find.text('Week starts on'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sunday'));
      await tester.pumpAndSettle();
      expect(find.text('Sunday'), findsOneWidget);
    },
    overrides: [
      notificationServiceProvider.overrideWithValue(FakeNotificationService()),
    ],
  );

  testApp(
    'refused notification permission keeps the reminder off',
    (tester, _) async {
      await openSettings(tester);
      // Switches: idle detection, remind me to start, running timer.
      final reminder = find.byType(Switch).at(1);
      // On by default; turning it off needs no permission, back on asks.
      await tester.tap(reminder);
      await tester.pumpAndSettle();
      await tester.tap(reminder);
      await tester.pumpAndSettle();

      expect(
        find.text('Notifications are turned off for Tempo in system settings.'),
        findsOneWidget,
      );
      expect(tester.widget<Switch>(reminder).value, isFalse);
    },
    overrides: [
      notificationServiceProvider.overrideWithValue(
        FakeNotificationService(grantPermission: false),
      ),
    ],
  );

  final files = FakeFileService()
    ..pickedText = BackupFormat.encode((
      projects: [const Project(id: 1, name: 'Restored project', color: 0)],
      entries: [
        TimeEntry(
          id: 1,
          projectId: 1,
          description: 'From backup',
          startAt: DateTime(2026, 10, 20, 9),
          endAt: DateTime(2026, 10, 20, 10),
        ),
      ],
    ), exportedAt: DateTime(2026, 10, 20));

  testApp(
    'restore asks first, then replaces the data',
    (tester, database) async {
      await TimeEntryRepository(database: database).addEntry(
        description: 'Will be replaced',
        startAt: DateTime(2026, 10, 20, 8),
        endAt: DateTime(2026, 10, 20, 9),
      );
      await openSettings(tester);
      await tester.ensureVisible(find.text('Backup & restore'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Backup & restore'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Restore from a backup'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Replace'));
      await tester.pumpAndSettle();

      expect(find.text('Restored 1 projects and 1 entries.'), findsOneWidget);
      final entries = await TimeEntryRepository(
        database: database,
      ).getEntries();
      expect(entries.single.description, 'From backup');
    },
    overrides: [fileServiceProvider.overrideWithValue(files)],
  );

  testApp(
    'onboarding can start from a backup',
    (tester, database) async {
      await tester.tap(find.text('Restore from a backup'));
      await tester.pumpAndSettle();

      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.text('From backup'), findsNothing, reason: 'not today');
      final entries = await TimeEntryRepository(
        database: database,
      ).getEntries();
      expect(entries.single.description, 'From backup');
    },
    preferences: const {'language': 'english'},
    overrides: [fileServiceProvider.overrideWithValue(files)],
  );
}
