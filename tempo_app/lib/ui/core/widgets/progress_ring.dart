import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../themes/app_motion.dart';

/// Circular progress ring used by Onboarding and the running timer.
/// Starts at 12 o'clock and fills clockwise with rounded caps. It sweeps in
/// from empty and glides to each new [progress] over [duration].
class ProgressRing extends StatelessWidget {
  const ProgressRing({
    super.key,
    required this.progress,
    this.strokeWidth = 28,
    this.duration = AppMotion.extraLong,
    this.curve = AppMotion.enter,
    this.child,
  });

  /// 0..1; values above 1 draw a full ring.
  final double progress;
  final double strokeWidth;

  /// The running timer passes one second, linear, so the ring moves
  /// continuously between its once-a-second updates.
  final Duration duration;
  final Curve curve;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AspectRatio(
      aspectRatio: 1,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: progress.clamp(0, 1)),
        duration: AppMotion.of(context, duration),
        curve: curve,
        builder: (context, value, child) => CustomPaint(
          painter: _RingPainter(
            progress: value,
            strokeWidth: strokeWidth,
            trackColor: colors.primaryContainer,
            color: colors.primary,
          ),
          child: child,
        ),
        child: Padding(
          padding: EdgeInsets.all(strokeWidth * 1.5),
          // Shrinks the label when the ring is squeezed on short screens.
          child: FittedBox(fit: BoxFit.scaleDown, child: child),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.trackColor,
    required this.color,
  });

  final double progress;
  final double strokeWidth;
  final Color trackColor;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(strokeWidth / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, 0, math.pi * 2, false, paint..color = trackColor);
    if (progress > 0) {
      canvas.drawArc(
        rect,
        -math.pi / 2,
        math.pi * 2 * progress,
        false,
        paint..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress ||
      old.strokeWidth != strokeWidth ||
      old.trackColor != trackColor ||
      old.color != color;
}
