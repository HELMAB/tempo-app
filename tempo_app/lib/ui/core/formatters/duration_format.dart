import '../../../l10n/app_localizations.dart';

/// `5h 42m`, `5h 05m`, `48m` — totals.
String formatHoursMinutes(Duration duration, AppLocalizations l10n) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  if (hours == 0) return l10n.durationMinutes(minutes);
  return l10n.durationHoursMinutes(hours, minutes.toString().padLeft(2, '0'));
}

/// `8h`, `2h 30m`, `45m` — goals, which are usually whole hours.
String formatGoal(Duration duration, AppLocalizations l10n) =>
    duration.inMinutes.remainder(60) == 0 && duration.inHours > 0
    ? l10n.durationHours(duration.inHours)
    : formatHoursMinutes(duration, l10n);

/// `4h30`, `0h48` — labels above chart bars.
String formatCompact(Duration duration, AppLocalizations l10n) =>
    l10n.durationCompact(
      duration.inHours,
      duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
    );

/// `+3h 20m` / `−1h 05m` — change against another period.
String formatSignedHoursMinutes(Duration duration, AppLocalizations l10n) =>
    '${duration.isNegative ? '\u2212' : '+'}'
    '${formatHoursMinutes(duration.abs(), l10n)}';

/// `1:12:48`, `0:30:00` — running timer and entry rows. Same in every
/// language.
String formatClock(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$hours:$minutes:$seconds';
}
