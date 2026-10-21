import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../config/dependencies.dart';
import '../../../../domain/models/project.dart';
import '../../../core/themes/app_colors.dart';

part 'project_editor_view_model.freezed.dart';

@freezed
abstract class ProjectEditorUiState with _$ProjectEditorUiState {
  const ProjectEditorUiState._();

  const factory ProjectEditorUiState({
    /// Null when creating a project.
    required int? projectId,
    required String name,
    required int color,
    required int weeklyGoalMinutes,
    required bool countsTowardDailyGoal,
    required bool archived,

    /// From settings, for "Adds this project's time to your 8h target".
    required Duration dailyGoal,
  }) = _ProjectEditorUiState;

  bool get isNew => projectId == null;
  bool get canSave => name.trim().isNotEmpty;
  Duration get weeklyGoal => Duration(minutes: weeklyGoalMinutes);
  bool get canDecreaseGoal => weeklyGoalMinutes > 0;
  bool get canIncreaseGoal =>
      weeklyGoalMinutes < ProjectEditorViewModel.maxWeeklyGoalMinutes;
}

/// Keyed by project id; null creates a project. State is null when the
/// project to edit no longer exists.
final projectEditorViewModelProvider = AsyncNotifierProvider.autoDispose
    .family<ProjectEditorViewModel, ProjectEditorUiState?, int?>(
      ProjectEditorViewModel.new,
    );

class ProjectEditorViewModel extends AsyncNotifier<ProjectEditorUiState?> {
  ProjectEditorViewModel(this.projectId);

  final int? projectId;

  static const maxWeeklyGoalMinutes = 80 * 60;
  static const _goalStepMinutes = 60;
  static const _defaultWeeklyGoalMinutes = 5 * 60;

  /// Created on the first build; later rebuilds keep the user's edits.
  ProjectEditorUiState? _form;

  @override
  Future<ProjectEditorUiState?> build() async {
    // Watched, not read: Riverpod pauses providers nobody listens to, so a
    // read could wait forever when the sheet is opened by a deep link.
    final (settings, projects) = await (
      ref.watch(appSettingsProvider.future),
      ref.watch(projectsProvider.future),
    ).wait;
    final dailyGoal = Duration(minutes: settings.dailyGoalMinutes);

    if (_form case final form?) {
      return _form = form.copyWith(dailyGoal: dailyGoal);
    }

    if (projectId case final id?) {
      final project = projects.where((p) => p.id == id).firstOrNull;
      if (project == null) return null;
      return _form = ProjectEditorUiState(
        projectId: id,
        name: project.name,
        color: project.color,
        weeklyGoalMinutes: project.weeklyGoalMinutes,
        countsTowardDailyGoal: project.countsTowardDailyGoal,
        archived: project.archived,
        dailyGoal: dailyGoal,
      );
    }
    return _form = ProjectEditorUiState(
      projectId: null,
      name: '',
      color: _unusedColor(projects),
      weeklyGoalMinutes: _defaultWeeklyGoalMinutes,
      countsTowardDailyGoal: true,
      archived: false,
      dailyGoal: dailyGoal,
    );
  }

  void setName(String name) => _edit((s) => s.copyWith(name: name));

  void setColor(int color) => _edit((s) => s.copyWith(color: color));

  void setCountsTowardDailyGoal(bool value) =>
      _edit((s) => s.copyWith(countsTowardDailyGoal: value));

  /// Steps snap to whole hours.
  void increaseGoal() => _edit(
    (s) => s.copyWith(
      weeklyGoalMinutes:
          ((s.weeklyGoalMinutes ~/ _goalStepMinutes) + 1) * _goalStepMinutes,
    ),
  );

  void decreaseGoal() => _edit((s) {
    final minutes = s.weeklyGoalMinutes;
    final snapped = minutes % _goalStepMinutes == 0
        ? minutes - _goalStepMinutes
        : minutes - minutes % _goalStepMinutes;
    return s.copyWith(weeklyGoalMinutes: snapped);
  });

  /// Returns false without saving when the name is empty.
  Future<bool> save() async {
    final form = state.value;
    if (form == null || !form.canSave) return false;
    final repository = ref.read(projectRepositoryProvider);
    if (form.projectId case final id?) {
      await repository.updateProject(
        Project(
          id: id,
          name: form.name,
          color: form.color,
          weeklyGoalMinutes: form.weeklyGoalMinutes,
          countsTowardDailyGoal: form.countsTowardDailyGoal,
          archived: form.archived,
        ),
      );
    } else {
      await repository.createProject(
        name: form.name,
        color: form.color,
        weeklyGoalMinutes: form.weeklyGoalMinutes,
        countsTowardDailyGoal: form.countsTowardDailyGoal,
      );
    }
    return true;
  }

  /// Archives an active project or restores an archived one.
  Future<void> toggleArchived() async {
    final form = state.value;
    if (form?.projectId case final id?) {
      await ref
          .read(projectRepositoryProvider)
          .setArchived(id, archived: !form!.archived);
    }
  }

  void _edit(ProjectEditorUiState Function(ProjectEditorUiState) change) {
    final form = state.value;
    if (form == null) return;
    final next = change(form);
    _form = next.copyWith(
      weeklyGoalMinutes: next.weeklyGoalMinutes.clamp(0, maxWeeklyGoalMinutes),
    );
    state = AsyncData(_form);
  }

  /// First palette colour no active project uses yet.
  static int _unusedColor(List<Project> projects) {
    final used = {
      for (final p in projects)
        if (!p.archived) p.color,
    };
    final palette = [for (final c in AppColors.projectPalette) c.toARGB32()];
    return palette.firstWhere(
      (c) => !used.contains(c),
      orElse: () => palette.first,
    );
  }
}
