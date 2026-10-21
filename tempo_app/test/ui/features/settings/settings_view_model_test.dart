import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/config/dependencies.dart';
import 'package:tempo_app/ui/features/settings/view_models/settings_view_model.dart';

import '../../../testing/fakes.dart';
import '../../../testing/test_dependencies.dart';

void main() {
  late FakeNotificationService notifications;
  late ProviderContainer container;

  setUp(() async {
    notifications = FakeNotificationService();
    container = await createTestContainer(
      clock: () => DateTime(2026, 10, 20, 12),
      overrides: [notificationServiceProvider.overrideWithValue(notifications)],
    );
    container.listen(settingsViewModelProvider, (_, _) {});
    await settle();
  });

  SettingsViewModel viewModel() =>
      container.read(settingsViewModelProvider.notifier);

  bool remindToStart() =>
      container.read(settingsRepositoryProvider).current.remindToStart;

  test('turning a reminder on asks for permission first', () async {
    await viewModel().setRemindToStart(false);
    notifications.grantPermission = false;

    expect(await viewModel().setRemindToStart(true), isFalse);
    expect(remindToStart(), isFalse);

    notifications.grantPermission = true;
    expect(await viewModel().setRemindToStart(true), isTrue);
    expect(remindToStart(), isTrue);
  });

  test('the reminder is rescheduled when its time changes', () async {
    container.listen(reminderSyncProvider, (_, _) {});
    await viewModel().setRemindToStart(true);
    await viewModel().setReminderTime(7, 45);
    await settle();

    expect(notifications.reminder?.hour, 7);
    expect(notifications.reminder?.minute, 45);
  });

  test('the daily goal stays within 1h and 16h', () async {
    await viewModel().setDailyGoalMinutes(10);
    expect(
      container.read(settingsRepositoryProvider).current.dailyGoalMinutes,
      60,
    );
    await viewModel().setDailyGoalMinutes(24 * 60);
    expect(
      container.read(settingsRepositoryProvider).current.dailyGoalMinutes,
      16 * 60,
    );
  });
}
