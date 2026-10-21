import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/config/dependencies.dart';
import 'package:tempo_app/ui/features/idle/view_models/idle_view_model.dart';

import '../../../testing/test_dependencies.dart';

void main() {
  late DateTime now;
  late ProviderContainer container;

  setUp(() async {
    now = DateTime(2026, 10, 20, 17);
    container = await createTestContainer(clock: () => now);
    container.listen(runningEntryProvider, (_, _) {});
  });

  IdleViewModel viewModel() => container.read(idleViewModelProvider.notifier);

  Future<void> startTimer() async {
    await container.read(timeEntryRepositoryProvider).startTimer();
    await settle();
  }

  test('asks after 10 minutes away with a timer running', () async {
    await startTimer();
    now = now.add(const Duration(minutes: 5));
    viewModel().appHidden();
    now = now.add(const Duration(minutes: 25));

    final review = viewModel().appResumed();

    expect(review?.away, const Duration(minutes: 25));
    expect(review?.leftAt, DateTime(2026, 10, 20, 17, 5));
  });

  test('does not ask for short absences or without a timer', () async {
    viewModel().appHidden();
    now = now.add(const Duration(hours: 1));
    expect(viewModel().appResumed(), isNull, reason: 'no timer running');

    await startTimer();
    viewModel().appHidden();
    now = now.add(const Duration(minutes: 9));
    expect(viewModel().appResumed(), isNull, reason: 'under 10 minutes');
  });

  test('does not ask when idle detection is off', () async {
    await container
        .read(settingsRepositoryProvider)
        .update((s) => s.copyWith(idleDetection: false));
    await startTimer();
    viewModel().appHidden();
    now = now.add(const Duration(hours: 1));

    expect(viewModel().appResumed(), isNull);
  });

  test('discarding stops the timer when the user left', () async {
    await startTimer();
    now = now.add(const Duration(minutes: 5));
    viewModel().appHidden();
    now = now.add(const Duration(minutes: 30));
    final review = viewModel().appResumed()!;

    await viewModel().discardAwayTime(review);

    final entries = await container
        .read(timeEntryRepositoryProvider)
        .getEntries();
    expect(entries.single.endAt, DateTime(2026, 10, 20, 17, 5));
  });
}
