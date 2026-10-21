import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/config/dependencies.dart';
import 'package:tempo_app/ui/features/timer/view_models/timer_ui_state.dart';
import 'package:tempo_app/ui/features/timer/view_models/timer_view_model.dart';

import '../../../testing/test_dependencies.dart';

void main() {
  late DateTime now;
  late ProviderContainer container;

  setUp(() async {
    now = DateTime(2026, 10, 20, 17, 2);
    container = await createTestContainer(clock: () => now);
    container.listen(timerViewModelProvider, (_, _) {});
  });

  Future<TimerUiState> state() async {
    await settle();
    return container.read(timerViewModelProvider.future);
  }

  TimerViewModel viewModel() => container.read(timerViewModelProvider.notifier);

  Future<int> startTimer() => container
      .read(timeEntryRepositoryProvider)
      .startTimer(description: 'Build timer screen', tags: ['Deep work']);

  test('shows nothing when no timer is running', () async {
    expect((await state()).entry, isNull);
  });

  test('shows the running entry against the focus goal', () async {
    final id = await startTimer();
    final timer = await state();

    expect(timer.entry?.id, id);
    expect(timer.isRunning, isTrue);
    expect(timer.focusGoal, const Duration(hours: 2));
    expect(timer.focusFractionAt(now.add(const Duration(hours: 1))), 0.5);
  });

  test('pause stops the entry, resume continues in a new one', () async {
    final id = await startTimer();
    await state();
    now = now.add(const Duration(minutes: 40));

    await viewModel().pause(note: 'Ring laid out');
    final paused = await state();
    expect(paused.isPaused, isTrue);
    expect(paused.entry?.id, id);
    expect(paused.entry?.endAt, now);
    expect(paused.entry?.note, 'Ring laid out');

    now = now.add(const Duration(minutes: 5));
    await viewModel().resume();
    final resumed = await state();
    expect(resumed.isRunning, isTrue);
    expect(resumed.entry?.id, isNot(id));
    expect(resumed.entry?.description, 'Build timer screen');
    expect(resumed.entry?.tags, ['Deep work']);
    expect(resumed.entry?.startAt, now);
  });

  test('stopAndSave ends the entry and keeps the note', () async {
    final id = await startTimer();
    await state();
    now = now.add(const Duration(hours: 1));

    await viewModel().stopAndSave(note: 'Done');

    final saved = await container
        .read(timeEntryRepositoryProvider)
        .getEntry(id);
    expect(saved?.endAt, now);
    expect(saved?.note, 'Done');
    expect((await state()).entry, isNull);
  });

  test('discard deletes the running entry', () async {
    final id = await startTimer();
    await state();

    await viewModel().discard();

    expect(
      await container.read(timeEntryRepositoryProvider).getEntry(id),
      isNull,
    );
    expect((await state()).entry, isNull);
  });

  test('tags and project can be changed while running', () async {
    final project = await container
        .read(projectRepositoryProvider)
        .createProject(name: 'Flutter course', color: 0);
    await startTimer();
    await state();

    await viewModel().toggleTag('Deep work');
    await state();
    await viewModel().addTag(' Learning ');
    await state();
    await viewModel().changeProject(project.id);

    final timer = await state();
    expect(timer.entry?.tags, ['Learning']);
    expect(timer.project, project);
    expect(timer.tagNames, containsAll(['Deep work', 'Learning']));
  });

  test('today total includes earlier entries and the running one', () async {
    await container
        .read(timeEntryRepositoryProvider)
        .addEntry(
          startAt: DateTime(2026, 10, 20, 9),
          endAt: DateTime(2026, 10, 20, 11),
        );
    await startTimer();
    final timer = await state();

    final later = now.add(const Duration(minutes: 30));
    expect(
      timer.todayProgressAt(later).tracked,
      const Duration(hours: 2, minutes: 30),
    );
  });
}
