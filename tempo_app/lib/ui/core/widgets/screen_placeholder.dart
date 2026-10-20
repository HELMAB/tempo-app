import 'package:flutter/material.dart';

/// Temporary body for screens that are routed but not built yet.
/// Delete once every screen in the build order is implemented.
class ScreenPlaceholder extends StatelessWidget {
  const ScreenPlaceholder({
    super.key,
    required this.title,
    required this.prototype,
    this.actions = const [],
  });

  final String title;

  /// File name of the matching screen in `prototype/`.
  final String prototype;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(
              'Not built yet · see prototype/$prototype',
              style: textTheme.bodySmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            for (final action in actions) ...[
              action,
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}
