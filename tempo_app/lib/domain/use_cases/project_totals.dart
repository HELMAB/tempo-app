import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/time_entry.dart';

part 'project_totals.freezed.dart';

/// Time tracked per project over a range. Finished entries are summed by
/// the database; the running entry (if it started in the range) is added
/// up to `now`, so totals stay live. Shared by Projects and Reports.
@freezed
abstract class ProjectTotals with _$ProjectTotals {
  const ProjectTotals._();

  const factory ProjectTotals({
    /// Keyed by project id; null holds entries without a project.
    required Map<int?, Duration> finished,
    TimeEntry? running,
  }) = _ProjectTotals;

  Duration trackedAt(int? projectId, DateTime now) {
    final finishedTotal = finished[projectId] ?? Duration.zero;
    return switch (running) {
      final running? when running.projectId == projectId =>
        finishedTotal + running.durationAt(now),
      _ => finishedTotal,
    };
  }

  /// 0..1+ of [weeklyGoal]; 0 when there is no goal.
  double goalFractionAt(int projectId, Duration weeklyGoal, DateTime now) =>
      weeklyGoal.inSeconds == 0
      ? 0
      : trackedAt(projectId, now).inSeconds / weeklyGoal.inSeconds;
}
