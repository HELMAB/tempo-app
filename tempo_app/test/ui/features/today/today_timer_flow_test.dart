import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/data/repositories/project_repository.dart';
import 'package:tempo_app/data/repositories/time_entry_repository.dart';

import '../../../testing/app_tester.dart';

void main() {
  DateTime clock() => DateTime(2026, 10, 20, 12);

  testApp('Today lists entries with totals against the goal', (
    tester,
    database,
  ) async {
    final project = await ProjectRepository(
      database: database,
    ).createProject(name: 'Flutter course', color: 0xFF2B50E6);
    await TimeEntryRepository(database: database).addEntry(
      projectId: project.id,
      description: 'Build timer screen',
      startAt: DateTime(2026, 10, 20, 9),
      endAt: DateTime(2026, 10, 20, 10, 45),
    );
    await tester.pumpAndSettle();

    expect(find.text('Tuesday, 20 October'), findsOneWidget);
    expect(find.text('Build timer screen'), findsOneWidget);
    expect(find.text('Flutter course · 09:00–10:45'), findsOneWidget);
    expect(find.text('1:45:00'), findsOneWidget);
    expect(find.text('1h 45m'), findsOneWidget);
    expect(find.text('22% of 8h goal'), findsOneWidget);
  }, clock: clock);

  testApp('start from Today, pause, resume, then stop & save', (
    tester,
    _,
  ) async {
    await tester.enterText(find.byType(EditableText), 'Write tests');
    await tester.tap(find.byTooltip('Start timer'));
    await tester.pumpAndSettle();

    expect(find.text('Tracking'), findsOneWidget);
    expect(find.text('Write tests'), findsOneWidget);
    expect(find.text('of 2h focus goal'), findsOneWidget);

    await tester.tap(find.byTooltip('Pause'));
    await tester.pumpAndSettle();
    expect(find.text('Paused'), findsOneWidget);

    await tester.tap(find.byTooltip('Resume'));
    await tester.pumpAndSettle();
    expect(find.text('Tracking'), findsOneWidget);

    await tester.tap(find.byTooltip('Stop & save'));
    await tester.pumpAndSettle();

    expect(find.text('What are you working on?'), findsOneWidget);
    // One entry from before the pause and one from after it.
    expect(find.text('Write tests'), findsNWidgets(2));
  }, clock: clock);

  testApp('discard asks first, then deletes the running entry', (
    tester,
    _,
  ) async {
    await tester.tap(find.byTooltip('Start timer'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Discard'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.text('Discard'),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('No entries yet. Start a timer or add one manually.'),
      findsOneWidget,
    );
  }, clock: clock);
}
