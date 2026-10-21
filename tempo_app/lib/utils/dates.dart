/// Local midnight of [time].
DateTime startOfDay(DateTime time) => DateTime(time.year, time.month, time.day);

/// Local midnight of the first day of [time]'s week, where weeks start on
/// [weekStartsOn] ([DateTime.monday] .. [DateTime.sunday]).
DateTime startOfWeek(DateTime time, {required int weekStartsOn}) {
  final day = startOfDay(time);
  final daysIntoWeek = (day.weekday - weekStartsOn) % 7;
  return DateTime(day.year, day.month, day.day - daysIntoWeek);
}
