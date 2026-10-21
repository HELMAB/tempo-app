// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'today_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodayUiState {

 DateTime get day;/// Oldest first, as in the prototype.
 List<EntryWithProject> get entries;/// Active projects for the quick-start picker.
 List<Project> get projects;/// Project the next quick-start timer will use.
 Project? get quickStartProject; EntryWithProject? get running; Duration get dailyGoal;
/// Create a copy of TodayUiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodayUiStateCopyWith<TodayUiState> get copyWith => _$TodayUiStateCopyWithImpl<TodayUiState>(this as TodayUiState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayUiState&&(identical(other.day, day) || other.day == day)&&const DeepCollectionEquality().equals(other.entries, entries)&&const DeepCollectionEquality().equals(other.projects, projects)&&(identical(other.quickStartProject, quickStartProject) || other.quickStartProject == quickStartProject)&&(identical(other.running, running) || other.running == running)&&(identical(other.dailyGoal, dailyGoal) || other.dailyGoal == dailyGoal));
}


@override
int get hashCode => Object.hash(runtimeType,day,const DeepCollectionEquality().hash(entries),const DeepCollectionEquality().hash(projects),quickStartProject,running,dailyGoal);

@override
String toString() {
  return 'TodayUiState(day: $day, entries: $entries, projects: $projects, quickStartProject: $quickStartProject, running: $running, dailyGoal: $dailyGoal)';
}


}

/// @nodoc
abstract mixin class $TodayUiStateCopyWith<$Res>  {
  factory $TodayUiStateCopyWith(TodayUiState value, $Res Function(TodayUiState) _then) = _$TodayUiStateCopyWithImpl;
@useResult
$Res call({
 DateTime day, List<EntryWithProject> entries, List<Project> projects, Project? quickStartProject, EntryWithProject? running, Duration dailyGoal
});


$ProjectCopyWith<$Res>? get quickStartProject;

}
/// @nodoc
class _$TodayUiStateCopyWithImpl<$Res>
    implements $TodayUiStateCopyWith<$Res> {
  _$TodayUiStateCopyWithImpl(this._self, this._then);

  final TodayUiState _self;
  final $Res Function(TodayUiState) _then;

/// Create a copy of TodayUiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? entries = null,Object? projects = null,Object? quickStartProject = freezed,Object? running = freezed,Object? dailyGoal = null,}) {
  return _then(TodayUiState(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<EntryWithProject>,projects: null == projects ? _self.projects : projects // ignore: cast_nullable_to_non_nullable
as List<Project>,quickStartProject: freezed == quickStartProject ? _self.quickStartProject : quickStartProject // ignore: cast_nullable_to_non_nullable
as Project?,running: freezed == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as EntryWithProject?,dailyGoal: null == dailyGoal ? _self.dailyGoal : dailyGoal // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}
/// Create a copy of TodayUiState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectCopyWith<$Res>? get quickStartProject {
    if (_self.quickStartProject == null) {
    return null;
  }

  return $ProjectCopyWith<$Res>(_self.quickStartProject!, (value) {
    return _then(_self.copyWith(quickStartProject: value));
  });
}
}


/// Adds pattern-matching-related methods to [TodayUiState].
extension TodayUiStatePatterns on TodayUiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodayUiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodayUiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodayUiState value)  $default,){
final _that = this;
switch (_that) {
case _TodayUiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodayUiState value)?  $default,){
final _that = this;
switch (_that) {
case _TodayUiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime day,  List<EntryWithProject> entries,  List<Project> projects,  Project? quickStartProject,  EntryWithProject? running,  Duration dailyGoal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodayUiState() when $default != null:
return $default(_that.day,_that.entries,_that.projects,_that.quickStartProject,_that.running,_that.dailyGoal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime day,  List<EntryWithProject> entries,  List<Project> projects,  Project? quickStartProject,  EntryWithProject? running,  Duration dailyGoal)  $default,) {final _that = this;
switch (_that) {
case _TodayUiState():
return $default(_that.day,_that.entries,_that.projects,_that.quickStartProject,_that.running,_that.dailyGoal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime day,  List<EntryWithProject> entries,  List<Project> projects,  Project? quickStartProject,  EntryWithProject? running,  Duration dailyGoal)?  $default,) {final _that = this;
switch (_that) {
case _TodayUiState() when $default != null:
return $default(_that.day,_that.entries,_that.projects,_that.quickStartProject,_that.running,_that.dailyGoal);case _:
  return null;

}
}

}

/// @nodoc


class _TodayUiState extends TodayUiState {
  const _TodayUiState({required this.day, required  List<EntryWithProject> entries, required  List<Project> projects, required this.quickStartProject, required this.running, required this.dailyGoal}): _entries = entries,_projects = projects,super._();
  

@override final  DateTime day;
/// Oldest first, as in the prototype.
 final  List<EntryWithProject> _entries;
/// Oldest first, as in the prototype.
@override List<EntryWithProject> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

/// Active projects for the quick-start picker.
 final  List<Project> _projects;
/// Active projects for the quick-start picker.
@override List<Project> get projects {
  if (_projects is EqualUnmodifiableListView) return _projects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_projects);
}

/// Project the next quick-start timer will use.
@override final  Project? quickStartProject;
@override final  EntryWithProject? running;
@override final  Duration dailyGoal;

/// Create a copy of TodayUiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodayUiStateCopyWith<_TodayUiState> get copyWith => __$TodayUiStateCopyWithImpl<_TodayUiState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodayUiState&&(identical(other.day, day) || other.day == day)&&const DeepCollectionEquality().equals(other._entries, _entries)&&const DeepCollectionEquality().equals(other._projects, _projects)&&(identical(other.quickStartProject, quickStartProject) || other.quickStartProject == quickStartProject)&&(identical(other.running, running) || other.running == running)&&(identical(other.dailyGoal, dailyGoal) || other.dailyGoal == dailyGoal));
}


@override
int get hashCode => Object.hash(runtimeType,day,const DeepCollectionEquality().hash(_entries),const DeepCollectionEquality().hash(_projects),quickStartProject,running,dailyGoal);

@override
String toString() {
  return 'TodayUiState(day: $day, entries: $entries, projects: $projects, quickStartProject: $quickStartProject, running: $running, dailyGoal: $dailyGoal)';
}


}

/// @nodoc
abstract mixin class _$TodayUiStateCopyWith<$Res> implements $TodayUiStateCopyWith<$Res> {
  factory _$TodayUiStateCopyWith(_TodayUiState value, $Res Function(_TodayUiState) _then) = __$TodayUiStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime day, List<EntryWithProject> entries, List<Project> projects, Project? quickStartProject, EntryWithProject? running, Duration dailyGoal
});


@override $ProjectCopyWith<$Res>? get quickStartProject;

}
/// @nodoc
class __$TodayUiStateCopyWithImpl<$Res>
    implements _$TodayUiStateCopyWith<$Res> {
  __$TodayUiStateCopyWithImpl(this._self, this._then);

  final _TodayUiState _self;
  final $Res Function(_TodayUiState) _then;

/// Create a copy of TodayUiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = null,Object? entries = null,Object? projects = null,Object? quickStartProject = freezed,Object? running = freezed,Object? dailyGoal = null,}) {
  return _then(_TodayUiState(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DateTime,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<EntryWithProject>,projects: null == projects ? _self._projects : projects // ignore: cast_nullable_to_non_nullable
as List<Project>,quickStartProject: freezed == quickStartProject ? _self.quickStartProject : quickStartProject // ignore: cast_nullable_to_non_nullable
as Project?,running: freezed == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as EntryWithProject?,dailyGoal: null == dailyGoal ? _self.dailyGoal : dailyGoal // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

/// Create a copy of TodayUiState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectCopyWith<$Res>? get quickStartProject {
    if (_self.quickStartProject == null) {
    return null;
  }

  return $ProjectCopyWith<$Res>(_self.quickStartProject!, (value) {
    return _then(_self.copyWith(quickStartProject: value));
  });
}
}

// dart format on
