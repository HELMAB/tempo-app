import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/models/project.dart';
import '../../../../domain/models/time_entry.dart';
import '../../../../domain/use_cases/daily_progress.dart';

part 'today_ui_state.freezed.dart';

typedef EntryWithProject = ({TimeEntry entry, Project? project});

@freezed
abstract class TodayUiState with _$TodayUiState {
  const TodayUiState._();

  const factory TodayUiState({
    required DateTime day,

    /// Oldest first, as in the prototype.
    required List<EntryWithProject> entries,

    /// Active projects for the quick-start picker.
    required List<Project> projects,

    /// Project the next quick-start timer will use.
    required Project? quickStartProject,
    required EntryWithProject? running,
    required Duration dailyGoal,
  }) = _TodayUiState;

  DailyProgress progressAt(DateTime now) => DailyProgress.of(
    entries: entries.map((e) => e.entry),
    projectsById: {
      for (final project in entries.map((e) => e.project).nonNulls)
        project.id: project,
    },
    goal: dailyGoal,
    now: now,
  );
}
