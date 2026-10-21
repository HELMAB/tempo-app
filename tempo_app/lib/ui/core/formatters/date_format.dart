import 'package:intl/intl.dart';

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
