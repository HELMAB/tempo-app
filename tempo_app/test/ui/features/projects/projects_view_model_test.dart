import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/config/dependencies.dart';
import 'package:tempo_app/ui/features/projects/view_models/projects_ui_state.dart';
import 'package:tempo_app/ui/features/projects/view_models/projects_view_model.dart';

import '../../../testing/test_dependencies.dart';

void main() {
  late DateTime now;
  late ProviderContainer container;

  setUp(() async {
    // Tuesday; with Monday weeks the week starts on 19 October.
    now = DateTime(2026, 10, 20, 12);
    container = await createTestContainer(clock: () => now);
    container.listen(projectsViewModelProvider, (_, _) {});
  });

  Future<ProjectsUiState> state() async {
    await settle();
    return container.read(projectsViewModelProvider.future);
  }

  test('totals this week, all time, and the running entry', () async {
    final projects = container.read(projectRepositoryProvider);
    final entries = container.read(timeEntryRepositoryProvider);
    final flutter = await projects.createProject(
      name: 'Flutter course',
      color: 0,
      weeklyGoalMinutes: 600,
    );
    await entries.addEntry(
      projectId: flutter.id,
      startAt: DateTime(2026, 10, 19, 9),
      endAt: DateTime(2026, 10, 19, 13),
    );
    await entries.addEntry(
      projectId: flutter.id,
      startAt: DateTime(2026, 10, 12, 9),
      endAt: DateTime(2026, 10, 12, 11),
    );
    await entries.startTimer(projectId: flutter.id);

    final week = await state();
    expect(week.range, ProjectsRange.thisWeek);
    expect(week.showsGoals, isTrue);
    final later = now.add(const Duration(hours: 1));
    expect(week.totals.trackedAt(flutter.id, later), const Duration(hours: 5));
    expect(
      week.totals.goalFractionAt(flutter.id, flutter.weeklyGoal, later),
      0.5,
    );

    container
        .read(projectsViewModelProvider.notifier)
        .selectRange(ProjectsRange.allTime);
    final allTime = await state();
    expect(allTime.showsGoals, isFalse);
    expect(
      allTime.totals.trackedAt(flutter.id, later),
      const Duration(hours: 7),
    );
  });

  test('separates active and archived projects', () async {
    final projects = container.read(projectRepositoryProvider);
    final active = await projects.createProject(name: 'Client work', color: 0);
    final old = await projects.createProject(name: 'Old site', color: 0);
    await projects.setArchived(old.id, archived: true);

    final result = await state();
    expect(result.active, [active]);
    expect(result.archived.single.id, old.id);
  });
}
