import '../models/project.dart';
import '../models/time_entry.dart';

/// A day's totals against the daily goal. Shared by Today and the running
/// timer; the running entry counts up to [now].
final class DailyProgress {
  const DailyProgress._({
    required this.tracked,
    required this.counted,
    required this.goal,
  });

  factory DailyProgress.of({
    required Iterable<TimeEntry> entries,
    required Map<int, Project> projectsById,
    required Duration goal,
    required DateTime now,
  }) {
    var tracked = Duration.zero;
    var counted = Duration.zero;
    for (final entry in entries) {
      final duration = entry.durationAt(now);
      tracked += duration;
      // Entries without a project always count toward the goal.
      final project = projectsById[entry.projectId];
      if (project?.countsTowardDailyGoal ?? true) counted += duration;
    }
    return DailyProgress._(tracked: tracked, counted: counted, goal: goal);
  }

  /// Everything tracked on the day.
  final Duration tracked;

  /// Time from projects that count toward the daily goal.
  final Duration counted;
  final Duration goal;

  /// 0..1+ — can exceed 1 once the goal is passed.
  double get goalFraction =>
      goal.inSeconds == 0 ? 0 : counted.inSeconds / goal.inSeconds;
}
