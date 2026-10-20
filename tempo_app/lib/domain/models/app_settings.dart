import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';

enum ThemePreference { system, light, dark }

@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(false) bool onboardingComplete,
    @Default(480) int dailyGoalMinutes,

    /// [DateTime.monday] .. [DateTime.sunday].
    @Default(DateTime.monday) int weekStartsOn,
    @Default(true) bool idleDetection,
    @Default(true) bool remindToStart,

    /// Minutes after midnight, 540 = 09:00.
    @Default(540) int reminderMinuteOfDay,
    @Default(false) bool runningTimerNotification,
    @Default(ThemePreference.system) ThemePreference theme,
  }) = _AppSettings;
}
