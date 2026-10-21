import 'package:intl/intl.dart';

import '../models/project.dart';
import '../models/time_entry.dart';

/// Entries as RFC 4180 CSV for spreadsheets. Column names stay in English
/// so files from either language import the same way.
String encodeEntriesCsv(
  Iterable<TimeEntry> entries,
  Map<int, Project> projectsById,
) {
  final date = DateFormat('yyyy-MM-dd');
  final time = DateFormat('HH:mm');
  final rows = <List<String>>[
    [
      'Date',
      'Start',
      'End',
      'Duration (minutes)',
      'Project',
      'Description',
      'Tags',
      'Note',
    ],
    for (final entry in entries)
      [
        date.format(entry.startAt),
        time.format(entry.startAt),
        // A running entry has no end or length yet.
        if (entry.endAt case final endAt?) time.format(endAt) else '',
        if (entry.endAt case final endAt?)
          '${endAt.difference(entry.startAt).inMinutes}'
        else
          '',
        projectsById[entry.projectId]?.name ?? '',
        entry.description,
        entry.tags.join(', '),
        entry.note,
      ],
  ];
  return rows.map((row) => row.map(_escape).join(',')).join('\r\n');
}

String _escape(String field) => field.contains(RegExp('[",\r\n]'))
    ? '"${field.replaceAll('"', '""')}"'
    : field;
