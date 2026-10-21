import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/domain/models/project.dart';
import 'package:tempo_app/domain/models/time_entry.dart';
import 'package:tempo_app/domain/use_cases/backup_format.dart';

void main() {
  test('encode then decode gives the same data', () {
    final data = (
      projects: [
        const Project(
          id: 3,
          name: 'វគ្គ Flutter',
          color: 0xFF2B50E6,
          weeklyGoalMinutes: 600,
          archived: true,
        ),
      ],
      entries: [
        TimeEntry(
          id: 9,
          projectId: 3,
          description: 'Build timer screen',
          startAt: DateTime(2026, 10, 20, 9),
          endAt: DateTime(2026, 10, 20, 10, 45),
          tags: ['Deep work'],
          note: 'Ring done',
        ),
        TimeEntry(id: 10, startAt: DateTime(2026, 10, 20, 17)),
      ],
    );

    final decoded = BackupFormat.decode(
      BackupFormat.encode(data, exportedAt: DateTime(2026, 10, 20)),
    );

    expect(decoded.projects, data.projects);
    expect(decoded.entries, data.entries);
  });

  test('rejects files that are not Tempo backups', () {
    for (final source in [
      'not json',
      '{}',
      '{"app": "other", "version": 1, "projects": [], "entries": []}',
      '{"app": "tempo", "version": 2, "projects": [], "entries": []}',
      '{"app": "tempo", "version": 1, "projects": [{"id": "x"}], "entries": []}',
    ]) {
      expect(
        () => BackupFormat.decode(source),
        throwsFormatException,
        reason: source,
      );
    }
  });
}
