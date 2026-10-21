import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';

enum ThemePreference { system, light, dark }

/// Languages the UI is translated into. Khmer is the primary language.
enum AppLanguage {
  khmer('km', 'ខ្មែរ'),
  english('en', 'English');

  const AppLanguage(this.code, this.nativeName);

  /// BCP 47 language code, matching the `lib/l10n/app_<code>.arb` files.
  final String code;

  /// The language's own name, shown untranslated in the picker.
  final String nativeName;
}

@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(false) bool onboardingComplete,
    @Default(480) int dailyGoalMinutes,

    /// Target length of one timer session ("of 2h focus goal").
    @Default(120) int focusGoalMinutes,

    /// [DateTime.monday] .. [DateTime.sunday].
    @Default(DateTime.monday) int weekStartsOn,
    @Default(true) bool idleDetection,
    @Default(true) bool remindToStart,

    /// Minutes after midnight, 540 = 09:00.
    @Default(540) int reminderMinuteOfDay,
    @Default(false) bool runningTimerNotification,
    @Default(ThemePreference.system) ThemePreference theme,
    @Default(AppLanguage.khmer) AppLanguage language,
  }) = _AppSettings;
}
