import 'package:flutter/material.dart';

import '../themes/app_motion.dart';

/// Grey track with a white pill that slides to the selected option, as in
/// the prototype's "This week | All time" and "Day | Week | Month".
class PillSegmentedControl<T> extends StatelessWidget {
  const PillSegmentedControl({
    super.key,
    required this.segments,
    required this.selected,
    required this.onChanged,
  });

  final List<({T value, String label})> segments;
  final T selected;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final selectedIndex = segments.indexWhere((s) => s.value == selected);
    final duration = AppMotion.of(context, AppMotion.medium);

    return DecoratedBox(
      decoration: ShapeDecoration(
        color: colors.outlineVariant.withValues(alpha: 0.6),
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Stack(
          children: [
            // The sliding pill, one segment wide.
            Positioned.fill(
              child: AnimatedAlign(
                duration: duration,
                curve: AppMotion.move,
                alignment: Alignment(
                  segments.length == 1
                      ? 0
                      : -1 + 2 * selectedIndex / (segments.length - 1),
                  0,
                ),
                child: FractionallySizedBox(
                  widthFactor: 1 / segments.length,
                  heightFactor: 1,
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                      color: colors.surface,
                      shape: const StadiumBorder(),
                      shadows: [
                        BoxShadow(
                          color: colors.shadow.withValues(alpha: 0.08),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                for (final segment in segments)
                  Expanded(
                    child: _Segment(
                      label: segment.label,
                      selected: segment.value == selected,
                      duration: duration,
                      onTap: () => onChanged(segment.value),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.selected,
    required this.duration,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final Duration duration;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: selected ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: AnimatedDefaultTextStyle(
            duration: duration,
            style: theme.textTheme.bodyLarge!.copyWith(
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected ? colors.onSurface : colors.onSurfaceVariant,
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
