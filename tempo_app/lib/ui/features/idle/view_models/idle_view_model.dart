import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/dependencies.dart';

/// What to ask the user after they come back.
typedef IdleReview = ({DateTime leftAt, Duration away});

final idleViewModelProvider = NotifierProvider<IdleViewModel, DateTime?>(
  IdleViewModel.new,
);

/// Idle detection: state is when the user left the app while a timer was
/// running (null while they are here).
class IdleViewModel extends Notifier<DateTime?> {
  static const threshold = Duration(minutes: 10);

  @override
  DateTime? build() => null;

  void appHidden() {
    final running = ref.read(runningEntryProvider).value;
    if (running != null) state ??= ref.read(clockProvider)();
  }

  /// A review when the user was away at least [threshold] with the timer
  /// still running and idle detection on; null otherwise.
  IdleReview? appResumed() {
    final leftAt = state;
    state = null;
    if (leftAt == null) return null;
    if (!ref.read(settingsRepositoryProvider).current.idleDetection) {
      return null;
    }
    final running = ref.read(runningEntryProvider).value;
    if (running == null || running.startAt.isAfter(leftAt)) return null;
    final away = ref.read(clockProvider)().difference(leftAt);
    return away < threshold ? null : (leftAt: leftAt, away: away);
  }

  /// Stops the timer at the moment the user left.
  Future<void> discardAwayTime(IdleReview review) =>
      ref.read(timeEntryRepositoryProvider).stopTimer(at: review.leftAt);
}
