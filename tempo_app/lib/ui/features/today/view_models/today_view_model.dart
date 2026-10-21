import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/dependencies.dart';
import '../../../../domain/models/project.dart';
import '../../../../domain/models/time_entry.dart';
import '../../../../utils/dates.dart';
import 'today_ui_state.dart';

final todayViewModelProvider =
    AsyncNotifierProvider.autoDispose<TodayViewModel, TodayUiState>(
      TodayViewModel.new,
    );

class TodayViewModel extends AsyncNotifier<TodayUiState> {
  /// Set once the user picks a quick-start project; until then the project
  /// of the latest entry is suggested.
  ({int? projectId})? _quickStartChoice;

  @override
  Future<TodayUiState> build() async {
    final day = startOfDay(ref.watch(clockProvider)());
    final (entries, projects, running, settings) = await (
      ref.watch(entriesOnDayProvider(day).future),
      ref.watch(projectsProvider.future),
      ref.watch(runningEntryProvider.future),
      ref.watch(appSettingsProvider.future),
    ).wait;

    final projectsById = {for (final p in projects) p.id: p};
    final active = projects.where((p) => !p.archived).toList();

    return TodayUiState(
      day: day,
      entries: [
        for (final entry in entries)
          (entry: entry, project: projectsById[entry.projectId]),
      ],
      projects: active,
      quickStartProject: _quickStartProject(entries, projectsById, active),
      running: running == null
          ? null
          : (entry: running, project: projectsById[running.projectId]),
      dailyGoal: Duration(minutes: settings.dailyGoalMinutes),
    );
  }

  void selectQuickStartProject(int? projectId) {
    _quickStartChoice = (projectId: projectId);
    ref.invalidateSelf();
  }

  /// Starts a timer from the quick-start card; stops any running one.
  Future<void> startTimer({required String description}) async {
    final current = state.value;
    await ref
        .read(timeEntryRepositoryProvider)
        .startTimer(
          projectId: current?.quickStartProject?.id,
          description: description,
        );
  }

  /// Starts a new timer with the same details as [entry].
  Future<void> continueEntry(TimeEntry entry) async {
    await ref
        .read(timeEntryRepositoryProvider)
        .startTimer(
          projectId: entry.projectId,
          description: entry.description,
          tags: entry.tags,
        );
  }

  Future<void> stopTimer() => ref.read(timeEntryRepositoryProvider).stopTimer();

  Project? _quickStartProject(
    List<TimeEntry> entries,
    Map<int, Project> projectsById,
    List<Project> active,
  ) {
    final chosenId = switch (_quickStartChoice) {
      (:final projectId) => projectId,
      null => entries.lastOrNull?.projectId ?? active.firstOrNull?.id,
    };
    final project = projectsById[chosenId];
    return project == null || project.archived ? null : project;
  }
}
