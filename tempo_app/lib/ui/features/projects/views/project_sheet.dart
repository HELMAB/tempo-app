import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/routes.dart';
import '../../../core/formatters/duration_format.dart';
import '../../../core/localization.dart';
import '../../../core/themes/app_colors.dart';
import '../view_models/project_editor_view_model.dart';

/// Bottom sheet to create (no [projectId]) or edit a project.
class ProjectSheet extends ConsumerWidget {
  const ProjectSheet({super.key, this.projectId});

  final int? projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectEditorViewModelProvider(projectId));

    return Padding(
      // Keep the form above the keyboard.
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: switch (state) {
        AsyncValue(:final value?) => _ProjectForm(state: value),
        AsyncValue(hasValue: true) => Padding(
          padding: const EdgeInsets.all(24),
          child: Text(context.l10n.projectNotFound),
        ),
        AsyncError(:final error) => Padding(
          padding: const EdgeInsets.all(24),
          child: Text('${context.l10n.projectsLoadError}\n$error'),
        ),
        _ => const Padding(
          padding: EdgeInsets.all(48),
          child: Center(child: CircularProgressIndicator()),
        ),
      },
    );
  }
}

void _close(BuildContext context) =>
    context.canPop() ? context.pop() : context.go(Routes.projects);

class _ProjectForm extends ConsumerStatefulWidget {
  const _ProjectForm({required this.state});

  final ProjectEditorUiState state;

  @override
  ConsumerState<_ProjectForm> createState() => _ProjectFormState();
}

class _ProjectFormState extends ConsumerState<_ProjectForm> {
  late final _name = TextEditingController(text: widget.state.name);

  ProjectEditorViewModel get _viewModel =>
      ref.read(projectEditorViewModelProvider(widget.state.projectId).notifier);

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    try {
      if (await _viewModel.save() && mounted) _close(context);
    } on Exception {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.l10n.saveFailed)));
      }
    }
  }

  Future<void> _toggleArchived() async {
    await _viewModel.toggleArchived();
    if (mounted) _close(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final l10n = context.l10n;
    final state = widget.state;

    final labelStyle = theme.textTheme.bodyMedium?.copyWith(
      color: colors.onSurfaceVariant,
    );
    Widget label(String text) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: labelStyle),
    );

    final perDay = Duration(minutes: (state.weeklyGoalMinutes / 7).round());

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  state.isNew ? l10n.newProjectTitle : l10n.editProjectTitle,
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              IconButton.filledTonal(
                tooltip: l10n.close,
                style: IconButton.styleFrom(
                  backgroundColor: colors.surfaceContainerLow,
                ),
                onPressed: () => _close(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 20),
          label(l10n.projectName),
          TextField(
            controller: _name,
            autofocus: state.isNew,
            maxLength: 80,
            textCapitalization: TextCapitalization.sentences,
            onChanged: _viewModel.setName,
            decoration: InputDecoration(
              hintText: l10n.projectNameHint,
              counterText: '',
            ),
          ),
          const SizedBox(height: 16),
          label(l10n.projectColour),
          _ColourPicker(selected: state.color, onSelected: _viewModel.setColor),
          const SizedBox(height: 20),
          label(l10n.projectWeeklyGoal),
          DecoratedBox(
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
                    tooltip: l10n.projectDecreaseGoal,
                    onPressed: state.canDecreaseGoal
                        ? _viewModel.decreaseGoal
                        : null,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          state.weeklyGoalMinutes == 0
                              ? l10n.projectNoGoal
                              : formatGoal(state.weeklyGoal, l10n),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (state.weeklyGoalMinutes > 0)
                          Text(
                            l10n.projectGoalPerDay(
                              formatHoursMinutes(perDay, l10n),
                            ),
                            textAlign: TextAlign.center,
                            style: labelStyle,
                          ),
                      ],
                    ),
                  ),
                  _StepButton(
                    icon: Icons.add,
                    tooltip: l10n.projectIncreaseGoal,
                    onPressed: state.canIncreaseGoal
                        ? _viewModel.increaseGoal
                        : null,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: state.countsTowardDailyGoal,
            onChanged: _viewModel.setCountsTowardDailyGoal,
            title: Text(
              l10n.projectCountsTowardDaily,
              style: theme.textTheme.titleMedium,
            ),
            subtitle: Text(
              l10n.projectCountsTowardDailyBody(
                formatGoal(state.dailyGoal, l10n),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: state.canSave ? _save : null,
            child: Text(state.isNew ? l10n.projectCreate : l10n.save),
          ),
          if (!state.isNew) ...[
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: _toggleArchived,
                child: Text(
                  state.archived ? l10n.projectRestore : l10n.projectArchive,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ColourPicker extends StatelessWidget {
  const _ColourPicker({required this.selected, required this.onSelected});

  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Row(
      children: [
        for (final (index, colour) in AppColors.projectPalette.indexed)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: AspectRatio(
                aspectRatio: 1,
                child: _Swatch(
                  colour: colour,
                  selected: colour.toARGB32() == selected,
                  label: l10n.projectColourLabel(index + 1),
                  onTap: () => onSelected(colour.toARGB32()),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({
    required this.colour,
    required this.selected,
    required this.label,
    required this.onTap,
  });

  final Color colour;
  final bool selected;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: selected ? Border.all(color: colour, width: 2.5) : null,
          ),
          child: Padding(
            padding: EdgeInsets.all(selected ? 3 : 0),
            child: DecoratedBox(
              decoration: BoxDecoration(color: colour, shape: BoxShape.circle),
              child: selected
                  ? const Center(child: Icon(Icons.check, color: Colors.white))
                  : const SizedBox.expand(),
            ),
          ),
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
