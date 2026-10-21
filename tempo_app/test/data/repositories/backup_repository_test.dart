import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/data/repositories/backup_repository.dart';
import 'package:tempo_app/data/repositories/project_repository.dart';
import 'package:tempo_app/data/repositories/time_entry_repository.dart';
import 'package:tempo_app/data/services/database/app_database.dart';
import 'package:tempo_app/domain/models/project.dart';
import 'package:tempo_app/domain/models/time_entry.dart';
import 'package:tempo_app/domain/use_cases/backup_format.dart';

import '../../testing/fakes.dart';
import '../../testing/test_dependencies.dart';

void main() {
  late AppDatabase database;
  late ProjectRepository projects;
  late TimeEntryRepository entries;
  late FakeFileService files;
  late BackupRepository backups;

  setUp(() {
    database = createTestDatabase();
    projects = ProjectRepository(database: database);
    entries = TimeEntryRepository(database: database);
    files = FakeFileService();
    backups = BackupRepository(
      database: database,
      projects: projects,
      entries: entries,
      files: files,
      clock: () => DateTime(2026, 10, 20),
    );
  });

  tearDown(() => database.close());

  test('a backup restores into an empty database unchanged', () async {
    final project = await projects.createProject(name: 'Reading', color: 1);
    await entries.addEntry(
      projectId: project.id,
      startAt: DateTime(2026, 10, 20, 9),
      endAt: DateTime(2026, 10, 20, 10),
      tags: ['Books'],
    );
    await backups.createBackup();
    final file = files.shared.single;
    expect(file.fileName, 'tempo-backup-2026-10-20.json');

    final other = createTestDatabase();
    addTearDown(other.close);
    final restoreInto = BackupRepository(
      database: other,
      projects: ProjectRepository(database: other),
      entries: TimeEntryRepository(database: other),
      files: files,
    );
    await restoreInto.restore(BackupFormat.decode(file.contents));

    expect(await ProjectRepository(database: other).getAllProjects(), [
      project,
    ]);
    final restored = await TimeEntryRepository(database: other).getEntries();
    expect(restored.single.tags, ['Books']);
    expect(restored.single.projectId, project.id);
  });

  test('restore replaces existing data and keeps one running entry', () async {
    await projects.createProject(name: 'Old', color: 1);
    await entries.startTimer(description: 'Old timer');

    await backups.restore((
      projects: [const Project(id: 5, name: 'New', color: 2)],
      entries: [
        TimeEntry(id: 1, projectId: 5, startAt: DateTime(2026, 10, 20, 9)),
        TimeEntry(id: 2, startAt: DateTime(2026, 10, 20, 11)),
      ],
    ));

    expect((await projects.getAllProjects()).map((p) => p.name), ['New']);
    final restored = await entries.getEntries();
    expect(restored.where((e) => e.isRunning), hasLength(1));
    expect(restored.firstWhere((e) => e.id == 2).endAt, restored.last.startAt);
  });

  test('CSV export of a range names the file after it', () async {
    await entries.addEntry(
      startAt: DateTime(2026, 10, 19, 9),
      endAt: DateTime(2026, 10, 19, 10),
    );
    await entries.addEntry(
      startAt: DateTime(2026, 10, 1, 9),
      endAt: DateTime(2026, 10, 1, 10),
    );

    await backups.exportCsv(
      from: DateTime(2026, 10, 19),
      to: DateTime(2026, 10, 26),
    );

    final file = files.shared.single;
    expect(file.fileName, 'tempo-2026-10-19-to-2026-10-25.csv');
    expect(file.mimeType, 'text/csv');
    expect(file.contents.split('\r\n'), hasLength(2), reason: 'header + 1');
  });

  test('pickBackup rejects a file that is not a backup', () async {
    files.pickedText = '{"hello": "world"}';

    expect(
      () => backups.pickBackup(fileTypeLabel: 'Tempo backup'),
      throwsFormatException,
    );
  });
}
