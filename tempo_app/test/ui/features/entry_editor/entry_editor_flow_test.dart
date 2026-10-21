import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/data/repositories/time_entry_repository.dart';

import '../../../testing/app_tester.dart';

void main() {
  DateTime clock() => DateTime(2026, 10, 20, 12);

  testApp('Add manually creates an entry that shows on Today', (
    tester,
    _,
  ) async {
    await tester.tap(find.text('Add manually'));
    await tester.pumpAndSettle();
    expect(find.text('New entry'), findsOneWidget);
    expect(find.text('1h 00m'), findsOneWidget, reason: 'default: last hour');
    expect(find.text('Delete entry'), findsNothing);

    await tester.enterText(find.byType(TextField).first, 'Planning');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Planning'), findsOneWidget);
    expect(find.text('No project · 11:00–12:00'), findsOneWidget);
  }, clock: clock);

  testApp('tapping an entry edits it; delete asks first', (
    tester,
    database,
  ) async {
    await TimeEntryRepository(database: database).addEntry(
      description: 'Code review',
      startAt: DateTime(2026, 10, 20, 9),
      endAt: DateTime(2026, 10, 20, 9, 55),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Code review'));
    await tester.pumpAndSettle();
    expect(find.text('Edit entry'), findsOneWidget);
    expect(find.text('55m'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, 'Code review #12');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Code review #12'), findsOneWidget);

    await tester.tap(find.text('Code review #12'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Delete entry'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete entry'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.text('Delete'),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('No entries yet. Start a timer or add one manually.'),
      findsOneWidget,
    );
  }, clock: clock);
}
