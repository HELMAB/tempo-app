import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/dependencies.dart';

/// Rebuilds once a second while [ticking], so running durations stay live.
/// Durations are derived from `startAt`, so nothing is stored per tick.
class ClockBuilder extends ConsumerStatefulWidget {
  const ClockBuilder({super.key, required this.ticking, required this.builder});

  final bool ticking;
  final Widget Function(BuildContext context, DateTime now) builder;

  @override
  ConsumerState<ClockBuilder> createState() => _ClockBuilderState();
}

class _ClockBuilderState extends ConsumerState<ClockBuilder> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _sync();
  }

  @override
  void didUpdateWidget(ClockBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.ticking != widget.ticking) _sync();
  }

  void _sync() {
    _timer?.cancel();
    _timer = widget.ticking
        ? Timer.periodic(const Duration(seconds: 1), (_) => setState(() {}))
        : null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, ref.read(clockProvider)());
}
