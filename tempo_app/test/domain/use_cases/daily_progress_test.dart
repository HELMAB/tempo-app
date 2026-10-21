import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/domain/models/project.dart';
import 'package:tempo_app/domain/models/time_entry.dart';
import 'package:tempo_app/domain/use_cases/daily_progress.dart';

void main() {
  final now = DateTime(2026, 10, 20, 12);
  const counted = Project(id: 1, name: 'Flutter course', color: 0);
  const notCounted = Project(
    id: 2,
    name: 'Reading',
    color: 0,
    countsTowardDailyGoal: false,
  );

  TimeEntry entry(int projectId, int startHour, int? endHour) => TimeEntry(
    id: startHour,
    projectId: projectId == 0 ? null : projectId,
    startAt: DateTime(2026, 10, 20, startHour),
    endAt: endHour == null ? null : DateTime(2026, 10, 20, endHour),
  );

  test('tracks everything but only counts goal projects', () {
    final progress = DailyProgress.of(
      entries: [entry(1, 8, 10), entry(2, 10, 11), entry(0, 11, null)],
      projectsById: {1: counted, 2: notCounted},
      goal: const Duration(hours: 8),
      now: now,
    );

    expect(progress.tracked, const Duration(hours: 4));
    // 2h Flutter course + 1h running entry without a project.
    expect(progress.counted, const Duration(hours: 3));
    expect(progress.goalFraction, 3 / 8);
  });

  test('a zero goal never divides by zero', () {
    final progress = DailyProgress.of(
      entries: [entry(1, 8, 9)],
      projectsById: {1: counted},
      goal: Duration.zero,
      now: now,
    );

    expect(progress.goalFraction, 0);
  });
}
