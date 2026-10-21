import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/dependencies.dart';
import '../../../../domain/models/time_entry.dart';
import '../../../../utils/dates.dart';
import 'timer_ui_state.dart';

final timerViewModelProvider =
    AsyncNotifierProvider.autoDispose<TimerViewModel, TimerUiState>(
      TimerViewModel.new,
    );

/// Pausing stops the running entry and remembers it; resuming starts a new
/// entry with the same details. Elapsed time is only ever derived from
/// `startAt`, so a running timer survives the app being closed.
class TimerViewModel extends AsyncNotifier<TimerUiState> {
  int? _pausedEntryId;

  @override
  Future<TimerUiState> build() async {
    final day = startOfDay(ref.watch(clockProvider)());
    final (running, projects, tagNames, todayEntries, settings) = await (
      ref.watch(runningEntryProvider.future),
      ref.watch(projectsProvider.future),
      ref.watch(tagNamesProvider.future),
      ref.watch(entriesOnDayProvider(day).future),
      ref.watch(appSettingsProvider.future),
    ).wait;

    // _pausedEntryId is only cleared by commands: a rebuild can still see
    // the entry as running while pause() is in flight.
    var entry = running;
    if (running == null && _pausedEntryId != null) {
      entry = await ref
          .read(timeEntryRepositoryProvider)
          .getEntry(_pausedEntryId!);
    }

    final projectsById = {for (final p in projects) p.id: p};
    return TimerUiState(
      entry: entry,
      isPaused: running == null && entry != null,
      project: projectsById[entry?.projectId],
      projects: projects.where((p) => !p.archived).toList(),
      tagNames: tagNames,
      focusGoal: Duration(minutes: settings.focusGoalMinutes),
      todayEntries: todayEntries,
      projectsById: projectsById,
      dailyGoal: Duration(minutes: settings.dailyGoalMinutes),
    );
  }

  Future<void> pause({required String note}) async {
    final entry = state.value?.entry;
    if (entry == null || !entry.isRunning) return;
    await _saveNote(entry, note);
    _pausedEntryId = entry.id;
    await ref.read(timeEntryRepositoryProvider).stopTimer();
  }

  Future<void> resume() async {
    final entry = state.value?.entry;
    if (entry == null || entry.isRunning) return;
    _pausedEntryId = null;
    await ref
        .read(timeEntryRepositoryProvider)
        .startTimer(
          projectId: entry.projectId,
          description: entry.description,
          tags: entry.tags,
        );
  }

  Future<void> stopAndSave({required String note}) async {
    final entry = state.value?.entry;
    if (entry == null) return;
    await _saveNote(entry, note);
    _pausedEntryId = null;
    if (entry.isRunning) {
      await ref.read(timeEntryRepositoryProvider).stopTimer();
    }
  }

  /// Deletes the current (running or paused) entry.
  Future<void> discard() async {
    final entry = state.value?.entry;
    if (entry == null) return;
    _pausedEntryId = null;
    await ref.read(timeEntryRepositoryProvider).deleteEntry(entry.id);
  }

  Future<void> saveNote(String note) async {
    if (state.value?.entry case final entry?) await _saveNote(entry, note);
  }

  Future<void> changeProject(int? projectId) =>
      _update((entry) => entry.copyWith(projectId: projectId));

  Future<void> toggleTag(String tag) => _update(
    (entry) => entry.copyWith(
      tags: entry.tags.contains(tag)
          ? [...entry.tags.where((t) => t != tag)]
          : [...entry.tags, tag],
    ),
  );

  Future<void> addTag(String tag) {
    final name = tag.trim();
    if (name.isEmpty) return Future.value();
    return _update(
      (entry) => entry.tags.contains(name)
          ? entry
          : entry.copyWith(tags: [...entry.tags, name]),
    );
  }

  Future<void> _saveNote(TimeEntry entry, String note) =>
      note.trim() == entry.note
      ? Future.value()
      : _update((current) => current.copyWith(note: note));

  Future<void> _update(TimeEntry Function(TimeEntry entry) change) async {
    final entry = state.value?.entry;
    if (entry == null) return;
    final updated = change(entry);
    if (updated == entry) return;
    await ref.read(timeEntryRepositoryProvider).updateEntry(updated);
    // A paused entry is not streamed, so refresh explicitly.
    if (!entry.isRunning) ref.invalidateSelf();
  }
}
