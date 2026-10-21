import 'package:intl/intl.dart';

import '../../../domain/use_cases/period_report.dart';
import '../../../l10n/app_localizations.dart';

/// `17:02`
String formatTimeOfDay(DateTime time, AppLocalizations l10n) =>
    DateFormat('HH:mm', l10n.localeName).format(time);

/// `09:00–10:45`, or `17:02–now` while running.
String formatTimeRange(DateTime start, DateTime? end, AppLocalizations l10n) =>
    '${formatTimeOfDay(start, l10n)}–'
    '${end == null ? l10n.timeNow : formatTimeOfDay(end, l10n)}';

/// `Tuesday, 20 October` / `អង្គារ, 20 តុលា`
String formatDayHeading(DateTime day, AppLocalizations l10n) =>
    DateFormat('EEEE, d MMMM', l10n.localeName).format(day);

/// `Tue, 20 Oct 2026`
String formatDate(DateTime day, AppLocalizations l10n) =>
    DateFormat('EEE, d MMM y', l10n.localeName).format(day);

/// `Tue, 20 Oct` · `14 – 20 Oct` · `28 Sep – 4 Oct` · `October 2026`
String formatReportRange(ReportRange range, AppLocalizations l10n) {
  final locale = l10n.localeName;
  final start = range.start;
  final last = DateTime(range.end.year, range.end.month, range.end.day - 1);
  return switch (range.period) {
    ReportPeriod.day => DateFormat('EEE, d MMM', locale).format(start),
    ReportPeriod.month => DateFormat('MMMM y', locale).format(start),
    ReportPeriod.week when start.year != last.year =>
      '${DateFormat('d MMM y', locale).format(start)} – '
          '${DateFormat('d MMM y', locale).format(last)}',
    ReportPeriod.week when start.month != last.month =>
      '${DateFormat('d MMM', locale).format(start)} – '
          '${DateFormat('d MMM', locale).format(last)}',
    ReportPeriod.week =>
      '${DateFormat('d', locale).format(start)} – '
          '${DateFormat('d MMM', locale).format(last)}',
  };
}
