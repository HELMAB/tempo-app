import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/routes.dart';
import '../../../core/formatters/date_format.dart';
import '../../../core/formatters/duration_format.dart';
import '../../../core/localization.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/widgets/clock_builder.dart';
import '../../../core/widgets/new_tag_dialog.dart';
import '../../../core/widgets/progress_ring.dart';
import '../../../core/widgets/project_chip.dart';
import '../../../core/widgets/project_picker_sheet.dart';
import '../view_models/timer_ui_state.dart';
import '../view_models/timer_view_model.dart';

class TimerScreen extends ConsumerWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(timerViewModelProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: switch (state) {
          AsyncValue(value: TimerUiState(entry: _?) && final value) =>
            _TimerContent(state: value),
          AsyncValue(hasValue: true) => const _NothingRunning(),
          AsyncError(:final error) => Center(
            child: Text('${context.l10n.timerLoadError}\n$error'),
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}

void _close(BuildContext context) =>
    context.canPop() ? context.pop() : context.go(Routes.today);

class _NothingRunning extends StatelessWidget {
  const _NothingRunning();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.timerNothingRunning,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => _close(context),
              child: Text(context.l10n.backToToday),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimerContent extends ConsumerStatefulWidget {
  const _TimerContent({required this.state});

  final TimerUiState state;

  @override
  ConsumerState<_TimerContent> createState() => _TimerContentState();
}

class _TimerContentState extends ConsumerState<_TimerContent> {
  late final _note = TextEditingController(text: widget.state.entry!.note);

  TimerViewModel get _viewModel => ref.read(timerViewModelProvider.notifier);

  @override
  void didUpdateWidget(_TimerContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Resuming creates a new entry; start its note fresh.
    if (oldWidget.state.entry!.id != widget.state.entry!.id) {
      _note.text = widget.state.entry!.note;
    }
  }

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _closeSavingNote() async {
    await _viewModel.saveNote(_note.text);
    if (mounted) _close(context);
  }

  Future<void> _stopAndSave() async {
    await _viewModel.stopAndSave(note: _note.text);
    if (mounted) _close(context);
  }

  Future<void> _discard() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.discardDialogTitle),
        content: Text(context.l10n.discardDialogBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.l10n.discardDialogKeep),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(context.l10n.timerDiscard),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await _viewModel.discard();
    if (mounted) _close(context);
  }

  Future<void> _editEntry() async {
    await _viewModel.saveNote(_note.text);
    if (mounted) await context.push(Routes.entry(widget.state.entry!.id));
  }

  Future<void> _pickProject() async {
    final choice = await showProjectPicker(
      context,
      projects: widget.state.projects,
      selectedId: widget.state.project?.id,
    );
    if (choice != null) await _viewModel.changeProject(choice.projectId);
  }

  Future<void> _addTag() async {
    final tag = await showNewTagDialog(context);
    if (tag != null) await _viewModel.addTag(tag);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final state = widget.state;
    final entry = state.entry!;
    final l10n = context.l10n;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(
        children: [
          Row(
            children: [
              IconButton.filledTonal(
                tooltip: l10n.close,
                style: IconButton.styleFrom(
                  backgroundColor: colors.surfaceContainerLow,
                ),
                onPressed: _closeSavingNote,
                icon: const Icon(Icons.keyboard_arrow_down),
              ),
              Expanded(child: _Status(paused: state.isPaused)),
              PopupMenuButton<void>(
                tooltip: l10n.more,
                icon: const Icon(Icons.more_vert),
                style: IconButton.styleFrom(
                  backgroundColor: colors.surfaceContainerLow,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(onTap: _editEntry, child: Text(l10n.editEntry)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          ProjectChip(
            project: state.project,
            outlined: true,
            showDropdown: true,
            onPressed: _pickProject,
          ),
          const SizedBox(height: 12),
          Text(
            entry.description.isEmpty ? l10n.noDescription : entry.description,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),
          ClockBuilder(
            ticking: state.isRunning,
            builder: (context, now) => _Clock(state: state, now: now),
          ),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _RoundAction(
                  label: l10n.timerDiscard,
                  icon: Icons.close,
                  style: _RoundActionStyle.outlined,
                  onPressed: _discard,
                ),
              ),
              Expanded(
                child: _RoundAction(
                  label: l10n.timerStopAndSave,
                  icon: Icons.stop_rounded,
                  style: _RoundActionStyle.primary,
                  onPressed: _stopAndSave,
                ),
              ),
              Expanded(
                child: state.isPaused
                    ? _RoundAction(
                        label: l10n.timerResume,
                        icon: Icons.play_arrow_rounded,
                        style: _RoundActionStyle.tonal,
                        onPressed: _viewModel.resume,
                      )
                    : _RoundAction(
                        label: l10n.timerPause,
                        icon: Icons.pause_rounded,
                        style: _RoundActionStyle.tonal,
                        onPressed: () => _viewModel.pause(note: _note.text),
                      ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              l10n.timerNote,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _note,
            minLines: 1,
            maxLines: 4,
            onSubmitted: _viewModel.saveNote,
            onTapOutside: (_) {
              FocusScope.of(context).unfocus();
              _viewModel.saveNote(_note.text);
            },
            decoration: InputDecoration(
              hintText: l10n.timerNoteHint,
              fillColor: colors.surfaceContainerLow,
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final tag in {...state.tagNames, ...entry.tags})
                  FilterChip(
                    label: Text(tag),
                    selected: entry.tags.contains(tag),
                    showCheckmark: false,
                    onSelected: (_) => _viewModel.toggleTag(tag),
                  ),
                ActionChip(label: Text(l10n.timerAddTag), onPressed: _addTag),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Status extends StatelessWidget {
  const _Status({required this.paused});

  final bool paused;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: paused ? colors.outline : AppColors.projectPalette[2],
          ),
          child: const SizedBox.square(dimension: 10),
        ),
        const SizedBox(width: 8),
        Text(
          paused ? context.l10n.timerPaused : context.l10n.timerTracking,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _Clock extends StatelessWidget {
  const _Clock({required this.state, required this.now});

  final TimerUiState state;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final entry = state.entry!;
    final l10n = context.l10n;
    final ringSize = math.min(MediaQuery.sizeOf(context).width - 80, 300.0);

    return Column(
      children: [
        SizedBox.square(
          dimension: ringSize,
          child: ProgressRing(
            progress: state.focusFractionAt(now),
            strokeWidth: 14,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  formatClock(entry.durationAt(now)),
                  style: theme.textTheme.displayLarge,
                ),
                Text(
                  l10n.focusGoal(formatGoal(state.focusGoal, l10n)),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            _InfoPill(
              label: l10n.timerStarted,
              value: formatTimeOfDay(entry.startAt, l10n),
            ),
            _InfoPill(
              label: l10n.navToday,
              value: formatHoursMinutes(
                state.todayProgressAt(now).tracked,
                l10n,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return DecoratedBox(
      decoration: ShapeDecoration(
        color: colors.surfaceContainerLow,
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Text.rich(
          TextSpan(
            text: '$label  ',
            style: TextStyle(color: colors.onSurfaceVariant),
            children: [
              TextSpan(
                text: value,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: colors.onSurface,
                ),
              ),
            ],
          ),
          style: theme.textTheme.bodyMedium,
        ),
      ),
    );
  }
}

enum _RoundActionStyle { primary, tonal, outlined }

class _RoundAction extends StatelessWidget {
  const _RoundAction({
    required this.label,
    required this.icon,
    required this.style,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final _RoundActionStyle style;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final primary = style == _RoundActionStyle.primary;
    final size = primary ? 88.0 : 64.0;

    final buttonStyle = IconButton.styleFrom(
      fixedSize: Size.square(size),
      iconSize: primary ? 32 : 26,
      backgroundColor: switch (style) {
        _RoundActionStyle.primary => colors.primary,
        _RoundActionStyle.tonal => colors.primaryContainer,
        _RoundActionStyle.outlined => colors.surface,
      },
      foregroundColor: switch (style) {
        _RoundActionStyle.primary => colors.onPrimary,
        _RoundActionStyle.tonal => colors.primary,
        _RoundActionStyle.outlined => colors.onSurfaceVariant,
      },
      side: style == _RoundActionStyle.outlined
          ? BorderSide(color: colors.outlineVariant)
          : null,
    );

    return Column(
      children: [
        IconButton(
          tooltip: label,
          style: buttonStyle,
          onPressed: onPressed,
          icon: Icon(icon),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: primary ? FontWeight.w700 : FontWeight.w500,
            color: primary ? colors.onSurface : colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
