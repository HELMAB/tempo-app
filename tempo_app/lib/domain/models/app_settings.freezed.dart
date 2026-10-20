// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppSettings {

 bool get onboardingComplete; int get dailyGoalMinutes;/// [DateTime.monday] .. [DateTime.sunday].
 int get weekStartsOn; bool get idleDetection; bool get remindToStart;/// Minutes after midnight, 540 = 09:00.
 int get reminderMinuteOfDay; bool get runningTimerNotification; ThemePreference get theme;
/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<AppSettings> get copyWith => _$AppSettingsCopyWithImpl<AppSettings>(this as AppSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSettings&&(identical(other.onboardingComplete, onboardingComplete) || other.onboardingComplete == onboardingComplete)&&(identical(other.dailyGoalMinutes, dailyGoalMinutes) || other.dailyGoalMinutes == dailyGoalMinutes)&&(identical(other.weekStartsOn, weekStartsOn) || other.weekStartsOn == weekStartsOn)&&(identical(other.idleDetection, idleDetection) || other.idleDetection == idleDetection)&&(identical(other.remindToStart, remindToStart) || other.remindToStart == remindToStart)&&(identical(other.reminderMinuteOfDay, reminderMinuteOfDay) || other.reminderMinuteOfDay == reminderMinuteOfDay)&&(identical(other.runningTimerNotification, runningTimerNotification) || other.runningTimerNotification == runningTimerNotification)&&(identical(other.theme, theme) || other.theme == theme));
}


@override
int get hashCode => Object.hash(runtimeType,onboardingComplete,dailyGoalMinutes,weekStartsOn,idleDetection,remindToStart,reminderMinuteOfDay,runningTimerNotification,theme);

@override
String toString() {
  return 'AppSettings(onboardingComplete: $onboardingComplete, dailyGoalMinutes: $dailyGoalMinutes, weekStartsOn: $weekStartsOn, idleDetection: $idleDetection, remindToStart: $remindToStart, reminderMinuteOfDay: $reminderMinuteOfDay, runningTimerNotification: $runningTimerNotification, theme: $theme)';
}


}

/// @nodoc
abstract mixin class $AppSettingsCopyWith<$Res>  {
  factory $AppSettingsCopyWith(AppSettings value, $Res Function(AppSettings) _then) = _$AppSettingsCopyWithImpl;
@useResult
$Res call({
 bool onboardingComplete, int dailyGoalMinutes, int weekStartsOn, bool idleDetection, bool remindToStart, int reminderMinuteOfDay, bool runningTimerNotification, ThemePreference theme
});




}
/// @nodoc
class _$AppSettingsCopyWithImpl<$Res>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._self, this._then);

  final AppSettings _self;
  final $Res Function(AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? onboardingComplete = null,Object? dailyGoalMinutes = null,Object? weekStartsOn = null,Object? idleDetection = null,Object? remindToStart = null,Object? reminderMinuteOfDay = null,Object? runningTimerNotification = null,Object? theme = null,}) {
  return _then(AppSettings(
onboardingComplete: null == onboardingComplete ? _self.onboardingComplete : onboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,dailyGoalMinutes: null == dailyGoalMinutes ? _self.dailyGoalMinutes : dailyGoalMinutes // ignore: cast_nullable_to_non_nullable
as int,weekStartsOn: null == weekStartsOn ? _self.weekStartsOn : weekStartsOn // ignore: cast_nullable_to_non_nullable
as int,idleDetection: null == idleDetection ? _self.idleDetection : idleDetection // ignore: cast_nullable_to_non_nullable
as bool,remindToStart: null == remindToStart ? _self.remindToStart : remindToStart // ignore: cast_nullable_to_non_nullable
as bool,reminderMinuteOfDay: null == reminderMinuteOfDay ? _self.reminderMinuteOfDay : reminderMinuteOfDay // ignore: cast_nullable_to_non_nullable
as int,runningTimerNotification: null == runningTimerNotification ? _self.runningTimerNotification : runningTimerNotification // ignore: cast_nullable_to_non_nullable
as bool,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ThemePreference,
  ));
}

}


/// Adds pattern-matching-related methods to [AppSettings].
extension AppSettingsPatterns on AppSettings {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppSettings value)  $default,){
final _that = this;
switch (_that) {
case _AppSettings():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool onboardingComplete,  int dailyGoalMinutes,  int weekStartsOn,  bool idleDetection,  bool remindToStart,  int reminderMinuteOfDay,  bool runningTimerNotification,  ThemePreference theme)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.onboardingComplete,_that.dailyGoalMinutes,_that.weekStartsOn,_that.idleDetection,_that.remindToStart,_that.reminderMinuteOfDay,_that.runningTimerNotification,_that.theme);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool onboardingComplete,  int dailyGoalMinutes,  int weekStartsOn,  bool idleDetection,  bool remindToStart,  int reminderMinuteOfDay,  bool runningTimerNotification,  ThemePreference theme)  $default,) {final _that = this;
switch (_that) {
case _AppSettings():
return $default(_that.onboardingComplete,_that.dailyGoalMinutes,_that.weekStartsOn,_that.idleDetection,_that.remindToStart,_that.reminderMinuteOfDay,_that.runningTimerNotification,_that.theme);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool onboardingComplete,  int dailyGoalMinutes,  int weekStartsOn,  bool idleDetection,  bool remindToStart,  int reminderMinuteOfDay,  bool runningTimerNotification,  ThemePreference theme)?  $default,) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.onboardingComplete,_that.dailyGoalMinutes,_that.weekStartsOn,_that.idleDetection,_that.remindToStart,_that.reminderMinuteOfDay,_that.runningTimerNotification,_that.theme);case _:
  return null;

}
}

}

/// @nodoc


class _AppSettings implements AppSettings {
  const _AppSettings({this.onboardingComplete = false, this.dailyGoalMinutes = 480, this.weekStartsOn = DateTime.monday, this.idleDetection = true, this.remindToStart = true, this.reminderMinuteOfDay = 540, this.runningTimerNotification = false, this.theme = ThemePreference.system});
  

@override@JsonKey() final  bool onboardingComplete;
@override@JsonKey() final  int dailyGoalMinutes;
/// [DateTime.monday] .. [DateTime.sunday].
@override@JsonKey() final  int weekStartsOn;
@override@JsonKey() final  bool idleDetection;
@override@JsonKey() final  bool remindToStart;
/// Minutes after midnight, 540 = 09:00.
@override@JsonKey() final  int reminderMinuteOfDay;
@override@JsonKey() final  bool runningTimerNotification;
@override@JsonKey() final  ThemePreference theme;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSettingsCopyWith<_AppSettings> get copyWith => __$AppSettingsCopyWithImpl<_AppSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSettings&&(identical(other.onboardingComplete, onboardingComplete) || other.onboardingComplete == onboardingComplete)&&(identical(other.dailyGoalMinutes, dailyGoalMinutes) || other.dailyGoalMinutes == dailyGoalMinutes)&&(identical(other.weekStartsOn, weekStartsOn) || other.weekStartsOn == weekStartsOn)&&(identical(other.idleDetection, idleDetection) || other.idleDetection == idleDetection)&&(identical(other.remindToStart, remindToStart) || other.remindToStart == remindToStart)&&(identical(other.reminderMinuteOfDay, reminderMinuteOfDay) || other.reminderMinuteOfDay == reminderMinuteOfDay)&&(identical(other.runningTimerNotification, runningTimerNotification) || other.runningTimerNotification == runningTimerNotification)&&(identical(other.theme, theme) || other.theme == theme));
}


@override
int get hashCode => Object.hash(runtimeType,onboardingComplete,dailyGoalMinutes,weekStartsOn,idleDetection,remindToStart,reminderMinuteOfDay,runningTimerNotification,theme);

@override
String toString() {
  return 'AppSettings(onboardingComplete: $onboardingComplete, dailyGoalMinutes: $dailyGoalMinutes, weekStartsOn: $weekStartsOn, idleDetection: $idleDetection, remindToStart: $remindToStart, reminderMinuteOfDay: $reminderMinuteOfDay, runningTimerNotification: $runningTimerNotification, theme: $theme)';
}


}

/// @nodoc
abstract mixin class _$AppSettingsCopyWith<$Res> implements $AppSettingsCopyWith<$Res> {
  factory _$AppSettingsCopyWith(_AppSettings value, $Res Function(_AppSettings) _then) = __$AppSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool onboardingComplete, int dailyGoalMinutes, int weekStartsOn, bool idleDetection, bool remindToStart, int reminderMinuteOfDay, bool runningTimerNotification, ThemePreference theme
});




}
/// @nodoc
class __$AppSettingsCopyWithImpl<$Res>
    implements _$AppSettingsCopyWith<$Res> {
  __$AppSettingsCopyWithImpl(this._self, this._then);

  final _AppSettings _self;
  final $Res Function(_AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? onboardingComplete = null,Object? dailyGoalMinutes = null,Object? weekStartsOn = null,Object? idleDetection = null,Object? remindToStart = null,Object? reminderMinuteOfDay = null,Object? runningTimerNotification = null,Object? theme = null,}) {
  return _then(_AppSettings(
onboardingComplete: null == onboardingComplete ? _self.onboardingComplete : onboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,dailyGoalMinutes: null == dailyGoalMinutes ? _self.dailyGoalMinutes : dailyGoalMinutes // ignore: cast_nullable_to_non_nullable
as int,weekStartsOn: null == weekStartsOn ? _self.weekStartsOn : weekStartsOn // ignore: cast_nullable_to_non_nullable
as int,idleDetection: null == idleDetection ? _self.idleDetection : idleDetection // ignore: cast_nullable_to_non_nullable
as bool,remindToStart: null == remindToStart ? _self.remindToStart : remindToStart // ignore: cast_nullable_to_non_nullable
as bool,reminderMinuteOfDay: null == reminderMinuteOfDay ? _self.reminderMinuteOfDay : reminderMinuteOfDay // ignore: cast_nullable_to_non_nullable
as int,runningTimerNotification: null == runningTimerNotification ? _self.runningTimerNotification : runningTimerNotification // ignore: cast_nullable_to_non_nullable
as bool,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ThemePreference,
  ));
}


}

// dart format on
