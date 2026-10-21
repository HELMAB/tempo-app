// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_totals.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProjectTotals {

/// Keyed by project id; null holds entries without a project.
 Map<int?, Duration> get finished; TimeEntry? get running;
/// Create a copy of ProjectTotals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectTotalsCopyWith<ProjectTotals> get copyWith => _$ProjectTotalsCopyWithImpl<ProjectTotals>(this as ProjectTotals, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectTotals&&const DeepCollectionEquality().equals(other.finished, finished)&&(identical(other.running, running) || other.running == running));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(finished),running);

@override
String toString() {
  return 'ProjectTotals(finished: $finished, running: $running)';
}


}

/// @nodoc
abstract mixin class $ProjectTotalsCopyWith<$Res>  {
  factory $ProjectTotalsCopyWith(ProjectTotals value, $Res Function(ProjectTotals) _then) = _$ProjectTotalsCopyWithImpl;
@useResult
$Res call({
 Map<int?, Duration> finished, TimeEntry? running
});


$TimeEntryCopyWith<$Res>? get running;

}
/// @nodoc
class _$ProjectTotalsCopyWithImpl<$Res>
    implements $ProjectTotalsCopyWith<$Res> {
  _$ProjectTotalsCopyWithImpl(this._self, this._then);

  final ProjectTotals _self;
  final $Res Function(ProjectTotals) _then;

/// Create a copy of ProjectTotals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? finished = null,Object? running = freezed,}) {
  return _then(ProjectTotals(
finished: null == finished ? _self.finished : finished // ignore: cast_nullable_to_non_nullable
as Map<int?, Duration>,running: freezed == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as TimeEntry?,
  ));
}
/// Create a copy of ProjectTotals
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeEntryCopyWith<$Res>? get running {
    if (_self.running == null) {
    return null;
  }

  return $TimeEntryCopyWith<$Res>(_self.running!, (value) {
    return _then(_self.copyWith(running: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProjectTotals].
extension ProjectTotalsPatterns on ProjectTotals {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectTotals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectTotals() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectTotals value)  $default,){
final _that = this;
switch (_that) {
case _ProjectTotals():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectTotals value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectTotals() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<int?, Duration> finished,  TimeEntry? running)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectTotals() when $default != null:
return $default(_that.finished,_that.running);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<int?, Duration> finished,  TimeEntry? running)  $default,) {final _that = this;
switch (_that) {
case _ProjectTotals():
return $default(_that.finished,_that.running);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<int?, Duration> finished,  TimeEntry? running)?  $default,) {final _that = this;
switch (_that) {
case _ProjectTotals() when $default != null:
return $default(_that.finished,_that.running);case _:
  return null;

}
}

}

/// @nodoc


class _ProjectTotals extends ProjectTotals {
  const _ProjectTotals({required  Map<int?, Duration> finished, this.running}): _finished = finished,super._();
  

/// Keyed by project id; null holds entries without a project.
 final  Map<int?, Duration> _finished;
/// Keyed by project id; null holds entries without a project.
@override Map<int?, Duration> get finished {
  if (_finished is EqualUnmodifiableMapView) return _finished;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_finished);
}

@override final  TimeEntry? running;

/// Create a copy of ProjectTotals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectTotalsCopyWith<_ProjectTotals> get copyWith => __$ProjectTotalsCopyWithImpl<_ProjectTotals>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectTotals&&const DeepCollectionEquality().equals(other._finished, _finished)&&(identical(other.running, running) || other.running == running));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_finished),running);

@override
String toString() {
  return 'ProjectTotals(finished: $finished, running: $running)';
}


}

/// @nodoc
abstract mixin class _$ProjectTotalsCopyWith<$Res> implements $ProjectTotalsCopyWith<$Res> {
  factory _$ProjectTotalsCopyWith(_ProjectTotals value, $Res Function(_ProjectTotals) _then) = __$ProjectTotalsCopyWithImpl;
@override @useResult
$Res call({
 Map<int?, Duration> finished, TimeEntry? running
});


@override $TimeEntryCopyWith<$Res>? get running;

}
/// @nodoc
class __$ProjectTotalsCopyWithImpl<$Res>
    implements _$ProjectTotalsCopyWith<$Res> {
  __$ProjectTotalsCopyWithImpl(this._self, this._then);

  final _ProjectTotals _self;
  final $Res Function(_ProjectTotals) _then;

/// Create a copy of ProjectTotals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? finished = null,Object? running = freezed,}) {
  return _then(_ProjectTotals(
finished: null == finished ? _self._finished : finished // ignore: cast_nullable_to_non_nullable
as Map<int?, Duration>,running: freezed == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as TimeEntry?,
  ));
}

/// Create a copy of ProjectTotals
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeEntryCopyWith<$Res>? get running {
    if (_self.running == null) {
    return null;
  }

  return $TimeEntryCopyWith<$Res>(_self.running!, (value) {
    return _then(_self.copyWith(running: value));
  });
}
}

// dart format on
