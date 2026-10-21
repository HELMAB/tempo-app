import 'dart:async';

import 'package:flutter/services.dart';

/// Light haptic cues for timer actions. Fire-and-forget: a platform
/// without haptics (or a test) must never delay or break the action.
abstract final class Haptics {
  /// A timer started.
  static void start() => _fire(HapticFeedback.mediumImpact);

  /// A timer stopped or was saved.
  static void stop() => _fire(HapticFeedback.lightImpact);

  /// Pause / resume.
  static void toggle() => _fire(HapticFeedback.selectionClick);

  static void _fire(Future<void> Function() feedback) {
    unawaited(feedback().catchError((Object _) {}));
  }
}
