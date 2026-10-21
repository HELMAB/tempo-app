import 'package:flutter/material.dart';

/// Motion tokens (Material 3 durations and easing). Use [of] for any
/// duration so the OS "reduce motion" setting turns animations off.
abstract final class AppMotion {
  static const short = Duration(milliseconds: 150);
  static const medium = Duration(milliseconds: 300);
  static const long = Duration(milliseconds: 500);
  static const extraLong = Duration(milliseconds: 800);

  /// Things entering the screen.
  static const enter = Easing.emphasizedDecelerate;

  /// Things leaving the screen.
  static const exit = Easing.emphasizedAccelerate;

  /// On-screen changes (a pill sliding, a bar resizing).
  static const move = Easing.standard;

  static bool reduced(BuildContext context) =>
      MediaQuery.maybeDisableAnimationsOf(context) ?? false;

  /// [duration], or zero when the user asked the OS to reduce motion.
  static Duration of(BuildContext context, Duration duration) =>
      reduced(context) ? Duration.zero : duration;
}
