import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/dates.dart';
import '../models/time_entry.dart';

part 'period_report.freezed.dart';

enum ReportPeriod { day, week, month }

/// A reporting window `[start, end)`: one day, one week (starting on the
/// configured weekday) or one calendar month.
@freezed
abstract class ReportRange with _$ReportRange {
  const ReportRange._();

  const factory ReportRange({
    required ReportPeriod period,
    required DateTime start,
    required DateTime end,
  }) = _ReportRange;

  factory ReportRange.containing(
    DateTime time,
    ReportPeriod period, {
    required int weekStartsOn,
  }) {
    switch (period) {
      case ReportPeriod.day:
        final start = startOfDay(time);
        return ReportRange(
          period: period,
          start: start,
          end: DateTime(start.year, start.month, start.day + 1),
        );
      case ReportPeriod.week:
        final start = startOfWeek(time, weekStartsOn: weekStartsOn);
        return ReportRange(
          period: period,
          start: start,
          end: DateTime(start.year, start.month, start.day + 7),
        );
      case ReportPeriod.month:
        return ReportRange(
          period: period,
          start: DateTime(time.year, time.month),
          end: DateTime(time.year, time.month + 1),
        );
    }
  }

  ReportRange get previous => _shifted(-1);
  ReportRange get next => _shifted(1);

  bool contains(DateTime time) => !time.isBefore(start) && time.isBefore(end);

  /// Bucket starts: 24 hours for a day, one per day for a week or month.
  List<DateTime> get buckets => switch (period) {
    ReportPeriod.day => [
      for (var hour = 0; hour < 24; hour++)
        DateTime(start.year, start.month, start.day, hour),
    ],
    _ => [
      for (
        var day = start;
        day.isBefore(end);
        day = DateTime(day.year, day.month, day.day + 1)
      )
        day,
    ],
  };

  ReportRange _shifted(int steps) => switch (period) {
    ReportPeriod.day => ReportRange(
      period: period,
      start: DateTime(start.year, start.month, start.day + steps),
      end: DateTime(start.year, start.month, start.day + steps + 1),
    ),
    ReportPeriod.week => ReportRange(
      period: period,
      start: DateTime(start.year, start.month, start.day + 7 * steps),
      end: DateTime(start.year, start.month, start.day + 7 * steps + 7),
    ),
    ReportPeriod.month => ReportRange(
      period: period,
      start: DateTime(start.year, start.month + steps),
      end: DateTime(start.year, start.month + steps + 1),
    ),
  };
}

/// Time tracked in a [ReportRange], per bucket and per project. An entry
/// that spans buckets (e.g. 09:30–11:15 by hour) is split across them; the
/// running entry counts up to `now`.
@freezed
abstract class PeriodReport with _$PeriodReport {
  const PeriodReport._();

  const factory PeriodReport({
    required List<Duration> buckets,

    /// Keyed by project id; null holds entries without a project.
    required Map<int?, Duration> byProject,
  }) = _PeriodReport;

  /// [until] cuts the range short, to compare "so far" with a past period.
  factory PeriodReport.of({
    required ReportRange range,
    required Iterable<TimeEntry> entries,
    required DateTime now,
    DateTime? until,
  }) {
    final bucketStarts = range.buckets;
    final buckets = List.filled(bucketStarts.length, Duration.zero);
    final byProject = <int?, Duration>{};
    final cutoff = until != null && until.isBefore(range.end)
        ? until
        : range.end;

    for (final entry in entries) {
      final start = _later(entry.startAt, range.start);
      final end = _earlier(entry.endAt ?? now, cutoff);
      if (!end.isAfter(start)) continue;

      byProject.update(
        entry.projectId,
        (total) => total + end.difference(start),
        ifAbsent: () => end.difference(start),
      );
      for (var i = 0; i < bucketStarts.length; i++) {
        final bucketEnd = i + 1 < bucketStarts.length
            ? bucketStarts[i + 1]
            : range.end;
        final overlapStart = _later(start, bucketStarts[i]);
        final overlapEnd = _earlier(end, bucketEnd);
        if (overlapEnd.isAfter(overlapStart)) {
          buckets[i] += overlapEnd.difference(overlapStart);
        }
      }
    }
    return PeriodReport(buckets: buckets, byProject: byProject);
  }

  Duration get total =>
      buckets.fold(Duration.zero, (total, bucket) => total + bucket);

  /// Projects (null: no project) with tracked time, longest first.
  List<MapEntry<int?, Duration>> get projectsByTime =>
      [...byProject.entries.where((e) => e.value > Duration.zero)]
        ..sort((a, b) => b.value.compareTo(a.value));

  static DateTime _later(DateTime a, DateTime b) => a.isAfter(b) ? a : b;
  static DateTime _earlier(DateTime a, DateTime b) => a.isBefore(b) ? a : b;
}
