import 'package:freezed_annotation/freezed_annotation.dart';

part 'project.freezed.dart';

@freezed
abstract class Project with _$Project {
  const factory Project({
    required int id,
    required String name,

    /// ARGB colour value; see `projectPalette` in the UI theme.
    required int color,
    @Default(0) int weeklyGoalMinutes,
    @Default(true) bool countsTowardDailyGoal,
    @Default(false) bool archived,
  }) = _Project;
}
