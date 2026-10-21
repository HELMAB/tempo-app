import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/domain/models/project.dart';
import 'package:tempo_app/domain/models/time_entry.dart';
import 'package:tempo_app/domain/use_cases/entries_csv.dart';

void main() {
  test('one row per entry, with RFC 4180 quoting', () {
    final csv = encodeEntriesCsv(
      [
        TimeEntry(
          id: 1,
          projectId: 7,
          description: 'Review, then "ship"',
          startAt: DateTime(2026, 10, 20, 9),
          endAt: DateTime(2026, 10, 20, 10, 45),
          tags: ['Deep work', 'Learning'],
          note: 'Line one\nline two',
        ),
        TimeEntry(id: 2, startAt: DateTime(2026, 10, 20, 17, 2)),
      ],
      {7: const Project(id: 7, name: 'Flutter course', color: 0)},
    );

    expect(csv.split('\r\n').first, startsWith('Date,Start,End,Duration'));
    expect(
      csv,
      contains(
        '2026-10-20,09:00,10:45,105,Flutter course,'
        '"Review, then ""ship""","Deep work, Learning","Line one\nline two"',
      ),
    );
    expect(csv, endsWith('2026-10-20,17:02,,,,,,'), reason: 'running entry');
  });
}
