// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'projects_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProjectsUiState {

 ProjectsRange get range; List<Project> get active; List<Project> get archived; ProjectTotals get totals;
/// Create a copy of ProjectsUiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectsUiStateCopyWith<ProjectsUiState> get copyWith => _$ProjectsUiStateCopyWithImpl<ProjectsUiState>(this as ProjectsUiState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectsUiState&&(identical(other.range, range) || other.range == range)&&const DeepCollectionEquality().equals(other.active, active)&&const DeepCollectionEquality().equals(other.archived, archived)&&(identical(other.totals, totals) || other.totals == totals));
}


@override
int get hashCode => Object.hash(runtimeType,range,const DeepCollectionEquality().hash(active),const DeepCollectionEquality().hash(archived),totals);

@override
String toString() {
  return 'ProjectsUiState(range: $range, active: $active, archived: $archived, totals: $totals)';
}


}

/// @nodoc
abstract mixin class $ProjectsUiStateCopyWith<$Res>  {
  factory $ProjectsUiStateCopyWith(ProjectsUiState value, $Res Function(ProjectsUiState) _then) = _$ProjectsUiStateCopyWithImpl;
@useResult
$Res call({
 ProjectsRange range, List<Project> active, List<Project> archived, ProjectTotals totals
});


$ProjectTotalsCopyWith<$Res> get totals;

}
/// @nodoc
class _$ProjectsUiStateCopyWithImpl<$Res>
    implements $ProjectsUiStateCopyWith<$Res> {
  _$ProjectsUiStateCopyWithImpl(this._self, this._then);

  final ProjectsUiState _self;
  final $Res Function(ProjectsUiState) _then;

/// Create a copy of ProjectsUiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? range = null,Object? active = null,Object? archived = null,Object? totals = null,}) {
  return _then(ProjectsUiState(
range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as ProjectsRange,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as List<Project>,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as List<Project>,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as ProjectTotals,
  ));
}
/// Create a copy of ProjectsUiState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectTotalsCopyWith<$Res> get totals {
  
  return $ProjectTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProjectsUiState].
extension ProjectsUiStatePatterns on ProjectsUiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectsUiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectsUiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectsUiState value)  $default,){
final _that = this;
switch (_that) {
case _ProjectsUiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectsUiState value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectsUiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProjectsRange range,  List<Project> active,  List<Project> archived,  ProjectTotals totals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectsUiState() when $default != null:
return $default(_that.range,_that.active,_that.archived,_that.totals);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProjectsRange range,  List<Project> active,  List<Project> archived,  ProjectTotals totals)  $default,) {final _that = this;
switch (_that) {
case _ProjectsUiState():
return $default(_that.range,_that.active,_that.archived,_that.totals);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProjectsRange range,  List<Project> active,  List<Project> archived,  ProjectTotals totals)?  $default,) {final _that = this;
switch (_that) {
case _ProjectsUiState() when $default != null:
return $default(_that.range,_that.active,_that.archived,_that.totals);case _:
  return null;

}
}

}

/// @nodoc


class _ProjectsUiState extends ProjectsUiState {
  const _ProjectsUiState({required this.range, required  List<Project> active, required  List<Project> archived, required this.totals}): _active = active,_archived = archived,super._();
  

@override final  ProjectsRange range;
 final  List<Project> _active;
@override List<Project> get active {
  if (_active is EqualUnmodifiableListView) return _active;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_active);
}

 final  List<Project> _archived;
@override List<Project> get archived {
  if (_archived is EqualUnmodifiableListView) return _archived;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_archived);
}

@override final  ProjectTotals totals;

/// Create a copy of ProjectsUiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectsUiStateCopyWith<_ProjectsUiState> get copyWith => __$ProjectsUiStateCopyWithImpl<_ProjectsUiState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectsUiState&&(identical(other.range, range) || other.range == range)&&const DeepCollectionEquality().equals(other._active, _active)&&const DeepCollectionEquality().equals(other._archived, _archived)&&(identical(other.totals, totals) || other.totals == totals));
}


@override
int get hashCode => Object.hash(runtimeType,range,const DeepCollectionEquality().hash(_active),const DeepCollectionEquality().hash(_archived),totals);

@override
String toString() {
  return 'ProjectsUiState(range: $range, active: $active, archived: $archived, totals: $totals)';
}


}

/// @nodoc
abstract mixin class _$ProjectsUiStateCopyWith<$Res> implements $ProjectsUiStateCopyWith<$Res> {
  factory _$ProjectsUiStateCopyWith(_ProjectsUiState value, $Res Function(_ProjectsUiState) _then) = __$ProjectsUiStateCopyWithImpl;
@override @useResult
$Res call({
 ProjectsRange range, List<Project> active, List<Project> archived, ProjectTotals totals
});


@override $ProjectTotalsCopyWith<$Res> get totals;

}
/// @nodoc
class __$ProjectsUiStateCopyWithImpl<$Res>
    implements _$ProjectsUiStateCopyWith<$Res> {
  __$ProjectsUiStateCopyWithImpl(this._self, this._then);

  final _ProjectsUiState _self;
  final $Res Function(_ProjectsUiState) _then;

/// Create a copy of ProjectsUiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? range = null,Object? active = null,Object? archived = null,Object? totals = null,}) {
  return _then(_ProjectsUiState(
range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as ProjectsRange,active: null == active ? _self._active : active // ignore: cast_nullable_to_non_nullable
as List<Project>,archived: null == archived ? _self._archived : archived // ignore: cast_nullable_to_non_nullable
as List<Project>,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as ProjectTotals,
  ));
}

/// Create a copy of ProjectsUiState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectTotalsCopyWith<$Res> get totals {
  
  return $ProjectTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}

// dart format on
