import 'package:flutter/material.dart';

/// Colour tokens from the Flutter handoff (prototype/Flutter handoff.png).
abstract final class AppColors {
  static const primary = Color(0xFF2B50E6);
  static const onPrimaryContainer = Color(0xFF1E3CB8);
  static const primaryContainer = Color(0xFFE8EDFD);
  static const surfaceContainerLow = Color(0xFFF5F6F8);
  static const surface = Color(0xFFFFFFFF);
  static const onSurface = Color(0xFF111318);
  static const onSurfaceVariant = Color(0xFF5F6672);
  static const outlineVariant = Color(0xFFE2E5EA);
  static const error = Color(0xFFC62845);

  /// Positive change, e.g. "+3h 20m vs last week".
  static const success = Color(0xFF1E7B3A);

  /// Swatches offered in the "New project" sheet, in display order.
  static const projectPalette = <Color>[
    Color(0xFF2B50E6),
    Color(0xFFE8772E),
    Color(0xFF0E9C8A),
    Color(0xFF8B55DB),
    Color(0xFFDB4874),
    Color(0xFFC48A00),
    Color(0xFF3B8E2F),
    Color(0xFF5F6672),
  ];
}
