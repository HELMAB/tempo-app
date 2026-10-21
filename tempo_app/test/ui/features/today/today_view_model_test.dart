import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/config/dependencies.dart';
import 'package:tempo_app/ui/features/today/view_models/today_ui_state.dart';
import 'package:tempo_app/ui/features/today/view_models/today_view_model.dart';

import '../../../testing/test_dependencies.dart';

void main() {
  late DateTime now;
  late ProviderContainer container;

  setUp(() async {
    now = DateTime(2026, 10, 20, 12);
    container = await createTestContainer(clock: () => now);
    container.listen(todayViewModelProvider, (_, _) {});
  });

  Future<TodayUiState> state() async {
    await settle();
    return container.read(todayViewModelProvider.future);
  }

  TodayViewModel viewModel() => container.read(todayViewModelProvider.notifier);

  test('lists today\'s entries with their projects, oldest first', () async {
    final projects = container.read(projectRepositoryProvider);
    final entries = container.read(timeEntryRepositoryProvider);
    final flutter = await projects.createProject(
      name: 'Flutter course',
      color: 0xFF2B50E6,
    );
    await entries.addEntry(
      projectId: flutter.id,
      description: 'Code review',
      startAt: DateTime(2026, 10, 20, 10),
      endAt: DateTime(2026, 10, 20, 11),
    );
    await entries.addEntry(
      description: 'Build timer screen',
      startAt: DateTime(2026, 10, 20, 9),
      endAt: DateTime(2026, 10, 20, 9, 30),
    );
    await entries.addEntry(
      description: 'Yesterday',
      startAt: DateTime(2026, 10, 19, 9),
      endAt: DateTime(2026, 10, 19, 10),
    );

    final today = await state();

    expect(today.entries.map((e) => e.entry.description), [
      'Build timer screen',
      'Code review',
    ]);
    expect(today.entries.last.project, flutter);
    expect(today.progressAt(now).tracked, const Duration(minutes: 90));
    expect(today.dailyGoal, const Duration(hours: 8));
  });

  test('suggests the latest entry\'s project until the user picks', () async {
    final projects = container.read(projectRepositoryProvider);
    final flutter = await projects.createProject(name: 'Flutter', color: 0);
    final admin = await projects.createProject(name: 'Admin', color: 0);
    await container
        .read(timeEntryRepositoryProvider)
        .addEntry(
          projectId: admin.id,
          startAt: DateTime(2026, 10, 20, 9),
          endAt: DateTime(2026, 10, 20, 10),
        );

    expect((await state()).quickStartProject, admin);

    viewModel().selectQuickStartProject(flutter.id);
    expect((await state()).quickStartProject, flutter);

    viewModel().selectQuickStartProject(null);
    expect((await state()).quickStartProject, isNull);
  });

  test('startTimer uses the quick-start project and description', () async {
    final flutter = await container
        .read(projectRepositoryProvider)
        .createProject(name: 'Flutter', color: 0);
    viewModel().selectQuickStartProject(flutter.id);
    await state();

    await viewModel().startTimer(description: 'Build timer screen');

    final running = (await state()).running;
    expect(running?.entry.description, 'Build timer screen');
    expect(running?.project, flutter);
  });

  test('continueEntry starts a timer with the same details', () async {
    final entries = container.read(timeEntryRepositoryProvider);
    final id = await entries.addEntry(
      description: 'Inbox & planning',
      startAt: DateTime(2026, 10, 20, 9),
      endAt: DateTime(2026, 10, 20, 10),
      tags: ['Admin'],
    );

    await viewModel().continueEntry((await entries.getEntry(id))!);

    final running = (await state()).running!.entry;
    expect(running.id, isNot(id));
    expect(running.description, 'Inbox & planning');
    expect(running.tags, ['Admin']);
    expect(running.startAt, now);
  });

  test('the running entry counts toward today until now', () async {
    await viewModel().startTimer(description: 'Deep work');
    final today = await state();

    now = now.add(const Duration(minutes: 25));

    expect(today.progressAt(now).tracked, const Duration(minutes: 25));
  });
}
