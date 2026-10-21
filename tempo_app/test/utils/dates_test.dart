import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/utils/dates.dart';

void main() {
  // Tuesday 20 October 2026, mid-afternoon.
  final tuesday = DateTime(2026, 10, 20, 15, 30);

  test('startOfWeek honours the configured first day', () {
    expect(
      startOfWeek(tuesday, weekStartsOn: DateTime.monday),
      DateTime(2026, 10, 19),
    );
    expect(
      startOfWeek(tuesday, weekStartsOn: DateTime.sunday),
      DateTime(2026, 10, 18),
    );
    expect(
      startOfWeek(tuesday, weekStartsOn: DateTime.tuesday),
      DateTime(2026, 10, 20),
    );
    expect(
      startOfWeek(tuesday, weekStartsOn: DateTime.wednesday),
      DateTime(2026, 10, 14),
    );
  });

  test('startOfWeek crosses month boundaries', () {
    expect(
      startOfWeek(DateTime(2026, 11, 1), weekStartsOn: DateTime.monday),
      DateTime(2026, 10, 26),
    );
  });
}
