import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/models/project.dart';
import '../../../../domain/models/time_entry.dart';
import '../../../../domain/use_cases/period_report.dart';

part 'reports_ui_state.freezed.dart';

@freezed
abstract class ReportsUiState with _$ReportsUiState {
  const ReportsUiState._();

  const factory ReportsUiState({
    required ReportRange range,
    required List<TimeEntry> entries,

    /// Entries of the period before [range], for the comparison chip.
    required List<TimeEntry> previousEntries,
    required Map<int, Project> projectsById,
  }) = _ReportsUiState;

  bool get hasRunningEntry => entries.any((e) => e.isRunning);

  bool isCurrentAt(DateTime now) => range.contains(now);

  /// The next period can only be opened once it has started.
  bool canShowNextAt(DateTime now) => !range.next.start.isAfter(now);

  PeriodReport reportAt(DateTime now) =>
      PeriodReport.of(range: range, entries: entries, now: now);

  /// The previous period's total up to the same point, so "this week so far"
  /// is compared with the same part of last week.
  Duration previousTotalAt(DateTime now) {
    final previous = range.previous;
    return PeriodReport.of(
      range: previous,
      entries: previousEntries,
      now: now,
      until: isCurrentAt(now)
          ? previous.start.add(now.difference(range.start))
          : null,
    ).total;
  }

  /// Mean per day over the days that have started; none for a single day.
  Duration? averageAt(DateTime now, PeriodReport report) {
    if (range.period == ReportPeriod.day) return null;
    final started = range.buckets.where((day) => !day.isAfter(now)).length;
    return started == 0 ? null : report.total ~/ started;
  }
}
