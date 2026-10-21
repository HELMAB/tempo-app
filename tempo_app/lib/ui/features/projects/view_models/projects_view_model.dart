import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/dependencies.dart';
import '../../../../domain/use_cases/project_totals.dart';
import '../../../../utils/dates.dart';
import 'projects_ui_state.dart';

final projectsViewModelProvider =
    AsyncNotifierProvider.autoDispose<ProjectsViewModel, ProjectsUiState>(
      ProjectsViewModel.new,
    );

class ProjectsViewModel extends AsyncNotifier<ProjectsUiState> {
  ProjectsRange _range = ProjectsRange.thisWeek;

  @override
  Future<ProjectsUiState> build() async {
    final settings = await ref.watch(appSettingsProvider.future);
    final from = switch (_range) {
      ProjectsRange.thisWeek => startOfWeek(
        ref.watch(clockProvider)(),
        weekStartsOn: settings.weekStartsOn,
      ),
      ProjectsRange.allTime => null,
    };
    final (projects, finished, running) = await (
      ref.watch(projectsProvider.future),
      ref.watch(finishedTotalsByProjectProvider((from: from, to: null)).future),
      ref.watch(runningEntryProvider.future),
    ).wait;

    return ProjectsUiState(
      range: _range,
      active: [...projects.where((p) => !p.archived)],
      archived: [...projects.where((p) => p.archived)],
      totals: ProjectTotals(
        finished: finished,
        running: switch (running) {
          final running? when from == null || !running.startAt.isBefore(from) =>
            running,
          _ => null,
        },
      ),
    );
  }

  void selectRange(ProjectsRange range) {
    if (range == _range) return;
    _range = range;
    ref.invalidateSelf();
  }
}
