import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_entry.freezed.dart';

@freezed
abstract class TimeEntry with _$TimeEntry {
  const TimeEntry._();

  const factory TimeEntry({
    required int id,
    int? projectId,
    @Default('') String description,
    required DateTime startAt,

    /// Null while the timer is running.
    DateTime? endAt,
    @Default(<String>[]) List<String> tags,
    @Default('') String note,
  }) = _TimeEntry;

  bool get isRunning => endAt == null;

  /// Elapsed time is always derived from [startAt], never stored, so a
  /// running timer survives the app being closed.
  Duration durationAt(DateTime now) => (endAt ?? now).difference(startAt);
}
