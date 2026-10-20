import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/ui/core/formatters/duration_format.dart';

void main() {
  test('formatHoursMinutes', () {
    expect(formatHoursMinutes(const Duration(hours: 5, minutes: 42)), '5h 42m');
    expect(formatHoursMinutes(const Duration(hours: 5, minutes: 5)), '5h 05m');
    expect(formatHoursMinutes(const Duration(minutes: 48)), '48m');
    expect(formatHoursMinutes(Duration.zero), '0m');
  });

  test('formatClock', () {
    expect(
      formatClock(const Duration(hours: 1, minutes: 12, seconds: 48)),
      '1:12:48',
    );
    expect(formatClock(const Duration(minutes: 30)), '0:30:00');
  });
}
