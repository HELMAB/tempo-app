import 'dart:convert';

import '../models/project.dart';
import '../models/time_entry.dart';

/// Everything a backup file holds. Settings stay on the device.
typedef BackupData = ({List<Project> projects, List<TimeEntry> entries});

/// JSON backup format, version 1. [decodeBackup] throws [FormatException]
/// for anything that isn't a Tempo backup.
abstract final class BackupFormat {
  static const _app = 'tempo';
  static const _version = 1;

  static String encode(BackupData data, {required DateTime exportedAt}) =>
      const JsonEncoder.withIndent('  ').convert({
        'app': _app,
        'version': _version,
        'exportedAt': exportedAt.toUtc().toIso8601String(),
        'projects': [
          for (final p in data.projects)
            {
              'id': p.id,
              'name': p.name,
              'color': p.color,
              'weeklyGoalMinutes': p.weeklyGoalMinutes,
              'countsTowardDailyGoal': p.countsTowardDailyGoal,
              'archived': p.archived,
            },
        ],
        'entries': [
          for (final e in data.entries)
            {
              'id': e.id,
              'projectId': e.projectId,
              'description': e.description,
              'startAt': e.startAt.toUtc().toIso8601String(),
              'endAt': e.endAt?.toUtc().toIso8601String(),
              'tags': e.tags,
              'note': e.note,
            },
        ],
      });

  static BackupData decode(String source) {
    try {
      final json = jsonDecode(source);
      if (json case {
        'app': _app,
        'version': _version,
        'projects': final List<Object?> projects,
        'entries': final List<Object?> entries,
      }) {
        return (
          projects: [for (final p in projects) _project(p)],
          entries: [for (final e in entries) _entry(e)],
        );
      }
    } on FormatException {
      rethrow;
    } on Object {
      // Wrong types inside an otherwise valid document fall through.
    }
    throw const FormatException('Not a Tempo backup');
  }

  static Project _project(Object? json) => switch (json) {
    {
      'id': final int id,
      'name': final String name,
      'color': final int color,
      'weeklyGoalMinutes': final int weeklyGoalMinutes,
      'countsTowardDailyGoal': final bool countsTowardDailyGoal,
      'archived': final bool archived,
    } =>
      Project(
        id: id,
        name: name,
        color: color,
        weeklyGoalMinutes: weeklyGoalMinutes,
        countsTowardDailyGoal: countsTowardDailyGoal,
        archived: archived,
      ),
    _ => throw const FormatException('Invalid project'),
  };

  static TimeEntry _entry(Object? json) => switch (json) {
    {
      'id': final int id,
      'projectId': final int? projectId,
      'description': final String description,
      'startAt': final String startAt,
      'endAt': final String? endAt,
      'tags': final List<Object?> tags,
      'note': final String note,
    } =>
      TimeEntry(
        id: id,
        projectId: projectId,
        description: description,
        startAt: DateTime.parse(startAt).toLocal(),
        endAt: endAt == null ? null : DateTime.parse(endAt).toLocal(),
        tags: [for (final tag in tags) tag as String],
        note: note,
      ),
    _ => throw const FormatException('Invalid entry'),
  };
}
