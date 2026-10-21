import 'package:flutter/material.dart';

import '../themes/app_motion.dart';

/// Container for the bottom-tab branch navigators: keeps every tab alive
/// (like an IndexedStack) and fades through when the tab changes. The old
/// tab fades out quickly, then the new one fades and scales in.
class FadeThroughBranches extends StatefulWidget {
  const FadeThroughBranches({
    super.key,
    required this.currentIndex,
    required this.children,
  });

  final int currentIndex;
  final List<Widget> children;

  @override
  State<FadeThroughBranches> createState() => _FadeThroughBranchesState();
}

class _FadeThroughBranchesState extends State<FadeThroughBranches>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this, value: 1);
  int? _previousIndex;

  @override
  void didUpdateWidget(FadeThroughBranches oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex == widget.currentIndex) return;
    final duration = AppMotion.of(context, AppMotion.medium);
    if (duration == Duration.zero) {
      _previousIndex = null;
      return;
    }
    _previousIndex = oldWidget.currentIndex;
    _controller
      ..duration = duration
      ..forward(from: 0).whenComplete(() {
        if (mounted) setState(() => _previousIndex = null);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fade-through: out over the first 35%, in over the rest.
    final fadeOut = ReverseAnimation(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.35, curve: AppMotion.exit),
      ),
    );
    final fadeIn = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.35, 1, curve: AppMotion.enter),
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        for (final (index, child) in widget.children.indexed)
          _Branch(
            // The same widget types every build, so branch state survives.
            key: ValueKey(index),
            visible: index == widget.currentIndex || index == _previousIndex,
            interactive: index == widget.currentIndex,
            opacity: switch (index) {
              _ when index == widget.currentIndex => fadeIn,
              _ when index == _previousIndex => fadeOut,
              _ => kAlwaysCompleteAnimation,
            },
            scale: index == widget.currentIndex
                ? Tween(begin: 0.96, end: 1.0).animate(fadeIn)
                : kAlwaysCompleteAnimation,
            child: child,
          ),
      ],
    );
  }
}

class _Branch extends StatelessWidget {
  const _Branch({
    super.key,
    required this.visible,
    required this.interactive,
    required this.opacity,
    required this.scale,
    required this.child,
  });

  final bool visible;
  final bool interactive;
  final Animation<double> opacity;
  final Animation<double> scale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !visible,
      child: TickerMode(
        enabled: visible,
        child: IgnorePointer(
          ignoring: !interactive,
          child: FadeTransition(
            opacity: opacity,
            child: ScaleTransition(scale: scale, child: child),
          ),
        ),
      ),
    );
  }
}
