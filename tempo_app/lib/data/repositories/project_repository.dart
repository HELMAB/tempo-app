import 'package:drift/drift.dart';

import '../../domain/models/project.dart';
import '../services/database/app_database.dart';

class ProjectRepository {
  ProjectRepository({required AppDatabase database}) : _db = database;

  final AppDatabase _db;

  Stream<List<Project>> watchProjects({bool archived = false}) {
    final query = _db.select(_db.projects)
      ..where((p) => p.archived.equals(archived))
      ..orderBy([(p) => OrderingTerm.asc(p.createdAt)]);
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  Future<Project?> getProject(int id) async {
    final row = await (_db.select(
      _db.projects,
    )..where((p) => p.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }

  Future<Project> createProject({
    required String name,
    required int color,
    int weeklyGoalMinutes = 0,
    bool countsTowardDailyGoal = true,
  }) async {
    final row = await _db
        .into(_db.projects)
        .insertReturning(
          ProjectsCompanion.insert(
            name: name.trim(),
            color: color,
            weeklyGoalMinutes: Value(weeklyGoalMinutes),
            countsTowardDailyGoal: Value(countsTowardDailyGoal),
          ),
        );
    return _toDomain(row);
  }

  Future<void> updateProject(Project project) async {
    await (_db.update(
      _db.projects,
    )..where((p) => p.id.equals(project.id))).write(
      ProjectsCompanion(
        name: Value(project.name.trim()),
        color: Value(project.color),
        weeklyGoalMinutes: Value(project.weeklyGoalMinutes),
        countsTowardDailyGoal: Value(project.countsTowardDailyGoal),
        archived: Value(project.archived),
      ),
    );
  }

  Future<void> setArchived(int id, {required bool archived}) async {
    await (_db.update(_db.projects)..where((p) => p.id.equals(id))).write(
      ProjectsCompanion(archived: Value(archived)),
    );
  }

  Project _toDomain(ProjectRow row) => Project(
    id: row.id,
    name: row.name,
    color: row.color,
    weeklyGoalMinutes: row.weeklyGoalMinutes,
    countsTowardDailyGoal: row.countsTowardDailyGoal,
    archived: row.archived,
  );
}
