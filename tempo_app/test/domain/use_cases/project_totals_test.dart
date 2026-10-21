import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/domain/models/time_entry.dart';
import 'package:tempo_app/domain/use_cases/project_totals.dart';

void main() {
  final now = DateTime(2026, 10, 20, 12);
  final totals = ProjectTotals(
    finished: {1: const Duration(hours: 3), null: const Duration(minutes: 20)},
    running: TimeEntry(
      id: 9,
      projectId: 1,
      startAt: DateTime(2026, 10, 20, 11),
    ),
  );

  test('adds the running entry to its project only', () {
    expect(totals.trackedAt(1, now), const Duration(hours: 4));
    expect(totals.trackedAt(null, now), const Duration(minutes: 20));
    expect(totals.trackedAt(2, now), Duration.zero);
  });

  test('goal fraction is 0 without a goal', () {
    expect(totals.goalFractionAt(1, const Duration(hours: 8), now), 0.5);
    expect(totals.goalFractionAt(1, Duration.zero, now), 0);
  });
}
