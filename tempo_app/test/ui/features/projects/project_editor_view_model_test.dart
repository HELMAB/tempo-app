import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/config/dependencies.dart';
import 'package:tempo_app/ui/core/themes/app_colors.dart';
import 'package:tempo_app/ui/features/projects/view_models/project_editor_view_model.dart';

import '../../../testing/test_dependencies.dart';

void main() {
  late ProviderContainer container;

  setUp(() async {
    container = await createTestContainer(clock: () => DateTime(2026, 10, 20));
  });

  Future<ProjectEditorUiState?> open(int? projectId) async {
    container.listen(projectEditorViewModelProvider(projectId), (_, _) {});
    await settle();
    return container.read(projectEditorViewModelProvider(projectId).future);
  }

  ProjectEditorViewModel viewModel(int? projectId) =>
      container.read(projectEditorViewModelProvider(projectId).notifier);

  ProjectEditorUiState current(int? projectId) =>
      container.read(projectEditorViewModelProvider(projectId)).value!;

  test('a new project defaults to an unused colour and 5h a week', () async {
    await container
        .read(projectRepositoryProvider)
        .createProject(
          name: 'Flutter course',
          color: AppColors.projectPalette.first.toARGB32(),
        );

    final form = (await open(null))!;

    expect(form.isNew, isTrue);
    expect(form.color, AppColors.projectPalette[1].toARGB32());
    expect(form.weeklyGoal, const Duration(hours: 5));
    expect(form.dailyGoal, const Duration(hours: 8));
    expect(form.canSave, isFalse, reason: 'the name is empty');
  });

  test('the goal steps by whole hours within bounds', () async {
    await open(null);
    viewModel(null).increaseGoal();
    expect(current(null).weeklyGoal, const Duration(hours: 6));

    for (var i = 0; i < 10; i++) {
      viewModel(null).decreaseGoal();
    }
    expect(current(null).weeklyGoalMinutes, 0);
    expect(current(null).canDecreaseGoal, isFalse);
  });

  test('a goal between hours snaps to the hour', () async {
    final project = await container
        .read(projectRepositoryProvider)
        .createProject(name: 'Reading', color: 0, weeklyGoalMinutes: 150);
    await open(project.id);

    viewModel(project.id).increaseGoal();
    expect(current(project.id).weeklyGoalMinutes, 180);
    viewModel(project.id).decreaseGoal();
    viewModel(project.id).decreaseGoal();
    expect(current(project.id).weeklyGoalMinutes, 60);
  });

  test('save creates the project', () async {
    await open(null);
    viewModel(null)
      ..setName('Side project')
      ..setCountsTowardDailyGoal(false);

    expect(await viewModel(null).save(), isTrue);

    final projects = await container
        .read(projectRepositoryProvider)
        .watchProjects()
        .first;
    expect(projects.single.name, 'Side project');
    expect(projects.single.weeklyGoalMinutes, 300);
    expect(projects.single.countsTowardDailyGoal, isFalse);
  });

  test('editing updates and archiving toggles', () async {
    final repository = container.read(projectRepositoryProvider);
    final project = await repository.createProject(name: 'Admin', color: 0);
    await open(project.id);

    viewModel(project.id).setName('Admin & email');
    expect(await viewModel(project.id).save(), isTrue);
    await viewModel(project.id).toggleArchived();

    final saved = await repository.getProject(project.id);
    expect(saved?.name, 'Admin & email');
    expect(saved?.archived, isTrue);
  });
}
