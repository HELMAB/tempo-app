import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/data/repositories/notification_repository.dart';
import 'package:tempo_app/domain/models/app_settings.dart';
import 'package:tempo_app/domain/models/time_entry.dart';

import '../../testing/fakes.dart';

void main() {
  late FakeNotificationService service;
  late NotificationRepository repository;

  setUp(() {
    service = FakeNotificationService();
    repository = NotificationRepository(service: service);
  });

  test(
    'schedules the reminder at the chosen time, in the app language',
    () async {
      await repository.syncReminder(
        const AppSettings(
          remindToStart: true,
          reminderMinuteOfDay: 8 * 60 + 30,
        ),
      );
      expect(service.reminder?.hour, 8);
      expect(service.reminder?.minute, 30);
      expect(service.reminder?.title, 'ដល់ពេលចាប់ផ្ដើមតាមដានហើយ');

      await repository.syncReminder(const AppSettings(remindToStart: false));
      expect(service.reminder, isNull);
    },
  );

  test('shows the running timer only when enabled', () async {
    final running = TimeEntry(
      id: 1,
      description: 'Build timer screen',
      startAt: DateTime(2026, 10, 20, 17, 2),
    );
    const enabled = AppSettings(
      runningTimerNotification: true,
      language: AppLanguage.english,
    );

    await repository.syncRunningTimer(enabled, running);
    expect(service.runningTimer?.title, 'Build timer screen');
    expect(service.runningTimer?.body, 'Started at 17:02');

    await repository.syncRunningTimer(enabled, null);
    expect(service.runningTimer, isNull);

    await repository.syncRunningTimer(const AppSettings(), running);
    expect(service.runningTimer, isNull, reason: 'setting is off');
  });
}
