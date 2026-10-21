import 'package:flutter/material.dart';

import '../../../domain/models/project.dart';
import '../localization.dart';

class ProjectDot extends StatelessWidget {
  const ProjectDot({super.key, required this.project, this.size = 10});

  final Project? project;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = switch (project) {
      final project? => Color(project.color),
      null => Theme.of(context).colorScheme.outline,
    };
    return DecoratedBox(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: SizedBox.square(dimension: size),
    );
  }
}

/// Pill showing the project's dot and name; null shows "No project".
class ProjectChip extends StatelessWidget {
  const ProjectChip({
    super.key,
    required this.project,
    this.onPressed,
    this.outlined = false,
    this.showDropdown = false,
  });

  final Project? project;
  final VoidCallback? onPressed;

  /// Outlined on white (timer); filled grey on cards (Today).
  final bool outlined;
  final bool showDropdown;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Material(
      color: outlined ? colors.surface : colors.surfaceContainerLow,
      shape: StadiumBorder(
        side: outlined
            ? BorderSide(color: colors.outlineVariant)
            : BorderSide.none,
      ),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ProjectDot(project: project),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  project?.name ?? context.l10n.noProject,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ),
              if (showDropdown) ...[
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: colors.onSurfaceVariant,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
