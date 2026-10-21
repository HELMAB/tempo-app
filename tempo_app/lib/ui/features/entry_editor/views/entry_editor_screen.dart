import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/routes.dart';
import '../../../core/formatters/date_format.dart';
import '../../../core/formatters/duration_format.dart';
import '../../../core/localization.dart';
import '../../../core/themes/app_theme.dart';
import '../../../core/widgets/new_tag_dialog.dart';
import '../../../core/widgets/project_chip.dart';
import '../../../core/widgets/project_picker_sheet.dart';
import '../view_models/entry_editor_ui_state.dart';
import '../view_models/entry_editor_view_model.dart';

/// Add (no [entryId]) or edit a time entry.
class EntryEditorScreen extends ConsumerWidget {
  const EntryEditorScreen({super.key, this.entryId});

  final int? entryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(entryEditorViewModelProvider(entryId));
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: switch (state) {
          AsyncValue(:final value?) => _EditorForm(state: value),
          AsyncValue(hasValue: true) => _Message(text: l10n.entryNotFound),
          AsyncError(:final error) => _Message(
            text: '${l10n.entryLoadError}\n$error',
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}

void _close(BuildContext context) =>
    context.canPop() ? context.pop() : context.go(Routes.today);

class _Message extends StatelessWidget {
  const _Message({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: IconButton(
            tooltip: context.l10n.close,
            onPressed: () => _close(context),
            icon: const Icon(Icons.close),
          ),
        ),
        Expanded(child: Center(child: Text(text))),
      ],
    );
  }
}

class _EditorForm extends ConsumerStatefulWidget {
  const _EditorForm({required this.state});

  final EntryEditorUiState state;

  @override
  ConsumerState<_EditorForm> createState() => _EditorFormState();
}

class _EditorFormState extends ConsumerState<_EditorForm> {
  late final _description = TextEditingController(
    text: widget.state.draft.description,
  );
  late final _note = TextEditingController(text: widget.state.draft.note);

  EntryEditorViewModel get _viewModel =>
      ref.read(entryEditorViewModelProvider(widget.state.entryId).notifier);

  @override
  void dispose() {
    _description.dispose();
    _note.dispose();
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

  Future<void> _delete() async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.entryDeleteTitle),
        content: Text(l10n.entryDeleteBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await _viewModel.delete();
    if (mounted) _close(context);
  }

  Future<void> _pickProject() async {
    final choice = await showProjectPicker(
      context,
      projects: widget.state.projects,
      selectedId: widget.state.draft.projectId,
    );
    if (choice != null) _viewModel.setProject(choice.projectId);
  }

  Future<void> _pickDate() async {
    final startAt = widget.state.draft.startAt;
    final date = await showDatePicker(
      context: context,
      initialDate: startAt,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (date != null) _viewModel.setDate(date);
  }

  Future<TimeOfDay?> _pickTime(DateTime initial) => showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(initial),
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
      child: child!,
    ),
  );

  Future<void> _pickStart() async {
    final time = await _pickTime(widget.state.draft.startAt);
    if (time != null) _viewModel.setStartTime(time.hour, time.minute);
  }

  Future<void> _pickEnd() async {
    final endAt = widget.state.draft.endAt;
    if (endAt == null) return;
    final time = await _pickTime(endAt);
    if (time != null) _viewModel.setEndTime(time.hour, time.minute);
  }

  Future<void> _addTag() async {
    final tag = await showNewTagDialog(context);
    if (tag != null) _viewModel.addTag(tag);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final l10n = context.l10n;
    final state = widget.state;
    final draft = state.draft;

    final labelStyle = theme.textTheme.bodyMedium?.copyWith(
      color: colors.onSurfaceVariant,
    );
    Widget label(String text) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: labelStyle),
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
          child: Row(
            children: [
              IconButton(
                tooltip: l10n.close,
                onPressed: () => _close(context),
                icon: const Icon(Icons.close),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  state.isNew ? l10n.newEntryTitle : l10n.editEntry,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size(88, 48)),
                onPressed: state.canSave ? _save : null,
                child: Text(l10n.save),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            children: [
              label(l10n.entryDescription),
              TextField(
                controller: _description,
                textCapitalization: TextCapitalization.sentences,
                onChanged: _viewModel.setDescription,
                decoration: InputDecoration(
                  hintText: l10n.entryDescriptionHint,
                ),
              ),
              const SizedBox(height: 16),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    _FormRow(
                      label: l10n.projectPickerTitle,
                      onTap: _pickProject,
                      child: Row(
                        children: [
                          ProjectDot(project: state.project, size: 12),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              state.project?.name ?? l10n.noProject,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    _FormRow(
                      label: l10n.entryDate,
                      onTap: _pickDate,
                      child: Text(formatDate(draft.startAt, l10n)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        label(l10n.entryStart),
                        _TimeField(
                          text: formatTimeOfDay(draft.startAt, l10n),
                          onTap: _pickStart,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        label(l10n.entryEnd),
                        _TimeField(
                          text: switch (draft.endAt) {
                            final endAt? => formatTimeOfDay(endAt, l10n),
                            null => l10n.entryRunning,
                          },
                          onTap: state.isRunning ? null : _pickEnd,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (state.duration case final duration?
                  when state.validation != EntryValidation.endBeforeStart)
                _DurationBar(duration: duration),
              if (_validationMessage(state.validation, l10n)
                  case final message?)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    message,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.error,
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              label(l10n.entryTags),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final tag in state.tagNames)
                    FilterChip(
                      label: Text(tag),
                      selected: draft.tags.contains(tag),
                      onSelected: (_) => _viewModel.toggleTag(tag),
                    ),
                  ActionChip(label: Text(l10n.entryNewTag), onPressed: _addTag),
                ],
              ),
              const SizedBox(height: 24),
              label(l10n.timerNote),
              TextField(
                controller: _note,
                minLines: 3,
                maxLines: 6,
                textCapitalization: TextCapitalization.sentences,
                onChanged: _viewModel.setNote,
                decoration: InputDecoration(hintText: l10n.entryNoteHint),
              ),
              if (!state.isNew) ...[
                const SizedBox(height: 32),
                Center(
                  child: TextButton.icon(
                    style: TextButton.styleFrom(foregroundColor: colors.error),
                    onPressed: _delete,
                    icon: const Icon(Icons.delete_outline),
                    label: Text(l10n.entryDelete),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  static String? _validationMessage(
    EntryValidation validation,
    AppLocalizations l10n,
  ) => switch (validation) {
    EntryValidation.valid => null,
    EntryValidation.endBeforeStart => l10n.entryEndBeforeStart,
    EntryValidation.startInFuture => l10n.entryStartInFuture,
  };
}

/// "Project  ● Flutter course  >" row inside the details card.
class _FormRow extends StatelessWidget {
  const _FormRow({
    required this.label,
    required this.child,
    required this.onTap,
  });

  final String label;
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 12, 16),
        child: Row(
          children: [
            SizedBox(
              width: 96,
              child: Text(
                label,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            Expanded(
              child: DefaultTextStyle.merge(
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                child: child,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

/// Tappable box styled like a text field, showing `09:00`.
class _TimeField extends StatelessWidget {
  const _TimeField({required this.text, required this.onTap});

  final String text;

  /// Null disables the field.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final radius = BorderRadius.circular(AppTheme.fieldRadius);

    return Material(
      color: onTap == null ? colors.surfaceContainerLow : colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(color: colors.outlineVariant),
      ),
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Text(
            text,
            style: theme.textTheme.titleMedium?.copyWith(
              fontFeatures: const [FontFeature.tabularFigures()],
              color: onTap == null ? colors.onSurfaceVariant : null,
            ),
          ),
        ),
      ),
    );
  }
}

class _DurationBar extends StatelessWidget {
  const _DurationBar({required this.duration});

  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final l10n = context.l10n;
    final style = theme.textTheme.bodyLarge?.copyWith(
      color: colors.onPrimaryContainer,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(AppTheme.fieldRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(child: Text(l10n.entryDuration, style: style)),
            Text(
              formatHoursMinutes(duration, l10n),
              style: style?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
