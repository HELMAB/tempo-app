import 'package:flutter/material.dart';

/// Lets go_router show a route as a `showModalBottomSheet`-style sheet, so
/// sheets such as `/projects/new` are addressable like any other route.
class ModalBottomSheetPage<T> extends Page<T> {
  const ModalBottomSheetPage({super.key, required this.child});

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) => ModalBottomSheetRoute<T>(
    settings: this,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => child,
  );
}
