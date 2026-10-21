// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'period_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportRange {

 ReportPeriod get period; DateTime get start; DateTime get end;
/// Create a copy of ReportRange
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportRangeCopyWith<ReportRange> get copyWith => _$ReportRangeCopyWithImpl<ReportRange>(this as ReportRange, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportRange&&(identical(other.period, period) || other.period == period)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}


@override
int get hashCode => Object.hash(runtimeType,period,start,end);

@override
String toString() {
  return 'ReportRange(period: $period, start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class $ReportRangeCopyWith<$Res>  {
  factory $ReportRangeCopyWith(ReportRange value, $Res Function(ReportRange) _then) = _$ReportRangeCopyWithImpl;
@useResult
$Res call({
 ReportPeriod period, DateTime start, DateTime end
});




}
/// @nodoc
class _$ReportRangeCopyWithImpl<$Res>
    implements $ReportRangeCopyWith<$Res> {
  _$ReportRangeCopyWithImpl(this._self, this._then);

  final ReportRange _self;
  final $Res Function(ReportRange) _then;

/// Create a copy of ReportRange
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? period = null,Object? start = null,Object? end = null,}) {
  return _then(ReportRange(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as ReportPeriod,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportRange].
extension ReportRangePatterns on ReportRange {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportRange value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportRange() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportRange value)  $default,){
final _that = this;
switch (_that) {
case _ReportRange():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportRange value)?  $default,){
final _that = this;
switch (_that) {
case _ReportRange() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReportPeriod period,  DateTime start,  DateTime end)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportRange() when $default != null:
return $default(_that.period,_that.start,_that.end);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReportPeriod period,  DateTime start,  DateTime end)  $default,) {final _that = this;
switch (_that) {
case _ReportRange():
return $default(_that.period,_that.start,_that.end);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReportPeriod period,  DateTime start,  DateTime end)?  $default,) {final _that = this;
switch (_that) {
case _ReportRange() when $default != null:
return $default(_that.period,_that.start,_that.end);case _:
  return null;

}
}

}

/// @nodoc


class _ReportRange extends ReportRange {
  const _ReportRange({required this.period, required this.start, required this.end}): super._();
  

@override final  ReportPeriod period;
@override final  DateTime start;
@override final  DateTime end;

/// Create a copy of ReportRange
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportRangeCopyWith<_ReportRange> get copyWith => __$ReportRangeCopyWithImpl<_ReportRange>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportRange&&(identical(other.period, period) || other.period == period)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}


@override
int get hashCode => Object.hash(runtimeType,period,start,end);

@override
String toString() {
  return 'ReportRange(period: $period, start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class _$ReportRangeCopyWith<$Res> implements $ReportRangeCopyWith<$Res> {
  factory _$ReportRangeCopyWith(_ReportRange value, $Res Function(_ReportRange) _then) = __$ReportRangeCopyWithImpl;
@override @useResult
$Res call({
 ReportPeriod period, DateTime start, DateTime end
});




}
/// @nodoc
class __$ReportRangeCopyWithImpl<$Res>
    implements _$ReportRangeCopyWith<$Res> {
  __$ReportRangeCopyWithImpl(this._self, this._then);

  final _ReportRange _self;
  final $Res Function(_ReportRange) _then;

/// Create a copy of ReportRange
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? period = null,Object? start = null,Object? end = null,}) {
  return _then(_ReportRange(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as ReportPeriod,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$PeriodReport {

 List<Duration> get buckets;/// Keyed by project id; null holds entries without a project.
 Map<int?, Duration> get byProject;
/// Create a copy of PeriodReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodReportCopyWith<PeriodReport> get copyWith => _$PeriodReportCopyWithImpl<PeriodReport>(this as PeriodReport, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodReport&&const DeepCollectionEquality().equals(other.buckets, buckets)&&const DeepCollectionEquality().equals(other.byProject, byProject));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(buckets),const DeepCollectionEquality().hash(byProject));

@override
String toString() {
  return 'PeriodReport(buckets: $buckets, byProject: $byProject)';
}


}

/// @nodoc
abstract mixin class $PeriodReportCopyWith<$Res>  {
  factory $PeriodReportCopyWith(PeriodReport value, $Res Function(PeriodReport) _then) = _$PeriodReportCopyWithImpl;
@useResult
$Res call({
 List<Duration> buckets, Map<int?, Duration> byProject
});




}
/// @nodoc
class _$PeriodReportCopyWithImpl<$Res>
    implements $PeriodReportCopyWith<$Res> {
  _$PeriodReportCopyWithImpl(this._self, this._then);

  final PeriodReport _self;
  final $Res Function(PeriodReport) _then;

/// Create a copy of PeriodReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? buckets = null,Object? byProject = null,}) {
  return _then(PeriodReport(
buckets: null == buckets ? _self.buckets : buckets // ignore: cast_nullable_to_non_nullable
as List<Duration>,byProject: null == byProject ? _self.byProject : byProject // ignore: cast_nullable_to_non_nullable
as Map<int?, Duration>,
  ));
}

}


/// Adds pattern-matching-related methods to [PeriodReport].
extension PeriodReportPatterns on PeriodReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PeriodReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PeriodReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PeriodReport value)  $default,){
final _that = this;
switch (_that) {
case _PeriodReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PeriodReport value)?  $default,){
final _that = this;
switch (_that) {
case _PeriodReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Duration> buckets,  Map<int?, Duration> byProject)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PeriodReport() when $default != null:
return $default(_that.buckets,_that.byProject);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Duration> buckets,  Map<int?, Duration> byProject)  $default,) {final _that = this;
switch (_that) {
case _PeriodReport():
return $default(_that.buckets,_that.byProject);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Duration> buckets,  Map<int?, Duration> byProject)?  $default,) {final _that = this;
switch (_that) {
case _PeriodReport() when $default != null:
return $default(_that.buckets,_that.byProject);case _:
  return null;

}
}

}

/// @nodoc


class _PeriodReport extends PeriodReport {
  const _PeriodReport({required  List<Duration> buckets, required  Map<int?, Duration> byProject}): _buckets = buckets,_byProject = byProject,super._();
  

 final  List<Duration> _buckets;
@override List<Duration> get buckets {
  if (_buckets is EqualUnmodifiableListView) return _buckets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_buckets);
}

/// Keyed by project id; null holds entries without a project.
 final  Map<int?, Duration> _byProject;
/// Keyed by project id; null holds entries without a project.
@override Map<int?, Duration> get byProject {
  if (_byProject is EqualUnmodifiableMapView) return _byProject;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byProject);
}


/// Create a copy of PeriodReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeriodReportCopyWith<_PeriodReport> get copyWith => __$PeriodReportCopyWithImpl<_PeriodReport>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeriodReport&&const DeepCollectionEquality().equals(other._buckets, _buckets)&&const DeepCollectionEquality().equals(other._byProject, _byProject));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_buckets),const DeepCollectionEquality().hash(_byProject));

@override
String toString() {
  return 'PeriodReport(buckets: $buckets, byProject: $byProject)';
}


}

/// @nodoc
abstract mixin class _$PeriodReportCopyWith<$Res> implements $PeriodReportCopyWith<$Res> {
  factory _$PeriodReportCopyWith(_PeriodReport value, $Res Function(_PeriodReport) _then) = __$PeriodReportCopyWithImpl;
@override @useResult
$Res call({
 List<Duration> buckets, Map<int?, Duration> byProject
});




}
/// @nodoc
class __$PeriodReportCopyWithImpl<$Res>
    implements _$PeriodReportCopyWith<$Res> {
  __$PeriodReportCopyWithImpl(this._self, this._then);

  final _PeriodReport _self;
  final $Res Function(_PeriodReport) _then;

/// Create a copy of PeriodReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? buckets = null,Object? byProject = null,}) {
  return _then(_PeriodReport(
buckets: null == buckets ? _self._buckets : buckets // ignore: cast_nullable_to_non_nullable
as List<Duration>,byProject: null == byProject ? _self._byProject : byProject // ignore: cast_nullable_to_non_nullable
as Map<int?, Duration>,
  ));
}


}

// dart format on
