import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

enum TempoLogoShape {
  /// Rounded square with the glyph: in-app, favicon, web icons, splash.
  rounded,

  /// Edge-to-edge square, glyph inside the safe zone: maskable web icons,
  /// which the OS crops to its own shape.
  fullBleed,

  /// White glyph on transparent: Android 12+ splash (the OS draws the
  /// circle behind it).
  glyph,
}

/// The Tempo mark: a white stopwatch on brand blue. Uses fixed brand colours
/// (not the theme) so it looks the same everywhere, including the generated
/// icons in `tool/generate_brand_assets.dart`.
class TempoLogo extends StatelessWidget {
  const TempoLogo({
    super.key,
    this.size = 32,
    this.shape = TempoLogoShape.rounded,
  });

  final double size;
  final TempoLogoShape shape;

  @override
  Widget build(BuildContext context) {
    final glyphScale = switch (shape) {
      TempoLogoShape.rounded => 0.72,
      // Maskable icons keep content inside the central 80% circle.
      TempoLogoShape.fullBleed => 0.5,
      TempoLogoShape.glyph => 1.0,
    };
    final glyph = Icon(
      Icons.timer_outlined,
      size: size * glyphScale,
      color: Colors.white,
    );

    return SizedBox.square(
      dimension: size,
      child: switch (shape) {
        TempoLogoShape.glyph => Center(child: glyph),
        _ => DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: shape == TempoLogoShape.rounded
                ? BorderRadius.circular(size * 0.25)
                : null,
          ),
          child: Center(child: glyph),
        ),
      },
    );
  }
}
