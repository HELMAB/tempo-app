import 'package:flutter/material.dart';

import '../../../../domain/use_cases/daily_progress.dart';
import '../../../core/formatters/duration_format.dart';
import '../../../core/localization.dart';

class TrackedCard extends StatelessWidget {
  const TrackedCard({super.key, required this.progress});

  final DailyProgress progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final percent = (progress.goalFraction * 100).round();
    final l10n = context.l10n;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.trackedToday,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            // Side by side when both fit; otherwise the goal moves under the
            // total instead of breaking mid-phrase (Khmer totals are wider).
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.end,
                spacing: 12,
                children: [
                  Text(
                    formatHoursMinutes(progress.tracked, l10n),
                    style: theme.textTheme.displaySmall,
                  ),
                  if (progress.goal > Duration.zero)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        l10n.goalProgress(
                          percent,
                          formatGoal(progress.goal, l10n),
                        ),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors.primary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress.goalFraction.clamp(0, 1),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
              backgroundColor: colors.primaryContainer,
            ),
          ],
        ),
      ),
    );
  }
}
