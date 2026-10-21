import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../testing/app_tester.dart';

void main() {
  Future<void> openProjects(WidgetTester tester) async {
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Projects'),
      ),
    );
    await tester.pumpAndSettle();
  }

  testApp('create a project from the sheet, then archive and restore it', (
    tester,
    _,
  ) async {
    await openProjects(tester);
    expect(find.text('0 active'), findsOneWidget);

    await tester.tap(find.byTooltip('New project'));
    await tester.pumpAndSettle();
    expect(find.text('5h'), findsOneWidget);
    expect(find.text('about 43m a day'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Side project');
    await tester.tap(find.byTooltip('Increase weekly goal'));
    await tester.pump();
    expect(find.text('6h'), findsOneWidget);
    await tester.tap(find.text('Create project'));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsNothing);
    expect(find.text('1 active'), findsOneWidget);
    expect(find.text('Side project'), findsOneWidget);
    expect(find.text('0m of 6h goal'), findsOneWidget);

    await tester.tap(find.text('Side project'));
    await tester.pumpAndSettle();
    expect(find.text('Edit project'), findsOneWidget);
    await tester.tap(find.text('Archive project'));
    await tester.pumpAndSettle();

    expect(find.text('0 active'), findsOneWidget);
    await tester.tap(find.text('Archived · 1'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Side project'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Restore project'));
    await tester.pumpAndSettle();

    expect(find.text('1 active'), findsOneWidget);
  });

  testApp('All time shows totals without goals', (tester, _) async {
    await openProjects(tester);
    await tester.tap(find.byTooltip('New project'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Reading');
    // Let the button rebuild as enabled before tapping it.
    await tester.pump();
    await tester.tap(find.text('Create project'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('All time'));
    await tester.pumpAndSettle();

    expect(find.text('0m in total'), findsOneWidget);
    expect(find.text('0%'), findsNothing);
  });
}
