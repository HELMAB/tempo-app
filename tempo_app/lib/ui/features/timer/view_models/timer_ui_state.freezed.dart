// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimerUiState {

/// The running entry, or the entry that was just paused. Null when
/// there is nothing to show (stopped elsewhere).
 TimeEntry? get entry; bool get isPaused; Project? get project;/// Active projects for the picker.
 List<Project> get projects; List<String> get tagNames; Duration get focusGoal; List<TimeEntry> get todayEntries; Map<int, Project> get projectsById; Duration get dailyGoal;
/// Create a copy of TimerUiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimerUiStateCopyWith<TimerUiState> get copyWith => _$TimerUiStateCopyWithImpl<TimerUiState>(this as TimerUiState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimerUiState&&(identical(other.entry, entry) || other.entry == entry)&&(identical(other.isPaused, isPaused) || other.isPaused == isPaused)&&(identical(other.project, project) || other.project == project)&&const DeepCollectionEquality().equals(other.projects, projects)&&const DeepCollectionEquality().equals(other.tagNames, tagNames)&&(identical(other.focusGoal, focusGoal) || other.focusGoal == focusGoal)&&const DeepCollectionEquality().equals(other.todayEntries, todayEntries)&&const DeepCollectionEquality().equals(other.projectsById, projectsById)&&(identical(other.dailyGoal, dailyGoal) || other.dailyGoal == dailyGoal));
}


@override
int get hashCode => Object.hash(runtimeType,entry,isPaused,project,const DeepCollectionEquality().hash(projects),const DeepCollectionEquality().hash(tagNames),focusGoal,const DeepCollectionEquality().hash(todayEntries),const DeepCollectionEquality().hash(projectsById),dailyGoal);

@override
String toString() {
  return 'TimerUiState(entry: $entry, isPaused: $isPaused, project: $project, projects: $projects, tagNames: $tagNames, focusGoal: $focusGoal, todayEntries: $todayEntries, projectsById: $projectsById, dailyGoal: $dailyGoal)';
}


}

/// @nodoc
abstract mixin class $TimerUiStateCopyWith<$Res>  {
  factory $TimerUiStateCopyWith(TimerUiState value, $Res Function(TimerUiState) _then) = _$TimerUiStateCopyWithImpl;
@useResult
$Res call({
 TimeEntry? entry, bool isPaused, Project? project, List<Project> projects, List<String> tagNames, Duration focusGoal, List<TimeEntry> todayEntries, Map<int, Project> projectsById, Duration dailyGoal
});


$TimeEntryCopyWith<$Res>? get entry;$ProjectCopyWith<$Res>? get project;

}
/// @nodoc
class _$TimerUiStateCopyWithImpl<$Res>
    implements $TimerUiStateCopyWith<$Res> {
  _$TimerUiStateCopyWithImpl(this._self, this._then);

  final TimerUiState _self;
  final $Res Function(TimerUiState) _then;

/// Create a copy of TimerUiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entry = freezed,Object? isPaused = null,Object? project = freezed,Object? projects = null,Object? tagNames = null,Object? focusGoal = null,Object? todayEntries = null,Object? projectsById = null,Object? dailyGoal = null,}) {
  return _then(TimerUiState(
entry: freezed == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as TimeEntry?,isPaused: null == isPaused ? _self.isPaused : isPaused // ignore: cast_nullable_to_non_nullable
as bool,project: freezed == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as Project?,projects: null == projects ? _self.projects : projects // ignore: cast_nullable_to_non_nullable
as List<Project>,tagNames: null == tagNames ? _self.tagNames : tagNames // ignore: cast_nullable_to_non_nullable
as List<String>,focusGoal: null == focusGoal ? _self.focusGoal : focusGoal // ignore: cast_nullable_to_non_nullable
as Duration,todayEntries: null == todayEntries ? _self.todayEntries : todayEntries // ignore: cast_nullable_to_non_nullable
as List<TimeEntry>,projectsById: null == projectsById ? _self.projectsById : projectsById // ignore: cast_nullable_to_non_nullable
as Map<int, Project>,dailyGoal: null == dailyGoal ? _self.dailyGoal : dailyGoal // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}
/// Create a copy of TimerUiState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeEntryCopyWith<$Res>? get entry {
    if (_self.entry == null) {
    return null;
  }

  return $TimeEntryCopyWith<$Res>(_self.entry!, (value) {
    return _then(_self.copyWith(entry: value));
  });
}/// Create a copy of TimerUiState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectCopyWith<$Res>? get project {
    if (_self.project == null) {
    return null;
  }

  return $ProjectCopyWith<$Res>(_self.project!, (value) {
    return _then(_self.copyWith(project: value));
  });
}
}


/// Adds pattern-matching-related methods to [TimerUiState].
extension TimerUiStatePatterns on TimerUiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimerUiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimerUiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimerUiState value)  $default,){
final _that = this;
switch (_that) {
case _TimerUiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimerUiState value)?  $default,){
final _that = this;
switch (_that) {
case _TimerUiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TimeEntry? entry,  bool isPaused,  Project? project,  List<Project> projects,  List<String> tagNames,  Duration focusGoal,  List<TimeEntry> todayEntries,  Map<int, Project> projectsById,  Duration dailyGoal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimerUiState() when $default != null:
return $default(_that.entry,_that.isPaused,_that.project,_that.projects,_that.tagNames,_that.focusGoal,_that.todayEntries,_that.projectsById,_that.dailyGoal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TimeEntry? entry,  bool isPaused,  Project? project,  List<Project> projects,  List<String> tagNames,  Duration focusGoal,  List<TimeEntry> todayEntries,  Map<int, Project> projectsById,  Duration dailyGoal)  $default,) {final _that = this;
switch (_that) {
case _TimerUiState():
return $default(_that.entry,_that.isPaused,_that.project,_that.projects,_that.tagNames,_that.focusGoal,_that.todayEntries,_that.projectsById,_that.dailyGoal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TimeEntry? entry,  bool isPaused,  Project? project,  List<Project> projects,  List<String> tagNames,  Duration focusGoal,  List<TimeEntry> todayEntries,  Map<int, Project> projectsById,  Duration dailyGoal)?  $default,) {final _that = this;
switch (_that) {
case _TimerUiState() when $default != null:
return $default(_that.entry,_that.isPaused,_that.project,_that.projects,_that.tagNames,_that.focusGoal,_that.todayEntries,_that.projectsById,_that.dailyGoal);case _:
  return null;

}
}

}

/// @nodoc


class _TimerUiState extends TimerUiState {
  const _TimerUiState({required this.entry, required this.isPaused, required this.project, required  List<Project> projects, required  List<String> tagNames, required this.focusGoal, required  List<TimeEntry> todayEntries, required  Map<int, Project> projectsById, required this.dailyGoal}): _projects = projects,_tagNames = tagNames,_todayEntries = todayEntries,_projectsById = projectsById,super._();
  

/// The running entry, or the entry that was just paused. Null when
/// there is nothing to show (stopped elsewhere).
@override final  TimeEntry? entry;
@override final  bool isPaused;
@override final  Project? project;
/// Active projects for the picker.
 final  List<Project> _projects;
/// Active projects for the picker.
@override List<Project> get projects {
  if (_projects is EqualUnmodifiableListView) return _projects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_projects);
}

 final  List<String> _tagNames;
@override List<String> get tagNames {
  if (_tagNames is EqualUnmodifiableListView) return _tagNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tagNames);
}

@override final  Duration focusGoal;
 final  List<TimeEntry> _todayEntries;
@override List<TimeEntry> get todayEntries {
  if (_todayEntries is EqualUnmodifiableListView) return _todayEntries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_todayEntries);
}

 final  Map<int, Project> _projectsById;
@override Map<int, Project> get projectsById {
  if (_projectsById is EqualUnmodifiableMapView) return _projectsById;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_projectsById);
}

@override final  Duration dailyGoal;

/// Create a copy of TimerUiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimerUiStateCopyWith<_TimerUiState> get copyWith => __$TimerUiStateCopyWithImpl<_TimerUiState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimerUiState&&(identical(other.entry, entry) || other.entry == entry)&&(identical(other.isPaused, isPaused) || other.isPaused == isPaused)&&(identical(other.project, project) || other.project == project)&&const DeepCollectionEquality().equals(other._projects, _projects)&&const DeepCollectionEquality().equals(other._tagNames, _tagNames)&&(identical(other.focusGoal, focusGoal) || other.focusGoal == focusGoal)&&const DeepCollectionEquality().equals(other._todayEntries, _todayEntries)&&const DeepCollectionEquality().equals(other._projectsById, _projectsById)&&(identical(other.dailyGoal, dailyGoal) || other.dailyGoal == dailyGoal));
}


@override
int get hashCode => Object.hash(runtimeType,entry,isPaused,project,const DeepCollectionEquality().hash(_projects),const DeepCollectionEquality().hash(_tagNames),focusGoal,const DeepCollectionEquality().hash(_todayEntries),const DeepCollectionEquality().hash(_projectsById),dailyGoal);

@override
String toString() {
  return 'TimerUiState(entry: $entry, isPaused: $isPaused, project: $project, projects: $projects, tagNames: $tagNames, focusGoal: $focusGoal, todayEntries: $todayEntries, projectsById: $projectsById, dailyGoal: $dailyGoal)';
}


}

/// @nodoc
abstract mixin class _$TimerUiStateCopyWith<$Res> implements $TimerUiStateCopyWith<$Res> {
  factory _$TimerUiStateCopyWith(_TimerUiState value, $Res Function(_TimerUiState) _then) = __$TimerUiStateCopyWithImpl;
@override @useResult
$Res call({
 TimeEntry? entry, bool isPaused, Project? project, List<Project> projects, List<String> tagNames, Duration focusGoal, List<TimeEntry> todayEntries, Map<int, Project> projectsById, Duration dailyGoal
});


@override $TimeEntryCopyWith<$Res>? get entry;@override $ProjectCopyWith<$Res>? get project;

}
/// @nodoc
class __$TimerUiStateCopyWithImpl<$Res>
    implements _$TimerUiStateCopyWith<$Res> {
  __$TimerUiStateCopyWithImpl(this._self, this._then);

  final _TimerUiState _self;
  final $Res Function(_TimerUiState) _then;

/// Create a copy of TimerUiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entry = freezed,Object? isPaused = null,Object? project = freezed,Object? projects = null,Object? tagNames = null,Object? focusGoal = null,Object? todayEntries = null,Object? projectsById = null,Object? dailyGoal = null,}) {
  return _then(_TimerUiState(
entry: freezed == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as TimeEntry?,isPaused: null == isPaused ? _self.isPaused : isPaused // ignore: cast_nullable_to_non_nullable
as bool,project: freezed == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as Project?,projects: null == projects ? _self._projects : projects // ignore: cast_nullable_to_non_nullable
as List<Project>,tagNames: null == tagNames ? _self._tagNames : tagNames // ignore: cast_nullable_to_non_nullable
as List<String>,focusGoal: null == focusGoal ? _self.focusGoal : focusGoal // ignore: cast_nullable_to_non_nullable
as Duration,todayEntries: null == todayEntries ? _self._todayEntries : todayEntries // ignore: cast_nullable_to_non_nullable
as List<TimeEntry>,projectsById: null == projectsById ? _self._projectsById : projectsById // ignore: cast_nullable_to_non_nullable
as Map<int, Project>,dailyGoal: null == dailyGoal ? _self.dailyGoal : dailyGoal // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

/// Create a copy of TimerUiState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeEntryCopyWith<$Res>? get entry {
    if (_self.entry == null) {
    return null;
  }

  return $TimeEntryCopyWith<$Res>(_self.entry!, (value) {
    return _then(_self.copyWith(entry: value));
  });
}/// Create a copy of TimerUiState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectCopyWith<$Res>? get project {
    if (_self.project == null) {
    return null;
  }

  return $ProjectCopyWith<$Res>(_self.project!, (value) {
    return _then(_self.copyWith(project: value));
  });
}
}

// dart format on
