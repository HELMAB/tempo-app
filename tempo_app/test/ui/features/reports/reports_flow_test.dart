import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/config/dependencies.dart';
import 'package:tempo_app/data/repositories/project_repository.dart';
import 'package:tempo_app/data/repositories/time_entry_repository.dart';

import '../../../testing/app_tester.dart';
import '../../../testing/fakes.dart';

void main() {
  DateTime clock() => DateTime(2026, 10, 20, 17);
  final files = FakeFileService();

  Future<void> openReports(WidgetTester tester) async {
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Reports'),
      ),
    );
    await tester.pumpAndSettle();
  }

  testApp(
    'shows the week total, comparison and projects; exports CSV',
    (tester, database) async {
      final project = await ProjectRepository(
        database: database,
      ).createProject(name: 'Flutter course', color: 0xFF2B50E6);
      final entries = TimeEntryRepository(database: database);
      await entries.addEntry(
        projectId: project.id,
        startAt: DateTime(2026, 10, 19, 9),
        endAt: DateTime(2026, 10, 19, 13, 30),
      );
      await entries.addEntry(
        startAt: DateTime(2026, 10, 12, 9),
        endAt: DateTime(2026, 10, 12, 10),
      );
      await openReports(tester);

      expect(find.text('19 – 25 Oct'), findsOneWidget);
      expect(find.text('Total this week'), findsOneWidget);
      expect(find.text('4h 30m'), findsWidgets);
      expect(find.text('+3h 30m vs last week'), findsOneWidget);
      expect(find.text('Flutter course'), findsOneWidget);

      await tester.tap(find.byTooltip('Export CSV'));
      await tester.pumpAndSettle();
      expect(files.shared.last.fileName, 'tempo-2026-10-19-to-2026-10-25.csv');

      await tester.tap(find.byTooltip('Previous'));
      await tester.pumpAndSettle();
      expect(find.text('12 – 18 Oct'), findsOneWidget);
      expect(find.text('Total'), findsOneWidget);

      await tester.tap(find.text('Month'));
      await tester.pumpAndSettle();
      expect(find.text('October 2026'), findsOneWidget);
      expect(find.text('5h 30m'), findsWidgets);
    },
    clock: clock,
    overrides: [fileServiceProvider.overrideWithValue(files)],
  );

  testApp('an empty period says so', (tester, _) async {
    await openReports(tester);

    expect(find.text('Nothing tracked in this period.'), findsOneWidget);
  }, clock: clock);
}
