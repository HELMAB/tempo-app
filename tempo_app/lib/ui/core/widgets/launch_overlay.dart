import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import '../themes/app_motion.dart';

/// Continues the native splash (flutter_native_splash.yaml) in Flutter and
/// animates into the app once per launch: a ring sweeps around the
/// stopwatch, then the blue opens from the centre to reveal [child].
///
/// The first frame matches the native splash exactly (same colour, white
/// glyph at [glyphSize] in the centre), so the hand-over is invisible.
class LaunchOverlay extends StatefulWidget {
  const LaunchOverlay({super.key, required this.child});

  final Widget child;

  /// Same as the splash images (384 px at 4x).
  static const glyphSize = 96.0;
  static const duration = Duration(milliseconds: 1300);

  @override
  State<LaunchOverlay> createState() => _LaunchOverlayState();
}

class _LaunchOverlayState extends State<LaunchOverlay>
    with SingleTickerProviderStateMixin {
  // Created up front (not `late`): with reduce motion they're never used,
  // and dispose() must not be the first thing to create them.
  late final AnimationController _controller;
  late final CurvedAnimation _ring;
  late final CurvedAnimation _pulse;
  late final CurvedAnimation _reveal;
  late final CurvedAnimation _logoOut;
  bool _started = false;
  bool _done = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: LaunchOverlay.duration,
    );
    CurvedAnimation curve(
      double begin,
      double end, [
      Curve curve = Curves.linear,
    ]) => CurvedAnimation(
      parent: _controller,
      curve: Interval(begin, end, curve: curve),
    );
    // Timeline: ring sweeps, glyph pulses as it closes, the logo lifts
    // away, then the reveal. The logo is gone before the hole reaches it,
    // or the app would show through the glyph.
    _ring = curve(0.05, 0.5, Curves.easeInOutCubic);
    _pulse = curve(0.42, 0.56);
    _logoOut = curve(0.52, 0.68, AppMotion.exit);
    _reveal = curve(0.64, 1, AppMotion.exit);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    if (AppMotion.reduced(context)) {
      _done = true;
      return;
    }
    _controller.forward().whenComplete(() {
      if (mounted) setState(() => _done = true);
    });
  }

  @override
  void dispose() {
    for (final animation in [_ring, _pulse, _reveal, _logoOut]) {
      animation.dispose();
    }
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_done) return widget.child;
    final dark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    final colour = dark ? AppColors.splashDark : AppColors.splash;

    return Stack(
      textDirection: TextDirection.ltr,
      children: [
        widget.child,
        Positioned.fill(
          child: AbsorbPointer(
            child: ExcludeSemantics(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final pulse = 1 + 0.08 * math.sin(math.pi * _pulse.value);
                  return CustomPaint(
                    painter: _RevealPainter(
                      colour: colour,
                      reveal: _reveal.value,
                    ),
                    child: Center(
                      child: Opacity(
                        opacity: 1 - _logoOut.value,
                        child: Transform.scale(
                          scale: pulse + 0.25 * _logoOut.value,
                          child: CustomPaint(
                            painter: _RingPainter(sweep: _ring.value),
                            child: const Padding(
                              padding: EdgeInsets.all(28),
                              child: Icon(
                                Icons.timer_outlined,
                                size: LaunchOverlay.glyphSize,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// The splash colour with a transparent hole growing from the centre.
class _RevealPainter extends CustomPainter {
  const _RevealPainter({required this.colour, required this.reveal});

  final Color colour;

  /// 0: solid; 1: the hole covers the whole screen.
  final double reveal;

  @override
  void paint(Canvas canvas, Size size) {
    final centre = size.center(Offset.zero);
    final radius = reveal * size.longestSide;
    final path = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(Offset.zero & size);
    if (radius > 0) {
      path.addOval(Rect.fromCircle(center: centre, radius: radius));
    }
    canvas.drawPath(path, Paint()..color = colour);
  }

  @override
  bool shouldRepaint(_RevealPainter old) =>
      old.reveal != reveal || old.colour != colour;
}

/// A white arc around the glyph, drawn clockwise from 12 o'clock.
class _RingPainter extends CustomPainter {
  const _RingPainter({required this.sweep});

  final double sweep;

  @override
  void paint(Canvas canvas, Size size) {
    if (sweep <= 0) return;
    const stroke = 5.0;
    final rect = (Offset.zero & size).deflate(stroke / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = Colors.white.withValues(alpha: 0.9);
    canvas.drawArc(rect, -math.pi / 2, 2 * math.pi * sweep, false, paint);
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.sweep != sweep;
}
