import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../routing/router.dart';
import '../../../core/formatters/date_format.dart';
import '../../../core/formatters/duration_format.dart';
import '../../../core/localization.dart';
import '../view_models/idle_view_model.dart';

/// Watches the app lifecycle and, when the user returns after a long
/// absence with a timer running, asks whether to keep that time.
class IdleWatcher extends ConsumerStatefulWidget {
  const IdleWatcher({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<IdleWatcher> createState() => _IdleWatcherState();
}

class _IdleWatcherState extends ConsumerState<IdleWatcher> {
  late final AppLifecycleListener _listener;

  IdleViewModel get _viewModel => ref.read(idleViewModelProvider.notifier);

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onHide: _viewModel.appHidden,
      onShow: _onShow,
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  Future<void> _onShow() async {
    final review = _viewModel.appResumed();
    // The watcher sits above the Navigator, so use the router's context.
    final context = ref
        .read(routerProvider)
        .routerDelegate
        .navigatorKey
        .currentContext;
    if (review == null || context == null) return;

    final l10n = context.l10n;
    final discard = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.idleTitle(formatHoursMinutes(review.away, l10n))),
        content: Text(l10n.idleBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.idleStopAt(formatTimeOfDay(review.leftAt, l10n))),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.idleKeep),
          ),
        ],
      ),
    );
    if (discard ?? false) await _viewModel.discardAwayTime(review);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
