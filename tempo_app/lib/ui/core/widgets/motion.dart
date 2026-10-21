import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../themes/app_motion.dart';

/// Fades and slides [child] up into place the first time it is built.
/// [index] staggers items in a list (capped so long lists don't wait).
class FadeSlideIn extends StatefulWidget {
  const FadeSlideIn({
    super.key,
    this.index = 0,
    this.delay = Duration.zero,
    required this.child,
  });

  final int index;

  /// Extra wait before the stagger, e.g. until the launch reveal.
  final Duration delay;
  final Widget child;

  static const _stagger = Duration(milliseconds: 45);
  static const _maxStaggered = 8;

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this);
  late final _curve = CurvedAnimation(
    parent: _controller,
    curve: AppMotion.enter,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controller.isAnimating || _controller.isCompleted) return;
    if (AppMotion.reduced(context)) {
      _controller.value = 1;
      return;
    }
    final delay =
        widget.delay +
        FadeSlideIn._stagger *
            math.min(widget.index, FadeSlideIn._maxStaggered);
    _controller.duration = AppMotion.long;
    Future<void>.delayed(delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _curve.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _curve,
      child: AnimatedBuilder(
        animation: _curve,
        builder: (context, child) => Transform.translate(
          offset: Offset(0, 16 * (1 - _curve.value)),
          child: child,
        ),
        child: widget.child,
      ),
    );
  }
}

/// Text for a [Duration] that counts from its previous value (zero at
/// first) to the new one, e.g. "Tracked today" totals.
class CountUpDuration extends StatelessWidget {
  const CountUpDuration({
    super.key,
    required this.duration,
    required this.format,
    this.style,
  });

  final Duration duration;
  final String Function(Duration) format;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: duration.inSeconds.toDouble()),
      duration: AppMotion.of(context, AppMotion.extraLong),
      curve: AppMotion.enter,
      builder: (context, seconds, _) =>
          Text(format(Duration(seconds: seconds.round())), style: style),
    );
  }
}

/// A rounded progress bar that fills from 0 on first build and glides
/// between values afterwards.
class AnimatedProgressBar extends StatelessWidget {
  const AnimatedProgressBar({
    super.key,
    required this.value,
    this.color,
    this.backgroundColor,
    this.minHeight = 8,
  });

  /// 0..1; larger values are drawn as full.
  final double value;
  final Color? color;
  final Color? backgroundColor;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.clamp(0, 1)),
      duration: AppMotion.of(context, AppMotion.extraLong),
      curve: AppMotion.enter,
      builder: (context, value, _) => LinearProgressIndicator(
        value: value,
        minHeight: minHeight,
        color: color,
        backgroundColor: backgroundColor,
        borderRadius: BorderRadius.circular(minHeight / 2),
      ),
    );
  }
}

/// A status dot with a soft halo that pulses while [active].
class PulsingDot extends StatefulWidget {
  const PulsingDot({
    super.key,
    required this.color,
    required this.active,
    this.size = 10,
  });

  final Color color;
  final bool active;
  final double size;

  @override
  State<PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<PulsingDot>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sync();
  }

  @override
  void didUpdateWidget(PulsingDot oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sync();
  }

  void _sync() {
    // Never repeat forever when motion is reduced (or in widget tests,
    // which set it so pumpAndSettle can finish).
    final run = widget.active && !AppMotion.reduced(context);
    if (run && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!run && _controller.isAnimating) {
      _controller
        ..stop()
        ..value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dot = DecoratedBox(
      decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
      child: SizedBox.square(dimension: widget.size),
    );
    return SizedBox.square(
      dimension: widget.size * 2.4,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final t = Curves.easeOut.transform(_controller.value);
          return Stack(
            alignment: Alignment.center,
            children: [
              if (_controller.isAnimating)
                Opacity(
                  opacity: (1 - t) * 0.45,
                  child: Transform.scale(
                    scale: 1 + t * 1.4,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: widget.color,
                        shape: BoxShape.circle,
                      ),
                      child: SizedBox.square(dimension: widget.size),
                    ),
                  ),
                ),
              child!,
            ],
          );
        },
        child: dot,
      ),
    );
  }
}

/// Swaps [child] with a quick fade + scale when its key changes, e.g. the
/// play ↔ stop icon or Pause ↔ Resume.
class ScaleSwitcher extends StatelessWidget {
  const ScaleSwitcher({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: AppMotion.of(context, AppMotion.medium),
      switchInCurve: AppMotion.enter,
      switchOutCurve: AppMotion.exit,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween(begin: 0.6, end: 1.0).animate(animation),
          child: child,
        ),
      ),
      child: child,
    );
  }
}

/// [AnimatedSize] that steps aside when motion is reduced: with a zero
/// duration AnimatedSize re-lays itself out mid-layout and asserts.
class SmoothSize extends StatelessWidget {
  const SmoothSize({
    super.key,
    this.alignment = Alignment.center,
    required this.child,
  });

  final AlignmentGeometry alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (AppMotion.reduced(context)) return child;
    return AnimatedSize(
      duration: AppMotion.medium,
      curve: AppMotion.move,
      alignment: alignment,
      child: child,
    );
  }
}
