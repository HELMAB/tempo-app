// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entry_editor_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EntryDraft {

 int? get projectId; String get description; DateTime get startAt;/// Null while the entry's timer is running.
 DateTime? get endAt; List<String> get tags; String get note;
/// Create a copy of EntryDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntryDraftCopyWith<EntryDraft> get copyWith => _$EntryDraftCopyWithImpl<EntryDraft>(this as EntryDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntryDraft&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.description, description) || other.description == description)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,projectId,description,startAt,endAt,const DeepCollectionEquality().hash(tags),note);

@override
String toString() {
  return 'EntryDraft(projectId: $projectId, description: $description, startAt: $startAt, endAt: $endAt, tags: $tags, note: $note)';
}


}

/// @nodoc
abstract mixin class $EntryDraftCopyWith<$Res>  {
  factory $EntryDraftCopyWith(EntryDraft value, $Res Function(EntryDraft) _then) = _$EntryDraftCopyWithImpl;
@useResult
$Res call({
 int? projectId, String description, DateTime startAt, DateTime? endAt, List<String> tags, String note
});




}
/// @nodoc
class _$EntryDraftCopyWithImpl<$Res>
    implements $EntryDraftCopyWith<$Res> {
  _$EntryDraftCopyWithImpl(this._self, this._then);

  final EntryDraft _self;
  final $Res Function(EntryDraft) _then;

/// Create a copy of EntryDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = freezed,Object? description = null,Object? startAt = null,Object? endAt = freezed,Object? tags = null,Object? note = null,}) {
  return _then(EntryDraft(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,endAt: freezed == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EntryDraft].
extension EntryDraftPatterns on EntryDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EntryDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EntryDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EntryDraft value)  $default,){
final _that = this;
switch (_that) {
case _EntryDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EntryDraft value)?  $default,){
final _that = this;
switch (_that) {
case _EntryDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? projectId,  String description,  DateTime startAt,  DateTime? endAt,  List<String> tags,  String note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntryDraft() when $default != null:
return $default(_that.projectId,_that.description,_that.startAt,_that.endAt,_that.tags,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? projectId,  String description,  DateTime startAt,  DateTime? endAt,  List<String> tags,  String note)  $default,) {final _that = this;
switch (_that) {
case _EntryDraft():
return $default(_that.projectId,_that.description,_that.startAt,_that.endAt,_that.tags,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? projectId,  String description,  DateTime startAt,  DateTime? endAt,  List<String> tags,  String note)?  $default,) {final _that = this;
switch (_that) {
case _EntryDraft() when $default != null:
return $default(_that.projectId,_that.description,_that.startAt,_that.endAt,_that.tags,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _EntryDraft implements EntryDraft {
  const _EntryDraft({this.projectId, this.description = '', required this.startAt, this.endAt,  List<String> tags = const <String>[], this.note = ''}): _tags = tags;
  

@override final  int? projectId;
@override@JsonKey() final  String description;
@override final  DateTime startAt;
/// Null while the entry's timer is running.
@override final  DateTime? endAt;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  String note;

/// Create a copy of EntryDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntryDraftCopyWith<_EntryDraft> get copyWith => __$EntryDraftCopyWithImpl<_EntryDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntryDraft&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.description, description) || other.description == description)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,projectId,description,startAt,endAt,const DeepCollectionEquality().hash(_tags),note);

@override
String toString() {
  return 'EntryDraft(projectId: $projectId, description: $description, startAt: $startAt, endAt: $endAt, tags: $tags, note: $note)';
}


}

/// @nodoc
abstract mixin class _$EntryDraftCopyWith<$Res> implements $EntryDraftCopyWith<$Res> {
  factory _$EntryDraftCopyWith(_EntryDraft value, $Res Function(_EntryDraft) _then) = __$EntryDraftCopyWithImpl;
@override @useResult
$Res call({
 int? projectId, String description, DateTime startAt, DateTime? endAt, List<String> tags, String note
});




}
/// @nodoc
class __$EntryDraftCopyWithImpl<$Res>
    implements _$EntryDraftCopyWith<$Res> {
  __$EntryDraftCopyWithImpl(this._self, this._then);

  final _EntryDraft _self;
  final $Res Function(_EntryDraft) _then;

/// Create a copy of EntryDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = freezed,Object? description = null,Object? startAt = null,Object? endAt = freezed,Object? tags = null,Object? note = null,}) {
  return _then(_EntryDraft(
projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as int?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,endAt: freezed == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$EntryEditorUiState {

/// Null when adding a new entry.
 int? get entryId; EntryDraft get draft;/// Active projects, plus the draft's project if it is archived.
 List<Project> get projects; List<String> get tagNames; EntryValidation get validation;
/// Create a copy of EntryEditorUiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntryEditorUiStateCopyWith<EntryEditorUiState> get copyWith => _$EntryEditorUiStateCopyWithImpl<EntryEditorUiState>(this as EntryEditorUiState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntryEditorUiState&&(identical(other.entryId, entryId) || other.entryId == entryId)&&(identical(other.draft, draft) || other.draft == draft)&&const DeepCollectionEquality().equals(other.projects, projects)&&const DeepCollectionEquality().equals(other.tagNames, tagNames)&&(identical(other.validation, validation) || other.validation == validation));
}


@override
int get hashCode => Object.hash(runtimeType,entryId,draft,const DeepCollectionEquality().hash(projects),const DeepCollectionEquality().hash(tagNames),validation);

@override
String toString() {
  return 'EntryEditorUiState(entryId: $entryId, draft: $draft, projects: $projects, tagNames: $tagNames, validation: $validation)';
}


}

/// @nodoc
abstract mixin class $EntryEditorUiStateCopyWith<$Res>  {
  factory $EntryEditorUiStateCopyWith(EntryEditorUiState value, $Res Function(EntryEditorUiState) _then) = _$EntryEditorUiStateCopyWithImpl;
@useResult
$Res call({
 int? entryId, EntryDraft draft, List<Project> projects, List<String> tagNames, EntryValidation validation
});


$EntryDraftCopyWith<$Res> get draft;

}
/// @nodoc
class _$EntryEditorUiStateCopyWithImpl<$Res>
    implements $EntryEditorUiStateCopyWith<$Res> {
  _$EntryEditorUiStateCopyWithImpl(this._self, this._then);

  final EntryEditorUiState _self;
  final $Res Function(EntryEditorUiState) _then;

/// Create a copy of EntryEditorUiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entryId = freezed,Object? draft = null,Object? projects = null,Object? tagNames = null,Object? validation = null,}) {
  return _then(EntryEditorUiState(
entryId: freezed == entryId ? _self.entryId : entryId // ignore: cast_nullable_to_non_nullable
as int?,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as EntryDraft,projects: null == projects ? _self.projects : projects // ignore: cast_nullable_to_non_nullable
as List<Project>,tagNames: null == tagNames ? _self.tagNames : tagNames // ignore: cast_nullable_to_non_nullable
as List<String>,validation: null == validation ? _self.validation : validation // ignore: cast_nullable_to_non_nullable
as EntryValidation,
  ));
}
/// Create a copy of EntryEditorUiState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EntryDraftCopyWith<$Res> get draft {
  
  return $EntryDraftCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}


/// Adds pattern-matching-related methods to [EntryEditorUiState].
extension EntryEditorUiStatePatterns on EntryEditorUiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EntryEditorUiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EntryEditorUiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EntryEditorUiState value)  $default,){
final _that = this;
switch (_that) {
case _EntryEditorUiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EntryEditorUiState value)?  $default,){
final _that = this;
switch (_that) {
case _EntryEditorUiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? entryId,  EntryDraft draft,  List<Project> projects,  List<String> tagNames,  EntryValidation validation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntryEditorUiState() when $default != null:
return $default(_that.entryId,_that.draft,_that.projects,_that.tagNames,_that.validation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? entryId,  EntryDraft draft,  List<Project> projects,  List<String> tagNames,  EntryValidation validation)  $default,) {final _that = this;
switch (_that) {
case _EntryEditorUiState():
return $default(_that.entryId,_that.draft,_that.projects,_that.tagNames,_that.validation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? entryId,  EntryDraft draft,  List<Project> projects,  List<String> tagNames,  EntryValidation validation)?  $default,) {final _that = this;
switch (_that) {
case _EntryEditorUiState() when $default != null:
return $default(_that.entryId,_that.draft,_that.projects,_that.tagNames,_that.validation);case _:
  return null;

}
}

}

/// @nodoc


class _EntryEditorUiState extends EntryEditorUiState {
  const _EntryEditorUiState({required this.entryId, required this.draft, required  List<Project> projects, required  List<String> tagNames, required this.validation}): _projects = projects,_tagNames = tagNames,super._();
  

/// Null when adding a new entry.
@override final  int? entryId;
@override final  EntryDraft draft;
/// Active projects, plus the draft's project if it is archived.
 final  List<Project> _projects;
/// Active projects, plus the draft's project if it is archived.
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

@override final  EntryValidation validation;

/// Create a copy of EntryEditorUiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntryEditorUiStateCopyWith<_EntryEditorUiState> get copyWith => __$EntryEditorUiStateCopyWithImpl<_EntryEditorUiState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntryEditorUiState&&(identical(other.entryId, entryId) || other.entryId == entryId)&&(identical(other.draft, draft) || other.draft == draft)&&const DeepCollectionEquality().equals(other._projects, _projects)&&const DeepCollectionEquality().equals(other._tagNames, _tagNames)&&(identical(other.validation, validation) || other.validation == validation));
}


@override
int get hashCode => Object.hash(runtimeType,entryId,draft,const DeepCollectionEquality().hash(_projects),const DeepCollectionEquality().hash(_tagNames),validation);

@override
String toString() {
  return 'EntryEditorUiState(entryId: $entryId, draft: $draft, projects: $projects, tagNames: $tagNames, validation: $validation)';
}


}

/// @nodoc
abstract mixin class _$EntryEditorUiStateCopyWith<$Res> implements $EntryEditorUiStateCopyWith<$Res> {
  factory _$EntryEditorUiStateCopyWith(_EntryEditorUiState value, $Res Function(_EntryEditorUiState) _then) = __$EntryEditorUiStateCopyWithImpl;
@override @useResult
$Res call({
 int? entryId, EntryDraft draft, List<Project> projects, List<String> tagNames, EntryValidation validation
});


@override $EntryDraftCopyWith<$Res> get draft;

}
/// @nodoc
class __$EntryEditorUiStateCopyWithImpl<$Res>
    implements _$EntryEditorUiStateCopyWith<$Res> {
  __$EntryEditorUiStateCopyWithImpl(this._self, this._then);

  final _EntryEditorUiState _self;
  final $Res Function(_EntryEditorUiState) _then;

/// Create a copy of EntryEditorUiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entryId = freezed,Object? draft = null,Object? projects = null,Object? tagNames = null,Object? validation = null,}) {
  return _then(_EntryEditorUiState(
entryId: freezed == entryId ? _self.entryId : entryId // ignore: cast_nullable_to_non_nullable
as int?,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as EntryDraft,projects: null == projects ? _self._projects : projects // ignore: cast_nullable_to_non_nullable
as List<Project>,tagNames: null == tagNames ? _self._tagNames : tagNames // ignore: cast_nullable_to_non_nullable
as List<String>,validation: null == validation ? _self.validation : validation // ignore: cast_nullable_to_non_nullable
as EntryValidation,
  ));
}

/// Create a copy of EntryEditorUiState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EntryDraftCopyWith<$Res> get draft {
  
  return $EntryDraftCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}

// dart format on
