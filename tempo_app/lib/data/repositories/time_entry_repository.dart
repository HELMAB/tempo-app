import 'package:drift/drift.dart';

import '../../domain/models/time_entry.dart';
import '../services/database/app_database.dart';

class TimeEntryRepository {
  TimeEntryRepository({
    required AppDatabase database,
    this._clock = DateTime.now,
  }) : _db = database;

  final AppDatabase _db;
  final DateTime Function() _clock;

  /// Entries that started in `[from, to)`, oldest first, running entry included.
  Stream<List<TimeEntry>> watchEntries({
    required DateTime from,
    required DateTime to,
  }) {
    return _entriesQuery(
      where:
          _db.timeEntries.startAt.isBiggerOrEqualValue(from) &
          _db.timeEntries.startAt.isSmallerThanValue(to),
    ).watch().map(_groupWithTags);
  }

  Stream<TimeEntry?> watchRunningEntry() {
    return _entriesQuery(
      where: _db.timeEntries.endAt.isNull(),
    ).watch().map((rows) => _groupWithTags(rows).firstOrNull);
  }

  Future<TimeEntry?> getEntry(int id) async {
    final rows = await _entriesQuery(
      where: _db.timeEntries.id.equals(id),
    ).get();
    return _groupWithTags(rows).firstOrNull;
  }

  /// Total time of finished entries per project (null key: no project) for
  /// entries started in `[from, to)`; either bound may be open. The running
  /// entry is left out because its length changes every second.
  Stream<Map<int?, Duration>> watchFinishedTotalsByProject({
    DateTime? from,
    DateTime? to,
  }) {
    final conditions = ['end_at IS NOT NULL'];
    final variables = <Variable<Object>>[];
    if (from != null) {
      conditions.add('start_at >= ?');
      variables.add(Variable<DateTime>(from));
    }
    if (to != null) {
      conditions.add('start_at < ?');
      variables.add(Variable<DateTime>(to));
    }
    return _db
        .customSelect(
          'SELECT project_id, SUM(end_at - start_at) AS seconds '
          'FROM time_entries WHERE ${conditions.join(' AND ')} '
          'GROUP BY project_id',
          variables: variables,
          readsFrom: {_db.timeEntries},
        )
        .watch()
        .map(
          (rows) => {
            for (final row in rows)
              row.read<int?>('project_id'): Duration(
                seconds: row.read<int>('seconds'),
              ),
          },
        );
  }

  Stream<List<String>> watchTagNames() {
    final query = _db.select(_db.tags)
      ..orderBy([(t) => OrderingTerm.asc(t.name)]);
    return query.watch().map((rows) => rows.map((r) => r.name).toList());
  }

  /// Starts a timer, stopping any timer that is already running.
  Future<int> startTimer({
    int? projectId,
    String description = '',
    List<String> tags = const [],
  }) {
    return _db.transaction(() async {
      final now = _clock();
      await _stopRunning(now);
      final id = await _db
          .into(_db.timeEntries)
          .insert(
            TimeEntriesCompanion.insert(
              projectId: Value(projectId),
              description: Value(description.trim()),
              startAt: now,
            ),
          );
      await _replaceTags(id, tags);
      return id;
    });
  }

  Future<void> stopTimer() => _stopRunning(_clock());

  /// Creates a finished entry, e.g. from "Add manually".
  Future<int> addEntry({
    int? projectId,
    String description = '',
    required DateTime startAt,
    required DateTime endAt,
    List<String> tags = const [],
    String note = '',
  }) {
    _checkRange(startAt, endAt);
    return _db.transaction(() async {
      final id = await _db
          .into(_db.timeEntries)
          .insert(
            TimeEntriesCompanion.insert(
              projectId: Value(projectId),
              description: Value(description.trim()),
              startAt: startAt,
              endAt: Value(endAt),
              note: Value(note.trim()),
            ),
          );
      await _replaceTags(id, tags);
      return id;
    });
  }

  Future<void> updateEntry(TimeEntry entry) {
    if (entry.endAt case final endAt?) _checkRange(entry.startAt, endAt);
    return _db.transaction(() async {
      await (_db.update(
        _db.timeEntries,
      )..where((e) => e.id.equals(entry.id))).write(
        TimeEntriesCompanion(
          projectId: Value(entry.projectId),
          description: Value(entry.description.trim()),
          startAt: Value(entry.startAt),
          endAt: Value(entry.endAt),
          note: Value(entry.note.trim()),
        ),
      );
      await _replaceTags(entry.id, entry.tags);
    });
  }

  Future<void> deleteEntry(int id) async {
    await (_db.delete(_db.timeEntries)..where((e) => e.id.equals(id))).go();
  }

  JoinedSelectStatement<HasResultSet, dynamic> _entriesQuery({
    required Expression<bool> where,
  }) {
    return _db.select(_db.timeEntries).join([
        leftOuterJoin(
          _db.entryTags,
          _db.entryTags.entryId.equalsExp(_db.timeEntries.id),
        ),
        leftOuterJoin(_db.tags, _db.tags.id.equalsExp(_db.entryTags.tagId)),
      ])
      ..where(where)
      ..orderBy([
        OrderingTerm.asc(_db.timeEntries.startAt),
        OrderingTerm.asc(_db.tags.name),
      ]);
  }

  List<TimeEntry> _groupWithTags(List<TypedResult> rows) {
    final entries = <int, TimeEntryRow>{};
    final tags = <int, List<String>>{};
    for (final row in rows) {
      final entry = row.readTable(_db.timeEntries);
      entries[entry.id] = entry;
      final tagNames = tags.putIfAbsent(entry.id, () => []);
      if (row.readTableOrNull(_db.tags) case final tag?) tagNames.add(tag.name);
    }
    return [
      for (final MapEntry(key: id, value: row) in entries.entries)
        TimeEntry(
          id: id,
          projectId: row.projectId,
          description: row.description,
          startAt: row.startAt,
          endAt: row.endAt,
          tags: tags[id]!,
          note: row.note,
        ),
    ];
  }

  Future<void> _stopRunning(DateTime at) async {
    await (_db.update(_db.timeEntries)..where((e) => e.endAt.isNull())).write(
      TimeEntriesCompanion(endAt: Value(at)),
    );
  }

  Future<void> _replaceTags(int entryId, List<String> names) async {
    await (_db.delete(
      _db.entryTags,
    )..where((t) => t.entryId.equals(entryId))).go();

    final cleaned = {
      for (final name in names)
        if (name.trim().isNotEmpty) name.trim(),
    };
    if (cleaned.isEmpty) return;

    await _db.batch((batch) {
      batch.insertAll(_db.tags, [
        for (final name in cleaned) TagsCompanion.insert(name: name),
      ], mode: InsertMode.insertOrIgnore);
    });
    final tagRows = await (_db.select(
      _db.tags,
    )..where((t) => t.name.isIn(cleaned))).get();
    await _db.batch((batch) {
      batch.insertAll(_db.entryTags, [
        for (final tag in tagRows)
          EntryTagsCompanion.insert(entryId: entryId, tagId: tag.id),
      ]);
    });
  }

  void _checkRange(DateTime startAt, DateTime endAt) {
    if (!endAt.isAfter(startAt)) {
      throw ArgumentError.value(endAt, 'endAt', 'must be after startAt');
    }
  }
}
