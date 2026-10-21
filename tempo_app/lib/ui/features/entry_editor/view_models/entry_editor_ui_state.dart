import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/models/project.dart';

part 'entry_editor_ui_state.freezed.dart';

enum EntryValidation { valid, endBeforeStart, startInFuture }

/// The entry as the user is editing it; written to the database on save.
@freezed
abstract class EntryDraft with _$EntryDraft {
  const factory EntryDraft({
    int? projectId,
    @Default('') String description,
    required DateTime startAt,

    /// Null while the entry's timer is running.
    DateTime? endAt,
    @Default(<String>[]) List<String> tags,
    @Default('') String note,
  }) = _EntryDraft;
}

@freezed
abstract class EntryEditorUiState with _$EntryEditorUiState {
  const EntryEditorUiState._();

  const factory EntryEditorUiState({
    /// Null when adding a new entry.
    required int? entryId,
    required EntryDraft draft,

    /// Active projects, plus the draft's project if it is archived.
    required List<Project> projects,
    required List<String> tagNames,
    required EntryValidation validation,
  }) = _EntryEditorUiState;

  bool get isNew => entryId == null;
  bool get isRunning => draft.endAt == null;
  bool get canSave => validation == EntryValidation.valid;

  Project? get project =>
      projects.where((p) => p.id == draft.projectId).firstOrNull;

  /// Null while running.
  Duration? get duration => draft.endAt?.difference(draft.startAt);
}
