import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/routes.dart';
import '../../../core/formatters/date_format.dart';
import '../../../core/formatters/duration_format.dart';
import '../../../core/localization.dart';
import '../../../core/widgets/project_chip.dart';
import '../view_models/today_ui_state.dart';
import '../view_models/today_view_model.dart';

class EntryList extends StatelessWidget {
  const EntryList({super.key, required this.entries, required this.now});

  final List<EntryWithProject> entries;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.entriesTitle,
                style: theme.textTheme.titleMedium,
              ),
            ),
            TextButton.icon(
              onPressed: () => context.push(Routes.newEntry),
              icon: const Icon(Icons.add),
              label: Text(l10n.addManually),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Card(
          clipBehavior: Clip.antiAlias,
          child: entries.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    l10n.entriesEmpty,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
              : Column(
                  children: [
                    for (final (index, item) in entries.indexed) ...[
                      if (index > 0) const Divider(),
                      _EntryTile(item: item, now: now),
                    ],
                  ],
                ),
        ),
      ],
    );
  }
}

class _EntryTile extends ConsumerWidget {
  const _EntryTile({required this.item, required this.now});

  final EntryWithProject item;
  final DateTime now;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final (:entry, :project) = item;
    final viewModel = ref.read(todayViewModelProvider.notifier);
    final l10n = context.l10n;

    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(20, 6, 8, 6),
      onTap: () => context.push(Routes.entry(entry.id)),
      leading: ProjectDot(project: project, size: 12),
      minLeadingWidth: 12,
      title: Text(
        entry.description.isEmpty ? l10n.noDescription : entry.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${project?.name ?? l10n.noProject} · '
        '${formatTimeRange(entry.startAt, entry.endAt, l10n)}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            formatClock(entry.durationAt(now)),
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          entry.isRunning
              ? IconButton(
                  tooltip: l10n.stopTimer,
                  color: colors.primary,
                  onPressed: viewModel.stopTimer,
                  icon: const Icon(Icons.stop_rounded),
                )
              : IconButton(
                  tooltip: l10n.continueEntry,
                  color: colors.onSurfaceVariant,
                  onPressed: () async {
                    await viewModel.continueEntry(entry);
                    if (context.mounted) await context.push(Routes.timer);
                  },
                  icon: const Icon(Icons.play_arrow_rounded),
                ),
        ],
      ),
    );
  }
}
