// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_editor_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProjectEditorUiState {

/// Null when creating a project.
 int? get projectId; String get name; int get color; int get weeklyGoalMinutes; bool get countsTowardDailyGoal; bool get archived;/// From settings, for "Adds this project's time to your 8h target".
 Duration get dailyGoal;
/// Create a copy of ProjectEditorUiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectEditorUiStateCopyWith<ProjectEditorUiState> get copyWith => _$ProjectEditorUiStateCopyWithImpl<ProjectEditorUiState>(this as ProjectEditorUiState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectEditorUiState&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.weeklyGoalMinutes, weeklyGoalMinutes) || other.weeklyGoalMinutes == weeklyGoalMinutes)&&(identical(other.countsTowardDailyGoal, countsTowardDailyGoal) || other.countsTowardDailyGoal == countsTowardDailyGoal)&&(identical(other.archived, archived) || other.archived == archived)&&(identical(other.dailyGoal, dailyGoal) || other.dailyGoal == dailyGoal));
}


@override
int get hashCode => Object.hash(runtimeType,projectId,name,color,weeklyGoalMinutes,countsTowardDailyGoal,archived,dailyGoal);

@override
String toString() {
  return 'ProjectEditorUiState(projectId: $projectId, name: $name, color: $color, weeklyGoalMinutes: $weeklyGoalMinutes, countsTowardDailyGoal: $countsTowardDailyGoal, archived: $archived, dailyGoal: $dailyGoal)';
}


}

/// @nodoc
abstract mixin class $ProjectEditorUiStateCopyWith<$Res>  {
  factory $ProjectEditorUiStateCopyWith(ProjectEditorUiState value, $Res Function(ProjectEditorUiState) _then) = _$ProjectEditorUiStateCopyWithImpl;
@useResult
$Res call({
 int? projectId, String name, int color, int weeklyGoalMinutes, bool countsTowardDailyGoal, bool archived, Duration dailyGoal
});




}
/// @nodoc
class _$ProjectEditorUiStateCopyWithImpl<$Res>
    implements $ProjectEditorUiStateCopyWith<$Res> {
  _$ProjectEditorUiStateCopyWithImpl(this._self, this._then);

  final ProjectEditorUiState _self;
  final $Res Function(ProjectEditorUiState) _then;

/// Create a copy of ProjectEditorUiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = freezed,Object? name = null,Object? color = null,Object? weeklyGoalMinutes = null,Object? countsTowardDailyGoal = null,Object? archived = null,Object? dailyGoal = null,}) {
  return _then(ProjectEditorUiState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,weeklyGoalMinutes: null == weeklyGoalMinutes ? _self.weeklyGoalMinutes : weeklyGoalMinutes // ignore: cast_nullable_to_non_nullable
as int,countsTowardDailyGoal: null == countsTowardDailyGoal ? _self.countsTowardDailyGoal : countsTowardDailyGoal // ignore: cast_nullable_to_non_nullable
as bool,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,dailyGoal: null == dailyGoal ? _self.dailyGoal : dailyGoal // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectEditorUiState].
extension ProjectEditorUiStatePatterns on ProjectEditorUiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectEditorUiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectEditorUiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectEditorUiState value)  $default,){
final _that = this;
switch (_that) {
case _ProjectEditorUiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectEditorUiState value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectEditorUiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? projectId,  String name,  int color,  int weeklyGoalMinutes,  bool countsTowardDailyGoal,  bool archived,  Duration dailyGoal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectEditorUiState() when $default != null:
return $default(_that.projectId,_that.name,_that.color,_that.weeklyGoalMinutes,_that.countsTowardDailyGoal,_that.archived,_that.dailyGoal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? projectId,  String name,  int color,  int weeklyGoalMinutes,  bool countsTowardDailyGoal,  bool archived,  Duration dailyGoal)  $default,) {final _that = this;
switch (_that) {
case _ProjectEditorUiState():
return $default(_that.projectId,_that.name,_that.color,_that.weeklyGoalMinutes,_that.countsTowardDailyGoal,_that.archived,_that.dailyGoal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? projectId,  String name,  int color,  int weeklyGoalMinutes,  bool countsTowardDailyGoal,  bool archived,  Duration dailyGoal)?  $default,) {final _that = this;
switch (_that) {
case _ProjectEditorUiState() when $default != null:
return $default(_that.projectId,_that.name,_that.color,_that.weeklyGoalMinutes,_that.countsTowardDailyGoal,_that.archived,_that.dailyGoal);case _:
  return null;

}
}

}

/// @nodoc


class _ProjectEditorUiState extends ProjectEditorUiState {
  const _ProjectEditorUiState({required this.projectId, required this.name, required this.color, required this.weeklyGoalMinutes, required this.countsTowardDailyGoal, required this.archived, required this.dailyGoal}): super._();
  

/// Null when creating a project.
@override final  int? projectId;
@override final  String name;
@override final  int color;
@override final  int weeklyGoalMinutes;
@override final  bool countsTowardDailyGoal;
@override final  bool archived;
/// From settings, for "Adds this project's time to your 8h target".
@override final  Duration dailyGoal;

/// Create a copy of ProjectEditorUiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectEditorUiStateCopyWith<_ProjectEditorUiState> get copyWith => __$ProjectEditorUiStateCopyWithImpl<_ProjectEditorUiState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectEditorUiState&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.weeklyGoalMinutes, weeklyGoalMinutes) || other.weeklyGoalMinutes == weeklyGoalMinutes)&&(identical(other.countsTowardDailyGoal, countsTowardDailyGoal) || other.countsTowardDailyGoal == countsTowardDailyGoal)&&(identical(other.archived, archived) || other.archived == archived)&&(identical(other.dailyGoal, dailyGoal) || other.dailyGoal == dailyGoal));
}


@override
int get hashCode => Object.hash(runtimeType,projectId,name,color,weeklyGoalMinutes,countsTowardDailyGoal,archived,dailyGoal);

@override
String toString() {
  return 'ProjectEditorUiState(projectId: $projectId, name: $name, color: $color, weeklyGoalMinutes: $weeklyGoalMinutes, countsTowardDailyGoal: $countsTowardDailyGoal, archived: $archived, dailyGoal: $dailyGoal)';
}


}

/// @nodoc
abstract mixin class _$ProjectEditorUiStateCopyWith<$Res> implements $ProjectEditorUiStateCopyWith<$Res> {
  factory _$ProjectEditorUiStateCopyWith(_ProjectEditorUiState value, $Res Function(_ProjectEditorUiState) _then) = __$ProjectEditorUiStateCopyWithImpl;
@override @useResult
$Res call({
 int? projectId, String name, int color, int weeklyGoalMinutes, bool countsTowardDailyGoal, bool archived, Duration dailyGoal
});




}
/// @nodoc
class __$ProjectEditorUiStateCopyWithImpl<$Res>
    implements _$ProjectEditorUiStateCopyWith<$Res> {
  __$ProjectEditorUiStateCopyWithImpl(this._self, this._then);

  final _ProjectEditorUiState _self;
  final $Res Function(_ProjectEditorUiState) _then;

/// Create a copy of ProjectEditorUiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = freezed,Object? name = null,Object? color = null,Object? weeklyGoalMinutes = null,Object? countsTowardDailyGoal = null,Object? archived = null,Object? dailyGoal = null,}) {
  return _then(_ProjectEditorUiState(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,weeklyGoalMinutes: null == weeklyGoalMinutes ? _self.weeklyGoalMinutes : weeklyGoalMinutes // ignore: cast_nullable_to_non_nullable
as int,countsTowardDailyGoal: null == countsTowardDailyGoal ? _self.countsTowardDailyGoal : countsTowardDailyGoal // ignore: cast_nullable_to_non_nullable
as bool,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,dailyGoal: null == dailyGoal ? _self.dailyGoal : dailyGoal // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

// dart format on
