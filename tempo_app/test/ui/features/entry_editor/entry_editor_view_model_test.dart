import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/config/dependencies.dart';
import 'package:tempo_app/ui/features/entry_editor/view_models/entry_editor_ui_state.dart';
import 'package:tempo_app/ui/features/entry_editor/view_models/entry_editor_view_model.dart';

import '../../../testing/test_dependencies.dart';

void main() {
  late DateTime now;
  late ProviderContainer container;

  setUp(() async {
    now = DateTime(2026, 10, 20, 12, 34, 56);
    container = await createTestContainer(clock: () => now);
  });

  Future<EntryEditorUiState?> open(int? entryId) async {
    container.listen(entryEditorViewModelProvider(entryId), (_, _) {});
    await settle();
    return container.read(entryEditorViewModelProvider(entryId).future);
  }

  EntryEditorViewModel viewModel(int? entryId) =>
      container.read(entryEditorViewModelProvider(entryId).notifier);

  group('new entry', () {
    test('defaults to the hour before now, to the minute', () async {
      final state = (await open(null))!;

      expect(state.isNew, isTrue);
      expect(state.draft.startAt, DateTime(2026, 10, 20, 11, 34));
      expect(state.draft.endAt, DateTime(2026, 10, 20, 12, 34));
      expect(state.duration, const Duration(hours: 1));
      expect(state.canSave, isTrue);
    });

    test('just after midnight the default starts at midnight', () async {
      now = DateTime(2026, 10, 20, 0, 20);
      final state = (await open(null))!;

      expect(state.draft.startAt, DateTime(2026, 10, 20));
    });

    test('validates the times', () async {
      await open(null);
      viewModel(null).setEndTime(10, 0);
      viewModel(null).setStartTime(10, 30);
      var state = container.read(entryEditorViewModelProvider(null)).value!;
      expect(state.validation, EntryValidation.endBeforeStart);
      expect(await viewModel(null).save(), isFalse);

      viewModel(null).setStartTime(13, 0);
      viewModel(null).setEndTime(14, 0);
      state = container.read(entryEditorViewModelProvider(null)).value!;
      expect(state.validation, EntryValidation.startInFuture);
    });

    test('save adds the entry with every field', () async {
      final project = await container
          .read(projectRepositoryProvider)
          .createProject(name: 'Flutter course', color: 0);
      await open(null);
      viewModel(null)
        ..setDescription('Build timer screen')
        ..setProject(project.id)
        ..setDate(DateTime(2026, 10, 19))
        ..setStartTime(9, 0)
        ..setEndTime(10, 45)
        ..addTag('Deep work')
        ..setNote('Ring laid out');

      expect(await viewModel(null).save(), isTrue);

      final entries = await container
          .read(timeEntryRepositoryProvider)
          .watchEntries(
            from: DateTime(2026, 10, 19),
            to: DateTime(2026, 10, 20),
          )
          .first;
      expect(entries, hasLength(1));
      final entry = entries.single;
      expect(entry.description, 'Build timer screen');
      expect(entry.projectId, project.id);
      expect(entry.startAt, DateTime(2026, 10, 19, 9));
      expect(entry.endAt, DateTime(2026, 10, 19, 10, 45));
      expect(entry.tags, ['Deep work']);
      expect(entry.note, 'Ring laid out');
    });
  });

  group('existing entry', () {
    test('editing text keeps the original seconds', () async {
      final entries = container.read(timeEntryRepositoryProvider);
      final id = await entries.addEntry(
        description: 'Code review',
        startAt: DateTime(2026, 10, 20, 9, 0, 15),
        endAt: DateTime(2026, 10, 20, 9, 55, 40),
      );
      await open(id);

      viewModel(id).setDescription('Code review (PR 12)');
      expect(await viewModel(id).save(), isTrue);

      final saved = await entries.getEntry(id);
      expect(saved?.description, 'Code review (PR 12)');
      expect(saved?.startAt, DateTime(2026, 10, 20, 9, 0, 15));
      expect(saved?.endAt, DateTime(2026, 10, 20, 9, 55, 40));
    });

    test('a running entry stays running after saving', () async {
      final entries = container.read(timeEntryRepositoryProvider);
      final id = await entries.startTimer(description: 'Deep work');
      final state = (await open(id))!;
      expect(state.isRunning, isTrue);

      viewModel(id).setStartTime(12, 0);
      expect(await viewModel(id).save(), isTrue);

      final saved = await entries.getEntry(id);
      expect(saved?.isRunning, isTrue);
      expect(saved?.startAt, DateTime(2026, 10, 20, 12));
    });

    test('delete removes the entry', () async {
      final entries = container.read(timeEntryRepositoryProvider);
      final id = await entries.addEntry(
        startAt: DateTime(2026, 10, 20, 9),
        endAt: DateTime(2026, 10, 20, 10),
      );
      await open(id);

      await viewModel(id).delete();

      expect(await entries.getEntry(id), isNull);
    });

    test('a missing entry gives a null state', () async {
      expect(await open(404), isNull);
    });
  });
}
