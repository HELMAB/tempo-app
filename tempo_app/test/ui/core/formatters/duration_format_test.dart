import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/l10n/app_localizations.dart';
import 'package:tempo_app/ui/core/formatters/duration_format.dart';

void main() {
  final en = lookupAppLocalizations(const Locale('en'));
  final km = lookupAppLocalizations(const Locale('km'));

  test('formatHoursMinutes', () {
    expect(
      formatHoursMinutes(const Duration(hours: 5, minutes: 42), en),
      '5h 42m',
    );
    expect(
      formatHoursMinutes(const Duration(hours: 5, minutes: 5), en),
      '5h 05m',
    );
    expect(formatHoursMinutes(const Duration(minutes: 48), en), '48m');
    expect(formatHoursMinutes(Duration.zero, en), '0m');
    expect(
      formatHoursMinutes(const Duration(hours: 5, minutes: 42), km),
      '5 ម៉ោង 42 នាទី',
    );
  });

  test('formatGoal drops minutes for whole hours', () {
    expect(formatGoal(const Duration(hours: 8), en), '8h');
    expect(formatGoal(const Duration(hours: 2, minutes: 30), en), '2h 30m');
    expect(formatGoal(const Duration(hours: 8), km), '8 ម៉ោង');
  });

  test('formatClock', () {
    expect(
      formatClock(const Duration(hours: 1, minutes: 12, seconds: 48)),
      '1:12:48',
    );
    expect(formatClock(const Duration(minutes: 30)), '0:30:00');
  });
}
