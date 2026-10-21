import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../domain/models/app_settings.dart';
import '../../domain/models/time_entry.dart';
import '../../l10n/app_localizations.dart';
import '../services/notification_service.dart';

/// Turns settings and the running timer into scheduled / ongoing
/// notifications, with text in the app's language.
class NotificationRepository {
  NotificationRepository({required this._service});

  final NotificationService _service;

  bool get isSupported => _service.isSupported;

  Future<bool> requestPermission() =>
      isSupported ? _service.requestPermission() : Future.value(false);

  Future<void> syncReminder(AppSettings settings) async {
    if (!isSupported) return;
    if (!settings.remindToStart) {
      await _service.cancelWeekdayReminder();
      return;
    }
    final l10n = _l10n(settings);
    await _service.scheduleWeekdayReminder(
      hour: settings.reminderMinuteOfDay ~/ 60,
      minute: settings.reminderMinuteOfDay % 60,
      title: l10n.reminderTitle,
      body: l10n.reminderBody,
      channelName: l10n.reminderChannel,
    );
  }

  Future<void> syncRunningTimer(
    AppSettings settings,
    TimeEntry? running,
  ) async {
    if (!isSupported) return;
    if (running == null || !settings.runningTimerNotification) {
      await _service.cancelRunningTimer();
      return;
    }
    final l10n = _l10n(settings);
    await _service.showRunningTimer(
      title: running.description.isEmpty
          ? l10n.runningTimerFallbackTitle
          : running.description,
      // No locale: this can run before Flutter has loaded locale date data,
      // and HH:mm reads the same in every language.
      body: l10n.runningTimerBody(DateFormat('HH:mm').format(running.startAt)),
      startedAt: running.startAt,
      channelName: l10n.runningTimerChannel,
    );
  }

  static AppLocalizations _l10n(AppSettings settings) =>
      lookupAppLocalizations(Locale(settings.language.code));
}
