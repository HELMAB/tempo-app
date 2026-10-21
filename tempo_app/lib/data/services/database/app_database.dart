import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables.dart';

export 'tables.dart';

part 'app_database.g.dart';

/// Local SQLite database: the single source of truth for projects and
/// time entries. Only repositories talk to it.
@DriftDatabase(tables: [Projects, TimeEntries, Tags, EntryTags])
class AppDatabase extends _$AppDatabase {
  /// Pass an executor in tests, e.g. `NativeDatabase.memory()`.
  AppDatabase([QueryExecutor? executor])
    : super(
        executor ??
            driftDatabase(
              name: 'tempo',
              // Both files live in web/ and come from the drift release that
              // matches the drift version in pubspec.lock. Re-download them
              // when upgrading drift.
              web: DriftWebOptions(
                sqlite3Wasm: Uri.parse('sqlite3.wasm'),
                driftWorker: Uri.parse('drift_worker.js'),
              ),
            ),
      );

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
