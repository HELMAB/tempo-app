import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Material 3 theme from the Flutter handoff: type scale, 8 px grid,
/// radii 12 (fields) / 20 (cards) / 28 (sheets) / full (buttons).
///
/// Typeface is Google Sans (covers Latin and Khmer). Its heaviest weight is
/// 700, so the handoff's 800 styles use 700. Khmer stacks vowels and
/// subscript consonants above and below the line, so [locale] `km` gets
/// taller line heights and no letter-spacing.
abstract final class AppTheme {
  static const fieldRadius = 12.0;
  static const cardRadius = 20.0;
  static const sheetRadius = 28.0;

  /// Declared in pubspec.yaml, bundled from assets/fonts.
  static const fontFamily = 'Google Sans';

  /// Line-height multiplier applied on top of the handoff scale for Khmer.
  static const _khmerLineHeightScale = 1.3;

  static ThemeData light(Locale locale) => _build(
    locale,
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
  static ThemeData dark(Locale locale) => _build(
    locale,
    ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),
  );

  static ThemeData _build(Locale locale, ColorScheme scheme) {
    final textTheme = _textTheme(locale, scheme);
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
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
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
      listTileTheme: ListTileThemeData(
        titleTextStyle: textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ),
        subtitleTextStyle: textTheme.bodySmall?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
      ),
      dividerTheme: DividerThemeData(color: scheme.outlineVariant, space: 1),
    );
  }

  static TextTheme _textTheme(Locale locale, ColorScheme scheme) {
    final khmer = locale.languageCode == 'km';
    final base = ThemeData(
      brightness: scheme.brightness,
      fontFamily: fontFamily,
    ).textTheme;
    TextStyle style(
      TextStyle? from,
      double size,
      double lineHeight,
      FontWeight weight, {
      double letterSpacing = 0,
    }) => from!.copyWith(
      fontSize: size,
      height: lineHeight / size * (khmer ? _khmerLineHeightScale : 1),
      fontWeight: weight,
      letterSpacing: khmer ? 0 : letterSpacing,
    );

    return base
        .copyWith(
          // 1:12:48 — running timer.
          displayLarge: style(
            base.displayLarge,
            56,
            64,
            FontWeight.w700,
          ).copyWith(fontFeatures: const [FontFeature.tabularFigures()]),
          // 5h 42m — totals.
          displaySmall: style(base.displaySmall, 34, 40, FontWeight.w700),
          // Today — screen titles.
          headlineMedium: style(base.headlineMedium, 28, 36, FontWeight.w700),
          // Entries — section titles.
          titleMedium: style(base.titleMedium, 17, 24, FontWeight.w700),
          // Body text and inputs. The handoff's bold list-title variant
          // (15/22 · 700) is applied through listTileTheme instead, so text
          // fields don't render bold.
          bodyLarge: style(base.bodyLarge, 15, 22, FontWeight.w500),
          // Flutter course · 09:00–10:45 — metadata.
          bodySmall: style(base.bodySmall, 13, 18, FontWeight.w500),
          // REMINDERS — group labels.
          labelMedium: style(
            base.labelMedium,
            12,
            16,
            FontWeight.w700,
            letterSpacing: 0.8,
          ),
        )
        .apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);
  }
}
