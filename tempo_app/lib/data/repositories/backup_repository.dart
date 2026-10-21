import 'package:drift/drift.dart';
import 'package:intl/intl.dart';

import '../../domain/models/time_entry.dart';
import '../../domain/use_cases/backup_format.dart';
import '../../domain/use_cases/entries_csv.dart';
import '../services/database/app_database.dart';
import '../services/file_service.dart';
import 'project_repository.dart';
import 'time_entry_repository.dart';

/// CSV export and JSON backup / restore.
class BackupRepository {
  BackupRepository({
    required AppDatabase database,
    required this._projects,
    required this._entries,
    required this._files,
    this._clock = DateTime.now,
  }) : _db = database;

  final AppDatabase _db;
  final ProjectRepository _projects;
  final TimeEntryRepository _entries;
  final FileService _files;
  final DateTime Function() _clock;

  static final _fileDate = DateFormat('yyyy-MM-dd');

  /// Shares entries started in `[from, to)` (everything when open) as CSV.
  Future<void> exportCsv({DateTime? from, DateTime? to}) async {
    final (projects, entries) = await (
      _projects.getAllProjects(),
      _entries.getEntries(from: from, to: to),
    ).wait;
    final name = switch ((from, to)) {
      (final from?, final to?) =>
        'tempo-${_fileDate.format(from)}'
            '-to-${_fileDate.format(to.subtract(const Duration(days: 1)))}.csv',
      _ => 'tempo-entries-${_fileDate.format(_clock())}.csv',
    };
    await _files.shareText(
      fileName: name,
      mimeType: 'text/csv',
      contents: encodeEntriesCsv(entries, {for (final p in projects) p.id: p}),
    );
  }

  Future<void> createBackup() async {
    final (projects, entries) = await (
      _projects.getAllProjects(),
      _entries.getEntries(),
    ).wait;
    final now = _clock();
    await _files.shareText(
      fileName: 'tempo-backup-${_fileDate.format(now)}.json',
      mimeType: 'application/json',
      contents: BackupFormat.encode((
        projects: projects,
        entries: entries,
      ), exportedAt: now),
    );
  }

  /// Lets the user pick a backup file. Null when cancelled; throws
  /// [FormatException] when it isn't a Tempo backup.
  Future<BackupData?> pickBackup({required String fileTypeLabel}) async {
    final source = await _files.pickText(
      label: fileTypeLabel,
      extensions: const ['json'],
      mimeTypes: const ['application/json'],
      appleTypes: const ['public.json'],
    );
    return source == null ? null : BackupFormat.decode(source);
  }

  /// Replaces every project, entry and tag with [backup], keeping ids.
  Future<void> restore(BackupData backup) => _db.transaction(() async {
    await _db.delete(_db.entryTags).go();
    await _db.delete(_db.tags).go();
    await _db.delete(_db.timeEntries).go();
    await _db.delete(_db.projects).go();

    await _db.batch((batch) {
      batch.insertAll(_db.projects, [
        for (final p in backup.projects)
          ProjectsCompanion.insert(
            id: Value(p.id),
            name: p.name,
            color: p.color,
            weeklyGoalMinutes: Value(p.weeklyGoalMinutes),
            countsTowardDailyGoal: Value(p.countsTowardDailyGoal),
            archived: Value(p.archived),
          ),
      ]);
      batch.insertAll(_db.timeEntries, [
        for (final e in _withSingleRunning(backup.entries))
          TimeEntriesCompanion.insert(
            id: Value(e.id),
            projectId: Value(e.projectId),
            description: Value(e.description),
            startAt: e.startAt,
            endAt: Value(e.endAt),
            note: Value(e.note),
          ),
      ]);
      final tagNames = {for (final e in backup.entries) ...e.tags};
      batch.insertAll(_db.tags, [
        for (final name in tagNames) TagsCompanion.insert(name: name),
      ]);
    });

    final tagIds = {
      for (final tag in await _db.select(_db.tags).get()) tag.name: tag.id,
    };
    await _db.batch((batch) {
      batch.insertAll(_db.entryTags, [
        for (final e in backup.entries)
          for (final tag in e.tags.toSet())
            EntryTagsCompanion.insert(entryId: e.id, tagId: tagIds[tag]!),
      ]);
    });
  });

  /// The database allows one running entry; extra ones end at their start.
  static Iterable<TimeEntry> _withSingleRunning(List<TimeEntry> entries) {
    var seenRunning = false;
    return entries.map((entry) {
      if (!entry.isRunning) return entry;
      if (!seenRunning) {
        seenRunning = true;
        return entry;
      }
      return entry.copyWith(endAt: entry.startAt);
    });
  }
}
