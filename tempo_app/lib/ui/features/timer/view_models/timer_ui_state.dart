import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/models/project.dart';
import '../../../../domain/models/time_entry.dart';
import '../../../../domain/use_cases/daily_progress.dart';

part 'timer_ui_state.freezed.dart';

@freezed
abstract class TimerUiState with _$TimerUiState {
  const TimerUiState._();

  const factory TimerUiState({
    /// The running entry, or the entry that was just paused. Null when
    /// there is nothing to show (stopped elsewhere).
    required TimeEntry? entry,
    required bool isPaused,
    required Project? project,

    /// Active projects for the picker.
    required List<Project> projects,
    required List<String> tagNames,
    required Duration focusGoal,
    required List<TimeEntry> todayEntries,
    required Map<int, Project> projectsById,
    required Duration dailyGoal,
  }) = _TimerUiState;

  DailyProgress todayProgressAt(DateTime now) => DailyProgress.of(
    entries: todayEntries,
    projectsById: projectsById,
    goal: dailyGoal,
    now: now,
  );

  bool get isRunning => entry != null && !isPaused;

  double focusFractionAt(DateTime now) => switch (entry) {
    final entry? when focusGoal > Duration.zero =>
      entry.durationAt(now).inSeconds / focusGoal.inSeconds,
    _ => 0,
  };
}
