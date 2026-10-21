import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/models/project.dart';
import '../../../../domain/use_cases/project_totals.dart';

part 'projects_ui_state.freezed.dart';

enum ProjectsRange { thisWeek, allTime }

@freezed
abstract class ProjectsUiState with _$ProjectsUiState {
  const ProjectsUiState._();

  const factory ProjectsUiState({
    required ProjectsRange range,
    required List<Project> active,
    required List<Project> archived,
    required ProjectTotals totals,
  }) = _ProjectsUiState;

  /// Weekly goals only make sense for the "This week" range.
  bool get showsGoals => range == ProjectsRange.thisWeek;

  bool get hasRunningEntry => totals.running != null;
}
