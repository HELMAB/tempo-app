import 'package:flutter/material.dart';

/// "−  5h · about 43m a day  +" stepper used for weekly and daily goals.
class GoalStepper extends StatelessWidget {
  const GoalStepper({
    super.key,
    required this.value,
    this.caption,
    required this.decreaseTooltip,
    required this.increaseTooltip,
    required this.onDecrease,
    required this.onIncrease,
  });

  final String value;
  final String? caption;
  final String decreaseTooltip;
  final String increaseTooltip;

  /// Null disables the button (at the lower / upper bound).
  final VoidCallback? onDecrease;
  final VoidCallback? onIncrease;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            _StepButton(
              icon: Icons.remove,
              tooltip: decreaseTooltip,
              onPressed: onDecrease,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    value,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (caption case final caption?)
                    Text(
                      caption,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
            _StepButton(
              icon: Icons.add,
              tooltip: increaseTooltip,
              onPressed: onIncrease,
            ),
          ],
        ),
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return IconButton.filled(
      tooltip: tooltip,
      style: IconButton.styleFrom(
        minimumSize: const Size.square(52),
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
      ),
      onPressed: onPressed,
      icon: Icon(icon),
    );
  }
}
