import 'package:drift/drift.dart' hide isNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/data/repositories/project_repository.dart';
import 'package:tempo_app/data/repositories/time_entry_repository.dart';
import 'package:tempo_app/data/services/database/app_database.dart';

import '../../testing/test_dependencies.dart';

void main() {
  late AppDatabase database;
  late TimeEntryRepository repository;
  late DateTime now;

  setUp(() {
    database = createTestDatabase();
    now = DateTime(2026, 10, 20, 9);
    repository = TimeEntryRepository(database: database, clock: () => now);
  });

  tearDown(() => database.close());

  group('timer', () {
    test('startTimer creates the running entry', () async {
      final id = await repository.startTimer(
        description: 'Build timer screen',
        tags: ['Deep work'],
      );

      final running = await repository.watchRunningEntry().first;
      expect(running?.id, id);
      expect(running?.isRunning, isTrue);
      expect(running?.startAt, now);
      expect(running?.tags, ['Deep work']);
    });

    test('starting a timer stops the one already running', () async {
      final first = await repository.startTimer(description: 'Inbox');
      now = now.add(const Duration(minutes: 30));
      final second = await repository.startTimer(description: 'Code review');

      final stopped = await repository.getEntry(first);
      expect(stopped?.endAt, now);
      expect(stopped?.durationAt(now), const Duration(minutes: 30));
      expect((await repository.watchRunningEntry().first)?.id, second);
    });

    test('stopTimer ends the running entry', () async {
      final id = await repository.startTimer();
      now = now.add(const Duration(hours: 1, minutes: 12));

      await repository.stopTimer();

      expect(await repository.watchRunningEntry().first, isNull);
      expect((await repository.getEntry(id))?.endAt, now);
    });
  });

  group('entries', () {
    test('addEntry stores tags sorted and de-duplicated', () async {
      final id = await repository.addEntry(
        description: 'Build timer screen',
        startAt: DateTime(2026, 10, 20, 9),
        endAt: DateTime(2026, 10, 20, 10, 45),
        tags: ['Learning', 'Deep work', ' Learning ', ''],
        note: 'Ring and controls laid out.',
      );

      final entry = await repository.getEntry(id);
      expect(entry?.tags, ['Deep work', 'Learning']);
      expect(entry?.durationAt(now), const Duration(hours: 1, minutes: 45));
      expect(await repository.watchTagNames().first, ['Deep work', 'Learning']);
    });

    test('addEntry rejects an end before the start', () {
      expect(
        () => repository.addEntry(
          startAt: DateTime(2026, 10, 20, 10),
          endAt: DateTime(2026, 10, 20, 9),
        ),
        throwsArgumentError,
      );
    });

    test('updateEntry replaces the tags', () async {
      final id = await repository.addEntry(
        startAt: DateTime(2026, 10, 20, 9),
        endAt: DateTime(2026, 10, 20, 10),
        tags: ['Deep work', 'Learning'],
      );
      final entry = (await repository.getEntry(id))!;

      await repository.updateEntry(
        entry.copyWith(description: 'Planning', tags: ['Meeting']),
      );

      final updated = await repository.getEntry(id);
      expect(updated?.description, 'Planning');
      expect(updated?.tags, ['Meeting']);
    });

    test(
      'watchEntries returns entries started in the range, oldest first',
      () async {
        Future<int> add(int hour) => repository.addEntry(
          startAt: DateTime(2026, 10, 20, hour),
          endAt: DateTime(2026, 10, 20, hour, 30),
        );
        final late = await add(15);
        final early = await add(9);
        await repository.addEntry(
          startAt: DateTime(2026, 10, 19, 9),
          endAt: DateTime(2026, 10, 19, 10),
        );

        final entries = await repository
            .watchEntries(
              from: DateTime(2026, 10, 20),
              to: DateTime(2026, 10, 21),
            )
            .first;

        expect(entries.map((e) => e.id), [early, late]);
      },
    );

    test('deleteEntry removes the entry', () async {
      final id = await repository.addEntry(
        startAt: DateTime(2026, 10, 20, 9),
        endAt: DateTime(2026, 10, 20, 10),
        tags: ['Deep work'],
      );

      await repository.deleteEntry(id);

      expect(await repository.getEntry(id), isNull);
    });

    test('deleting a project keeps its entries without a project', () async {
      final project = await ProjectRepository(
        database: database,
      ).createProject(name: 'Client work', color: 0xFFE8772E);
      final id = await repository.addEntry(
        projectId: project.id,
        startAt: DateTime(2026, 10, 20, 15),
        endAt: DateTime(2026, 10, 20, 15, 55),
      );

      await database.projects.deleteWhere((p) => p.id.equals(project.id));

      expect((await repository.getEntry(id))?.projectId, isNull);
    });
  });

  group('totals', () {
    test('sums finished entries per project within the range', () async {
      final project = await ProjectRepository(
        database: database,
      ).createProject(name: 'Flutter course', color: 0);
      Future<void> add(int? projectId, DateTime start, Duration length) =>
          repository.addEntry(
            projectId: projectId,
            startAt: start,
            endAt: start.add(length),
          );
      await add(
        project.id,
        DateTime(2026, 10, 19, 9),
        const Duration(hours: 2),
      );
      await add(
        project.id,
        DateTime(2026, 10, 20, 9),
        const Duration(minutes: 30),
      );
      await add(null, DateTime(2026, 10, 20, 11), const Duration(minutes: 15));
      // Before the range, and a running entry: both left out.
      await add(
        project.id,
        DateTime(2026, 10, 12, 9),
        const Duration(hours: 5),
      );
      await repository.startTimer(projectId: project.id);

      final week = await repository
          .watchFinishedTotalsByProject(from: DateTime(2026, 10, 19))
          .first;
      expect(week, {
        project.id: const Duration(hours: 2, minutes: 30),
        null: const Duration(minutes: 15),
      });

      final allTime = await repository.watchFinishedTotalsByProject().first;
      expect(allTime[project.id], const Duration(hours: 7, minutes: 30));
    });
  });
}
