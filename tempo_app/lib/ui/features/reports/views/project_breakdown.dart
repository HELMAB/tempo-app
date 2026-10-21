import 'package:flutter/material.dart';

import '../../../../domain/models/project.dart';
import '../../../../domain/use_cases/period_report.dart';
import '../../../core/formatters/duration_format.dart';
import '../../../core/localization.dart';
import '../../../core/widgets/motion.dart';
import '../../../core/widgets/project_chip.dart';

/// Stacked bar of time per project, then one row per project.
class ProjectBreakdown extends StatelessWidget {
  const ProjectBreakdown({
    super.key,
    required this.report,
    required this.projectsById,
  });

  final PeriodReport report;
  final Map<int, Project> projectsById;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final l10n = context.l10n;
    final rows = report.projectsByTime;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.reportsByProject, style: theme.textTheme.titleMedium),
            const SizedBox(height: 16),
            if (rows.isEmpty)
              Text(
                l10n.reportsEmpty,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              )
            else ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: SizedBox(
                  height: 10,
                  child: Row(
                    children: [
                      for (final (index, MapEntry(key: id, value: time))
                          in rows.indexed)
                        Expanded(
                          flex: time.inSeconds,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: index == 0 ? 0 : 1.5,
                              right: index == rows.length - 1 ? 0 : 1.5,
                            ),
                            // A childless ColoredBox has no size.
                            child: ColoredBox(
                              color: _colour(id, colors),
                              child: const SizedBox.expand(),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              for (final (index, MapEntry(key: id, value: time))
                  in rows.indexed)
                FadeSlideIn(
                  key: ValueKey(id),
                  index: index,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        ProjectDot(project: projectsById[id], size: 12),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            projectsById[id]?.name ?? l10n.noProject,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        Text(
                          formatHoursMinutes(time, l10n),
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Color _colour(int? projectId, ColorScheme colors) =>
      switch (projectsById[projectId]) {
        final project? => Color(project.color),
        null => colors.outline,
      };
}
