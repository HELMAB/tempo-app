import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/app_settings.dart';

class SettingsRepository {
  SettingsRepository({required this._preferences});

  final SharedPreferencesWithCache _preferences;
  final _changes = StreamController<AppSettings>.broadcast();

  static const _defaults = AppSettings();

  /// Synchronous read from the preferences cache, used by the router's
  /// onboarding redirect.
  AppSettings get current => AppSettings(
    onboardingComplete:
        _preferences.getBool(_Keys.onboardingComplete) ??
        _defaults.onboardingComplete,
    dailyGoalMinutes:
        _preferences.getInt(_Keys.dailyGoalMinutes) ??
        _defaults.dailyGoalMinutes,
    weekStartsOn:
        _preferences.getInt(_Keys.weekStartsOn) ?? _defaults.weekStartsOn,
    idleDetection:
        _preferences.getBool(_Keys.idleDetection) ?? _defaults.idleDetection,
    remindToStart:
        _preferences.getBool(_Keys.remindToStart) ?? _defaults.remindToStart,
    reminderMinuteOfDay:
        _preferences.getInt(_Keys.reminderMinuteOfDay) ??
        _defaults.reminderMinuteOfDay,
    runningTimerNotification:
        _preferences.getBool(_Keys.runningTimerNotification) ??
        _defaults.runningTimerNotification,
    theme:
        ThemePreference.values.asNameMap()[_preferences.getString(
          _Keys.theme,
        )] ??
        _defaults.theme,
  );

  /// Emits the current settings, then every change.
  Stream<AppSettings> watch() => Stream.multi((listener) {
    // Subscribe before anything else runs so no change is missed.
    final subscription = _changes.stream.listen(
      listener.add,
      onError: listener.addError,
      onDone: listener.close,
    );
    listener
      ..add(current)
      ..onCancel = subscription.cancel;
  });

  Future<void> update(AppSettings Function(AppSettings) change) async {
    final next = change(current);
    await Future.wait([
      _preferences.setBool(_Keys.onboardingComplete, next.onboardingComplete),
      _preferences.setInt(_Keys.dailyGoalMinutes, next.dailyGoalMinutes),
      _preferences.setInt(_Keys.weekStartsOn, next.weekStartsOn),
      _preferences.setBool(_Keys.idleDetection, next.idleDetection),
      _preferences.setBool(_Keys.remindToStart, next.remindToStart),
      _preferences.setInt(_Keys.reminderMinuteOfDay, next.reminderMinuteOfDay),
      _preferences.setBool(
        _Keys.runningTimerNotification,
        next.runningTimerNotification,
      ),
      _preferences.setString(_Keys.theme, next.theme.name),
    ]);
    _changes.add(next);
  }

  Future<void> dispose() => _changes.close();
}

abstract final class _Keys {
  static const onboardingComplete = 'onboarding_complete';
  static const dailyGoalMinutes = 'daily_goal_minutes';
  static const weekStartsOn = 'week_starts_on';
  static const idleDetection = 'idle_detection';
  static const remindToStart = 'remind_to_start';
  static const reminderMinuteOfDay = 'reminder_minute_of_day';
  static const runningTimerNotification = 'running_timer_notification';
  static const theme = 'theme';
}
