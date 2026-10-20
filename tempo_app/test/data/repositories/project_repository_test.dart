import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/data/repositories/project_repository.dart';
import 'package:tempo_app/data/services/database/app_database.dart';

import '../../testing/test_dependencies.dart';

void main() {
  late AppDatabase database;
  late ProjectRepository repository;

  setUp(() {
    database = createTestDatabase();
    repository = ProjectRepository(database: database);
  });

  tearDown(() => database.close());

  test('createProject trims the name and applies defaults', () async {
    final project = await repository.createProject(
      name: '  Flutter course ',
      color: 0xFF2B50E6,
    );

    expect(project.name, 'Flutter course');
    expect(project.weeklyGoalMinutes, 0);
    expect(project.countsTowardDailyGoal, isTrue);
    expect(project.archived, isFalse);
    expect(await repository.getProject(project.id), project);
  });

  test('watchProjects separates active and archived projects', () async {
    final flutter = await repository.createProject(
      name: 'Flutter course',
      color: 0xFF2B50E6,
      weeklyGoalMinutes: 600,
    );
    final admin = await repository.createProject(
      name: 'Admin',
      color: 0xFF8B55DB,
    );

    await repository.setArchived(admin.id, archived: true);

    expect(await repository.watchProjects().first, [flutter]);
    expect(await repository.watchProjects(archived: true).first, [
      admin.copyWith(archived: true),
    ]);
  });

  test('updateProject persists every editable field', () async {
    final project = await repository.createProject(
      name: 'Reading',
      color: 0xFFDB4874,
    );
    final edited = project.copyWith(
      name: 'Books',
      weeklyGoalMinutes: 240,
      countsTowardDailyGoal: false,
    );

    await repository.updateProject(edited);

    expect(await repository.getProject(project.id), edited);
  });
}
