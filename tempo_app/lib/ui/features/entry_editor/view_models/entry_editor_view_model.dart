import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/dependencies.dart';
import '../../../../domain/models/project.dart';
import '../../../../domain/models/time_entry.dart';
import '../../../../utils/dates.dart';
import 'entry_editor_ui_state.dart';

/// Keyed by entry id; null adds a new entry. State is null when the entry
/// to edit no longer exists.
final entryEditorViewModelProvider = AsyncNotifierProvider.autoDispose
    .family<EntryEditorViewModel, EntryEditorUiState?, int?>(
      EntryEditorViewModel.new,
    );

class EntryEditorViewModel extends AsyncNotifier<EntryEditorUiState?> {
  EntryEditorViewModel(this.entryId);

  final int? entryId;

  /// Loaded once; later rebuilds (new projects or tags) keep the user's edits.
  EntryDraft? _draft;
  List<Project> _projects = const [];
  List<String> _tagNames = const [];

  @override
  Future<EntryEditorUiState?> build() async {
    final (projects, tagNames) = await (
      ref.watch(projectsProvider.future),
      ref.watch(tagNamesProvider.future),
    ).wait;
    _projects = projects;
    _tagNames = tagNames;

    if (_draft == null) {
      if (entryId case final id?) {
        final entry = await ref.read(timeEntryRepositoryProvider).getEntry(id);
        if (entry == null) return null;
        _draft = _draftOf(entry);
      } else {
        _draft = _newDraft();
      }
    }
    return _compose();
  }

  void setDescription(String description) =>
      _edit((d) => d.copyWith(description: description));

  void setNote(String note) => _edit((d) => d.copyWith(note: note));

  void setProject(int? projectId) =>
      _edit((d) => d.copyWith(projectId: projectId));

  /// Moves the entry to [date], keeping its times of day.
  void setDate(DateTime date) => _edit(
    (d) => d.copyWith(
      startAt: _onDay(date, d.startAt),
      endAt: d.endAt == null ? null : _onDay(date, d.endAt!),
    ),
  );

  void setStartTime(int hour, int minute) => _edit(
    (d) => d.copyWith(
      startAt: DateTime(
        d.startAt.year,
        d.startAt.month,
        d.startAt.day,
        hour,
        minute,
      ),
    ),
  );

  /// Ignored while running: a running entry has no end yet.
  void setEndTime(int hour, int minute) => _edit(
    (d) => d.endAt == null
        ? d
        : d.copyWith(
            endAt: DateTime(
              d.startAt.year,
              d.startAt.month,
              d.startAt.day,
              hour,
              minute,
            ),
          ),
  );

  void toggleTag(String tag) => _edit(
    (d) => d.copyWith(
      tags: d.tags.contains(tag)
          ? [...d.tags.where((t) => t != tag)]
          : [...d.tags, tag],
    ),
  );

  void addTag(String tag) {
    final name = tag.trim();
    if (name.isEmpty) return;
    _edit(
      (d) => d.tags.contains(name) ? d : d.copyWith(tags: [...d.tags, name]),
    );
  }

  /// Returns false without saving when the draft is invalid.
  Future<bool> save() async {
    final draft = _draft;
    if (draft == null || _validate(draft) != EntryValidation.valid) {
      return false;
    }
    final repository = ref.read(timeEntryRepositoryProvider);
    if (entryId case final id?) {
      await repository.updateEntry(
        TimeEntry(
          id: id,
          projectId: draft.projectId,
          description: draft.description,
          startAt: draft.startAt,
          endAt: draft.endAt,
          tags: draft.tags,
          note: draft.note,
        ),
      );
    } else {
      await repository.addEntry(
        projectId: draft.projectId,
        description: draft.description,
        startAt: draft.startAt,
        endAt: draft.endAt!,
        tags: draft.tags,
        note: draft.note,
      );
    }
    return true;
  }

  Future<void> delete() async {
    if (entryId case final id?) {
      await ref.read(timeEntryRepositoryProvider).deleteEntry(id);
    }
  }

  void _edit(EntryDraft Function(EntryDraft draft) change) {
    final draft = _draft;
    if (draft == null) return;
    _draft = change(draft);
    state = AsyncData(_compose());
  }

  EntryEditorUiState _compose() {
    final draft = _draft!;
    return EntryEditorUiState(
      entryId: entryId,
      draft: draft,
      projects: [
        for (final p in _projects)
          if (!p.archived || p.id == draft.projectId) p,
      ],
      tagNames: {..._tagNames, ...draft.tags}.toList(),
      validation: _validate(draft),
    );
  }

  EntryValidation _validate(EntryDraft draft) {
    final endAt = draft.endAt;
    if (endAt != null && !endAt.isAfter(draft.startAt)) {
      return EntryValidation.endBeforeStart;
    }
    if (draft.startAt.isAfter(ref.read(clockProvider)())) {
      return EntryValidation.startInFuture;
    }
    return EntryValidation.valid;
  }

  /// The hour before now, clamped to today.
  EntryDraft _newDraft() {
    final now = ref.read(clockProvider)();
    final end = DateTime(now.year, now.month, now.day, now.hour, now.minute);
    final hourEarlier = end.subtract(const Duration(hours: 1));
    final midnight = startOfDay(now);
    return EntryDraft(
      startAt: hourEarlier.isBefore(midnight) ? midnight : hourEarlier,
      endAt: end,
    );
  }

  static EntryDraft _draftOf(TimeEntry entry) => EntryDraft(
    projectId: entry.projectId,
    description: entry.description,
    startAt: entry.startAt,
    endAt: entry.endAt,
    tags: entry.tags,
    note: entry.note,
  );

  /// [time]'s time of day (seconds kept) on [date].
  static DateTime _onDay(DateTime date, DateTime time) => DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
    time.second,
  );
}
