import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/domain/models/time_entry.dart';
import 'package:tempo_app/domain/use_cases/period_report.dart';

void main() {
  // Tuesday 20 October 2026.
  final now = DateTime(2026, 10, 20, 17);

  ReportRange range(ReportPeriod period, [DateTime? at]) =>
      ReportRange.containing(at ?? now, period, weekStartsOn: DateTime.monday);

  group('ReportRange', () {
    test('day, week and month windows', () {
      expect(range(ReportPeriod.day).start, DateTime(2026, 10, 20));
      expect(range(ReportPeriod.day).end, DateTime(2026, 10, 21));
      expect(range(ReportPeriod.week).start, DateTime(2026, 10, 19));
      expect(range(ReportPeriod.week).end, DateTime(2026, 10, 26));
      expect(range(ReportPeriod.month).start, DateTime(2026, 10));
      expect(range(ReportPeriod.month).end, DateTime(2026, 11));
    });

    test('buckets: 24 hours, 7 days, days of the month', () {
      expect(range(ReportPeriod.day).buckets, hasLength(24));
      expect(range(ReportPeriod.week).buckets, hasLength(7));
      expect(range(ReportPeriod.month).buckets, hasLength(31));
      expect(
        range(ReportPeriod.month, DateTime(2026, 2, 10)).buckets,
        hasLength(28),
      );
    });

    test('previous and next keep the period', () {
      final week = range(ReportPeriod.week);
      expect(week.previous.start, DateTime(2026, 10, 12));
      expect(week.next.start, DateTime(2026, 10, 26));
      final january = range(ReportPeriod.month, DateTime(2027, 1, 5));
      expect(january.previous.start, DateTime(2026, 12));
      expect(january.previous.end, DateTime(2027, 1));
    });
  });

  group('PeriodReport', () {
    TimeEntry entry(DateTime start, DateTime? end, {int? project}) => TimeEntry(
      id: start.hashCode,
      projectId: project,
      startAt: start,
      endAt: end,
    );

    test('splits entries across hour buckets', () {
      final report = PeriodReport.of(
        range: range(ReportPeriod.day),
        entries: [
          entry(DateTime(2026, 10, 20, 9, 30), DateTime(2026, 10, 20, 11, 15)),
        ],
        now: now,
      );

      expect(report.buckets[9], const Duration(minutes: 30));
      expect(report.buckets[10], const Duration(hours: 1));
      expect(report.buckets[11], const Duration(minutes: 15));
      expect(report.total, const Duration(hours: 1, minutes: 45));
    });

    test('counts the running entry up to now, per project', () {
      final report = PeriodReport.of(
        range: range(ReportPeriod.week),
        entries: [
          entry(
            DateTime(2026, 10, 19, 9),
            DateTime(2026, 10, 19, 13),
            project: 1,
          ),
          entry(DateTime(2026, 10, 20, 16), null, project: 2),
          entry(DateTime(2026, 10, 20, 8), DateTime(2026, 10, 20, 8, 30)),
        ],
        now: now,
      );

      expect(report.buckets[0], const Duration(hours: 4));
      expect(report.buckets[1], const Duration(hours: 1, minutes: 30));
      expect(report.projectsByTime.map((e) => e.key), [1, 2, null]);
    });

    test('until cuts the range short', () {
      final report = PeriodReport.of(
        range: range(ReportPeriod.day),
        entries: [entry(DateTime(2026, 10, 20, 9), DateTime(2026, 10, 20, 12))],
        now: now,
        until: DateTime(2026, 10, 20, 10),
      );

      expect(report.total, const Duration(hours: 1));
    });
  });
}
