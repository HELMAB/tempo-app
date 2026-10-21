import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Material 3 theme from the Flutter handoff: Manrope type scale,
/// 8 px grid, radii 12 (fields) / 20 (cards) / 28 (sheets) / full (buttons).
abstract final class AppTheme {
  static const fieldRadius = 12.0;
  static const cardRadius = 20.0;
  static const sheetRadius = 28.0;

  /// Declared in pubspec.yaml, bundled from assets/fonts.
  static const fontFamily = 'Manrope';

  static ThemeData get light => _build(
    ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      primaryContainer: AppColors.primaryContainer,
      surface: AppColors.surface,
      surfaceContainerLow: AppColors.surfaceContainerLow,
      onSurface: AppColors.onSurface,
      onSurfaceVariant: AppColors.onSurfaceVariant,
      outlineVariant: AppColors.outlineVariant,
      error: AppColors.error,
    ),
  );

  /// Not designed yet; derived from the same seed until it is.
  static ThemeData get dark => _build(
    ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),
  );

  static ThemeData _build(ColorScheme scheme) {
    final textTheme = _textTheme(scheme);
    const stadium = StadiumBorder();

    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surfaceContainerLow,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleMedium,
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: stadium,
          minimumSize: const Size.fromHeight(56),
          textStyle: textTheme.titleMedium,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(shape: stadium),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(fieldRadius),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(fieldRadius),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(fieldRadius),
          borderSide: BorderSide(color: scheme.primary),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: stadium,
        side: BorderSide(color: scheme.outlineVariant),
        selectedColor: scheme.primaryContainer,
        labelStyle: textTheme.bodyMedium,
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          shape: stadium,
          selectedBackgroundColor: scheme.surface,
          backgroundColor: scheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(sheetRadius),
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primaryContainer,
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStatePropertyAll(textTheme.labelLarge),
      ),
      dividerTheme: DividerThemeData(color: scheme.outlineVariant, space: 1),
    );
  }

  static TextTheme _textTheme(ColorScheme scheme) {
    final base = ThemeData(
      brightness: scheme.brightness,
      fontFamily: fontFamily,
    ).textTheme;
    TextStyle style(
      TextStyle? from,
      double size,
      double lineHeight,
      FontWeight weight,
    ) => from!.copyWith(
      fontSize: size,
      height: lineHeight / size,
      fontWeight: weight,
      letterSpacing: 0,
    );

    return base
        .copyWith(
          // 1:12:48 — running timer.
          displayLarge: style(
            base.displayLarge,
            56,
            64,
            FontWeight.w800,
          ).copyWith(fontFeatures: const [FontFeature.tabularFigures()]),
          // 5h 42m — totals.
          displaySmall: style(base.displaySmall, 34, 40, FontWeight.w800),
          // Today — screen titles.
          headlineMedium: style(base.headlineMedium, 28, 36, FontWeight.w800),
          // Entries — section titles.
          titleMedium: style(base.titleMedium, 17, 24, FontWeight.w700),
          // Build timer screen — list titles.
          bodyLarge: style(base.bodyLarge, 15, 22, FontWeight.w700),
          // Flutter course · 09:00–10:45 — metadata.
          bodySmall: style(base.bodySmall, 13, 18, FontWeight.w500),
          // REMINDERS — group labels.
          labelMedium: style(
            base.labelMedium,
            12,
            16,
            FontWeight.w700,
          ).copyWith(letterSpacing: 0.8),
        )
        .apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);
  }
}
