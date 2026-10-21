// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reports_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportsUiState {

 ReportRange get range; List<TimeEntry> get entries;/// Entries of the period before [range], for the comparison chip.
 List<TimeEntry> get previousEntries; Map<int, Project> get projectsById;
/// Create a copy of ReportsUiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsUiStateCopyWith<ReportsUiState> get copyWith => _$ReportsUiStateCopyWithImpl<ReportsUiState>(this as ReportsUiState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsUiState&&(identical(other.range, range) || other.range == range)&&const DeepCollectionEquality().equals(other.entries, entries)&&const DeepCollectionEquality().equals(other.previousEntries, previousEntries)&&const DeepCollectionEquality().equals(other.projectsById, projectsById));
}


@override
int get hashCode => Object.hash(runtimeType,range,const DeepCollectionEquality().hash(entries),const DeepCollectionEquality().hash(previousEntries),const DeepCollectionEquality().hash(projectsById));

@override
String toString() {
  return 'ReportsUiState(range: $range, entries: $entries, previousEntries: $previousEntries, projectsById: $projectsById)';
}


}

/// @nodoc
abstract mixin class $ReportsUiStateCopyWith<$Res>  {
  factory $ReportsUiStateCopyWith(ReportsUiState value, $Res Function(ReportsUiState) _then) = _$ReportsUiStateCopyWithImpl;
@useResult
$Res call({
 ReportRange range, List<TimeEntry> entries, List<TimeEntry> previousEntries, Map<int, Project> projectsById
});


$ReportRangeCopyWith<$Res> get range;

}
/// @nodoc
class _$ReportsUiStateCopyWithImpl<$Res>
    implements $ReportsUiStateCopyWith<$Res> {
  _$ReportsUiStateCopyWithImpl(this._self, this._then);

  final ReportsUiState _self;
  final $Res Function(ReportsUiState) _then;

/// Create a copy of ReportsUiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? range = null,Object? entries = null,Object? previousEntries = null,Object? projectsById = null,}) {
  return _then(ReportsUiState(
range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as ReportRange,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<TimeEntry>,previousEntries: null == previousEntries ? _self.previousEntries : previousEntries // ignore: cast_nullable_to_non_nullable
as List<TimeEntry>,projectsById: null == projectsById ? _self.projectsById : projectsById // ignore: cast_nullable_to_non_nullable
as Map<int, Project>,
  ));
}
/// Create a copy of ReportsUiState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportRangeCopyWith<$Res> get range {
  
  return $ReportRangeCopyWith<$Res>(_self.range, (value) {
    return _then(_self.copyWith(range: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReportsUiState].
extension ReportsUiStatePatterns on ReportsUiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportsUiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportsUiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportsUiState value)  $default,){
final _that = this;
switch (_that) {
case _ReportsUiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportsUiState value)?  $default,){
final _that = this;
switch (_that) {
case _ReportsUiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReportRange range,  List<TimeEntry> entries,  List<TimeEntry> previousEntries,  Map<int, Project> projectsById)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportsUiState() when $default != null:
return $default(_that.range,_that.entries,_that.previousEntries,_that.projectsById);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReportRange range,  List<TimeEntry> entries,  List<TimeEntry> previousEntries,  Map<int, Project> projectsById)  $default,) {final _that = this;
switch (_that) {
case _ReportsUiState():
return $default(_that.range,_that.entries,_that.previousEntries,_that.projectsById);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReportRange range,  List<TimeEntry> entries,  List<TimeEntry> previousEntries,  Map<int, Project> projectsById)?  $default,) {final _that = this;
switch (_that) {
case _ReportsUiState() when $default != null:
return $default(_that.range,_that.entries,_that.previousEntries,_that.projectsById);case _:
  return null;

}
}

}

/// @nodoc


class _ReportsUiState extends ReportsUiState {
  const _ReportsUiState({required this.range, required  List<TimeEntry> entries, required  List<TimeEntry> previousEntries, required  Map<int, Project> projectsById}): _entries = entries,_previousEntries = previousEntries,_projectsById = projectsById,super._();
  

@override final  ReportRange range;
 final  List<TimeEntry> _entries;
@override List<TimeEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

/// Entries of the period before [range], for the comparison chip.
 final  List<TimeEntry> _previousEntries;
/// Entries of the period before [range], for the comparison chip.
@override List<TimeEntry> get previousEntries {
  if (_previousEntries is EqualUnmodifiableListView) return _previousEntries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_previousEntries);
}

 final  Map<int, Project> _projectsById;
@override Map<int, Project> get projectsById {
  if (_projectsById is EqualUnmodifiableMapView) return _projectsById;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_projectsById);
}


/// Create a copy of ReportsUiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportsUiStateCopyWith<_ReportsUiState> get copyWith => __$ReportsUiStateCopyWithImpl<_ReportsUiState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportsUiState&&(identical(other.range, range) || other.range == range)&&const DeepCollectionEquality().equals(other._entries, _entries)&&const DeepCollectionEquality().equals(other._previousEntries, _previousEntries)&&const DeepCollectionEquality().equals(other._projectsById, _projectsById));
}


@override
int get hashCode => Object.hash(runtimeType,range,const DeepCollectionEquality().hash(_entries),const DeepCollectionEquality().hash(_previousEntries),const DeepCollectionEquality().hash(_projectsById));

@override
String toString() {
  return 'ReportsUiState(range: $range, entries: $entries, previousEntries: $previousEntries, projectsById: $projectsById)';
}


}

/// @nodoc
abstract mixin class _$ReportsUiStateCopyWith<$Res> implements $ReportsUiStateCopyWith<$Res> {
  factory _$ReportsUiStateCopyWith(_ReportsUiState value, $Res Function(_ReportsUiState) _then) = __$ReportsUiStateCopyWithImpl;
@override @useResult
$Res call({
 ReportRange range, List<TimeEntry> entries, List<TimeEntry> previousEntries, Map<int, Project> projectsById
});


@override $ReportRangeCopyWith<$Res> get range;

}
/// @nodoc
class __$ReportsUiStateCopyWithImpl<$Res>
    implements _$ReportsUiStateCopyWith<$Res> {
  __$ReportsUiStateCopyWithImpl(this._self, this._then);

  final _ReportsUiState _self;
  final $Res Function(_ReportsUiState) _then;

/// Create a copy of ReportsUiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? range = null,Object? entries = null,Object? previousEntries = null,Object? projectsById = null,}) {
  return _then(_ReportsUiState(
range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as ReportRange,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<TimeEntry>,previousEntries: null == previousEntries ? _self._previousEntries : previousEntries // ignore: cast_nullable_to_non_nullable
as List<TimeEntry>,projectsById: null == projectsById ? _self._projectsById : projectsById // ignore: cast_nullable_to_non_nullable
as Map<int, Project>,
  ));
}

/// Create a copy of ReportsUiState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportRangeCopyWith<$Res> get range {
  
  return $ReportRangeCopyWith<$Res>(_self.range, (value) {
    return _then(_self.copyWith(range: value));
  });
}
}

// dart format on
