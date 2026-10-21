import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/dependencies.dart';
import '../../../../domain/models/app_settings.dart';
import '../../../../domain/use_cases/backup_format.dart';

final settingsViewModelProvider =
    AsyncNotifierProvider.autoDispose<SettingsViewModel, AppSettings>(
      SettingsViewModel.new,
    );

class SettingsViewModel extends AsyncNotifier<AppSettings> {
  static const minDailyGoalMinutes = 60;
  static const maxDailyGoalMinutes = 16 * 60;

  @override
  Future<AppSettings> build() => ref.watch(appSettingsProvider.future);

  /// Reminders and the running-timer notification are hidden where the
  /// platform can't schedule notifications (web, Linux, Windows).
  bool get notificationsSupported =>
      ref.read(notificationRepositoryProvider).isSupported;

  Future<void> setDailyGoalMinutes(int minutes) => _update(
    (s) => s.copyWith(
      dailyGoalMinutes: minutes.clamp(minDailyGoalMinutes, maxDailyGoalMinutes),
    ),
  );

  Future<void> setWeekStartsOn(int weekday) =>
      _update((s) => s.copyWith(weekStartsOn: weekday));

  Future<void> setIdleDetection(bool enabled) =>
      _update((s) => s.copyWith(idleDetection: enabled));

  /// Returns false when notification permission was refused; the setting
  /// then stays off.
  Future<bool> setRemindToStart(bool enabled) async {
    if (enabled && !await _requestPermission()) return false;
    await _update((s) => s.copyWith(remindToStart: enabled));
    return true;
  }

  Future<void> setReminderTime(int hour, int minute) =>
      _update((s) => s.copyWith(reminderMinuteOfDay: hour * 60 + minute));

  /// Returns false when notification permission was refused.
  Future<bool> setRunningTimerNotification(bool enabled) async {
    if (enabled && !await _requestPermission()) return false;
    await _update((s) => s.copyWith(runningTimerNotification: enabled));
    return true;
  }

  Future<void> setTheme(ThemePreference theme) =>
      _update((s) => s.copyWith(theme: theme));

  Future<void> setLanguage(AppLanguage language) =>
      _update((s) => s.copyWith(language: language));

  Future<void> exportCsv() => ref.read(backupRepositoryProvider).exportCsv();

  Future<void> createBackup() =>
      ref.read(backupRepositoryProvider).createBackup();

  /// Null when the user cancels; throws [FormatException] for a file that
  /// isn't a Tempo backup.
  Future<BackupData?> pickBackup({required String fileTypeLabel}) => ref
      .read(backupRepositoryProvider)
      .pickBackup(fileTypeLabel: fileTypeLabel);

  Future<void> restore(BackupData backup) =>
      ref.read(backupRepositoryProvider).restore(backup);

  Future<bool> _requestPermission() =>
      ref.read(notificationRepositoryProvider).requestPermission();

  Future<void> _update(AppSettings Function(AppSettings) change) =>
      ref.read(settingsRepositoryProvider).update(change);
}
