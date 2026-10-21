import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/models/project.dart';
import '../../../../routing/routes.dart';
import '../../../core/formatters/duration_format.dart';
import '../../../core/localization.dart';
import '../../../core/widgets/clock_builder.dart';
import '../../../core/widgets/motion.dart';
import '../../../core/widgets/pill_segmented_control.dart';
import '../../../core/widgets/project_chip.dart';
import '../view_models/projects_ui_state.dart';
import '../view_models/projects_view_model.dart';

class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectsViewModelProvider);

    return SafeArea(
      child: switch (state) {
        AsyncValue(:final value?) => ClockBuilder(
          ticking: value.hasRunningEntry,
          builder: (context, now) => _ProjectsContent(state: value, now: now),
        ),
        AsyncError(:final error) => Center(
          child: Text('${context.l10n.projectsLoadError}\n$error'),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _ProjectsContent extends ConsumerStatefulWidget {
  const _ProjectsContent({required this.state, required this.now});

  final ProjectsUiState state;
  final DateTime now;

  @override
  ConsumerState<_ProjectsContent> createState() => _ProjectsContentState();
}

class _ProjectsContentState extends ConsumerState<_ProjectsContent> {
  bool _showArchived = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final l10n = context.l10n;
    final state = widget.state;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.projectsActiveCount(state.active.length),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  Text(l10n.navProjects, style: theme.textTheme.headlineMedium),
                ],
              ),
            ),
            IconButton.filled(
              tooltip: l10n.newProjectTitle,
              iconSize: 28,
              style: IconButton.styleFrom(minimumSize: const Size.square(56)),
              onPressed: () => context.go(Routes.newProject),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 16),
        PillSegmentedControl<ProjectsRange>(
          segments: [
            (value: ProjectsRange.thisWeek, label: l10n.projectsThisWeek),
            (value: ProjectsRange.allTime, label: l10n.projectsAllTime),
          ],
          selected: state.range,
          onChanged: ref.read(projectsViewModelProvider.notifier).selectRange,
        ),
        const SizedBox(height: 16),
        if (state.active.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                l10n.projectsEmpty,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
          ),
        for (final (index, project) in state.active.indexed) ...[
          FadeSlideIn(
            key: ValueKey(project.id),
            index: index,
            child: _ProjectCard(
              project: project,
              state: state,
              now: widget.now,
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (state.archived.isNotEmpty) ...[
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            title: Text(
              l10n.projectsArchivedCount(state.archived.length),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            trailing: AnimatedRotation(
              turns: _showArchived ? 0.25 : 0,
              duration: const Duration(milliseconds: 150),
              child: const Icon(Icons.chevron_right),
            ),
            onTap: () => setState(() => _showArchived = !_showArchived),
          ),
          if (_showArchived)
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  for (final (index, project) in state.archived.indexed) ...[
                    if (index > 0) const Divider(),
                    ListTile(
                      leading: ProjectDot(project: project, size: 12),
                      minLeadingWidth: 12,
                      title: Text(project.name),
                      onTap: () => context.go(Routes.project(project.id)),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.project,
    required this.state,
    required this.now,
  });

  final Project project;
  final ProjectsUiState state;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final l10n = context.l10n;
    final color = Color(project.color);
    final tracked = state.totals.trackedAt(project.id, now);
    final goal = project.weeklyGoal;
    final withGoal = state.showsGoals && goal > Duration.zero;
    final fraction = state.totals.goalFractionAt(project.id, goal, now);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go(Routes.project(project.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Icon(Icons.folder_outlined, color: color),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          withGoal
                              ? l10n.projectGoalProgress(
                                  formatHoursMinutes(tracked, l10n),
                                  formatGoal(goal, l10n),
                                )
                              : l10n.projectTotal(
                                  formatHoursMinutes(tracked, l10n),
                                ),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (withGoal) ...[
                    const SizedBox(width: 12),
                    Text(
                      '${(fraction * 100).round()}%',
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ],
              ),
              if (withGoal) ...[
                const SizedBox(height: 16),
                AnimatedProgressBar(
                  value: fraction,
                  minHeight: 6,
                  color: color,
                  backgroundColor: colors.outlineVariant.withValues(alpha: 0.6),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
