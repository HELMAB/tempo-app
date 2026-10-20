import 'package:drift/drift.dart';

/// Row classes are suffixed with `Row` so they never clash with the domain
/// models in `lib/domain/models`. Repositories map rows to domain models.

@DataClassName('ProjectRow')
class Projects extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 80)();

  /// ARGB colour value, one of the project palette swatches.
  IntColumn get color => integer()();
  IntColumn get weeklyGoalMinutes => integer().withDefault(const Constant(0))();
  BoolColumn get countsTowardDailyGoal =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// The running timer is the single entry whose `end_at` is null; the partial
/// unique index enforces that there is never more than one.
@DataClassName('TimeEntryRow')
@TableIndex(name: 'time_entries_start_at', columns: {#startAt})
@TableIndex.sql(
  'CREATE UNIQUE INDEX time_entries_single_running '
  'ON time_entries ((end_at IS NULL)) WHERE end_at IS NULL',
)
class TimeEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get projectId => integer().nullable().references(
    Projects,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get description => text().withDefault(const Constant(''))();
  DateTimeColumn get startAt => dateTime()();
  DateTimeColumn get endAt => dateTime().nullable()();
  TextColumn get note => text().withDefault(const Constant(''))();
}

@DataClassName('TagRow')
class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 40).unique()();
}

@DataClassName('EntryTagRow')
class EntryTags extends Table {
  IntColumn get entryId =>
      integer().references(TimeEntries, #id, onDelete: KeyAction.cascade)();
  IntColumn get tagId =>
      integer().references(Tags, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {entryId, tagId};
}
