import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../config/dependencies.dart';
import '../../../../domain/models/app_settings.dart';
import '../../../core/formatters/duration_format.dart';
import '../../../core/localization.dart';
import '../../../core/widgets/goal_stepper.dart';
import '../view_models/settings_view_model.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsViewModelProvider).value;

    return SafeArea(
      child: settings == null
          ? const Center(child: CircularProgressIndicator())
          : _SettingsList(settings: settings),
    );
  }
}

class _SettingsList extends ConsumerWidget {
  const _SettingsList({required this.settings});

  final AppSettings settings;

  SettingsViewModel _viewModel(WidgetRef ref) =>
      ref.read(settingsViewModelProvider.notifier);

  void _snack(BuildContext context, String message) => ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(message)));

  /// Runs a share / export and reports failures.
  Future<void> _run(BuildContext context, Future<void> Function() task) async {
    try {
      await task();
    } on Exception {
      if (context.mounted) _snack(context, context.l10n.exportFailed);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final viewModel = _viewModel(ref);
    final notifications = viewModel.notificationsSupported;
    final version = ref.watch(appVersionProvider).value;
    final reminderTime = _timeOfDay(settings.reminderMinuteOfDay, l10n);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      children: [
        Text(l10n.navSettings, style: theme.textTheme.headlineMedium),
        _Section(
          title: l10n.settingsTracking,
          children: [
            _ValueRow(
              title: l10n.settingsDailyGoal,
              value: formatGoal(
                Duration(minutes: settings.dailyGoalMinutes),
                l10n,
              ),
              onTap: () => _pickDailyGoal(context, ref),
            ),
            _ValueRow(
              title: l10n.settingsWeekStartsOn,
              value: _weekdayName(settings.weekStartsOn, l10n),
              onTap: () => _pickWeekStart(context, ref),
            ),
            _SwitchRow(
              title: l10n.settingsIdleDetection,
              subtitle: l10n.settingsIdleDetectionBody(10),
              value: settings.idleDetection,
              onChanged: viewModel.setIdleDetection,
            ),
          ],
        ),
        _Section(
          title: l10n.settingsReminders,
          children: [
            _SwitchRow(
              title: l10n.settingsRemindToStart,
              subtitle: notifications
                  ? l10n.settingsRemindToStartBody(reminderTime)
                  : l10n.settingsNotificationsUnavailable,
              value: notifications && settings.remindToStart,
              onTap: notifications && settings.remindToStart
                  ? () => _pickReminderTime(context, ref)
                  : null,
              onChanged: notifications
                  ? (on) async {
                      if (!await viewModel.setRemindToStart(on) &&
                          context.mounted) {
                        _snack(context, l10n.notificationsDenied);
                      }
                    }
                  : null,
            ),
            _SwitchRow(
              title: l10n.settingsRunningTimerNotification,
              subtitle: notifications
                  ? l10n.settingsRunningTimerNotificationBody
                  : l10n.settingsNotificationsUnavailable,
              value: notifications && settings.runningTimerNotification,
              onChanged: notifications
                  ? (on) async {
                      if (!await viewModel.setRunningTimerNotification(on) &&
                          context.mounted) {
                        _snack(context, l10n.notificationsDenied);
                      }
                    }
                  : null,
            ),
          ],
        ),
        _Section(
          title: l10n.settingsAppearance,
          children: [
            _ValueRow(
              title: l10n.settingsTheme,
              value: _themeName(settings.theme, l10n),
              onTap: () => _pickOption(
                context,
                title: l10n.settingsTheme,
                options: {
                  for (final theme in ThemePreference.values)
                    theme: _themeName(theme, l10n),
                },
                selected: settings.theme,
                onSelected: viewModel.setTheme,
              ),
            ),
            _ValueRow(
              title: l10n.settingsLanguage,
              value: settings.language.nativeName,
              onTap: () => _pickOption(
                context,
                title: l10n.settingsLanguage,
                options: {
                  for (final language in AppLanguage.values)
                    language: language.nativeName,
                },
                selected: settings.language,
                onSelected: viewModel.setLanguage,
              ),
            ),
          ],
        ),
        _Section(
          title: l10n.settingsData,
          children: [
            _ValueRow(
              title: l10n.settingsExportCsv,
              onTap: () => _run(context, viewModel.exportCsv),
            ),
            _ValueRow(
              title: l10n.settingsBackup,
              onTap: () => _openBackup(context, ref),
            ),
          ],
        ),
        if (version != null)
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Text(
              l10n.settingsVersion(version),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _pickDailyGoal(BuildContext context, WidgetRef ref) async {
    final minutes = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      builder: (context) =>
          _DailyGoalSheet(initialMinutes: settings.dailyGoalMinutes),
    );
    if (minutes != null) await _viewModel(ref).setDailyGoalMinutes(minutes);
  }

  Future<void> _pickWeekStart(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return _pickOption(
      context,
      title: l10n.settingsWeekStartsOn,
      options: {
        for (final day in const [
          DateTime.monday,
          DateTime.saturday,
          DateTime.sunday,
        ])
          day: _weekdayName(day, l10n),
      },
      selected: settings.weekStartsOn,
      onSelected: _viewModel(ref).setWeekStartsOn,
    );
  }

  Future<void> _pickReminderTime(BuildContext context, WidgetRef ref) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: settings.reminderMinuteOfDay ~/ 60,
        minute: settings.reminderMinuteOfDay % 60,
      ),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (time != null) {
      await _viewModel(ref).setReminderTime(time.hour, time.minute);
    }
  }

  Future<void> _openBackup(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final action = await showModalBottomSheet<_BackupAction>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                l10n.settingsBackup,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: Text(l10n.backupCreate),
              subtitle: Text(l10n.backupCreateBody),
              onTap: () => Navigator.pop(context, _BackupAction.create),
            ),
            ListTile(
              leading: const Icon(Icons.restore),
              title: Text(l10n.backupRestore),
              subtitle: Text(l10n.backupRestoreBody),
              onTap: () => Navigator.pop(context, _BackupAction.restore),
            ),
          ],
        ),
      ),
    );
    if (!context.mounted) return;
    switch (action) {
      case _BackupAction.create:
        await _run(context, _viewModel(ref).createBackup);
      case _BackupAction.restore:
        await _restore(context, ref);
      case null:
    }
  }

  Future<void> _restore(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final viewModel = _viewModel(ref);
    try {
      final backup = await viewModel.pickBackup(
        fileTypeLabel: l10n.backupFileType,
      );
      if (backup == null || !context.mounted) return;
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.restoreConfirmTitle),
          content: Text(l10n.restoreConfirmBody),
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
              child: Text(l10n.restoreConfirm),
            ),
          ],
        ),
      );
      if (confirmed != true) return;
      await viewModel.restore(backup);
      if (context.mounted) {
        _snack(
          context,
          l10n.restoreDone(backup.projects.length, backup.entries.length),
        );
      }
    } on FormatException {
      if (context.mounted) _snack(context, l10n.restoreInvalid);
    }
  }

  static Future<void> _pickOption<T>(
    BuildContext context, {
    required String title,
    required Map<T, String> options,
    required T selected,
    required Future<void> Function(T) onSelected,
  }) async {
    final picked = await showModalBottomSheet<T>(
      context: context,
      builder: (context) => SafeArea(
        child: RadioGroup<T>(
          groupValue: selected,
          onChanged: (value) => Navigator.pop(context, value),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              for (final MapEntry(key: value, value: label) in options.entries)
                RadioListTile<T>(value: value, title: Text(label)),
            ],
          ),
        ),
      ),
    );
    if (picked != null && picked != selected) await onSelected(picked);
  }

  static String _themeName(ThemePreference theme, AppLocalizations l10n) =>
      switch (theme) {
        ThemePreference.system => l10n.themeSystem,
        ThemePreference.light => l10n.themeLight,
        ThemePreference.dark => l10n.themeDark,
      };

  /// Localised weekday name; 1 January 2024 was a Monday.
  static String _weekdayName(int weekday, AppLocalizations l10n) =>
      DateFormat('EEEE', l10n.localeName).format(DateTime(2024, 1, weekday));

  static String _timeOfDay(int minuteOfDay, AppLocalizations l10n) =>
      DateFormat(
        'HH:mm',
        l10n.localeName,
      ).format(DateTime(2024, 1, 1, minuteOfDay ~/ 60, minuteOfDay % 60));
}

enum _BackupAction { create, restore }

/// "TRACKING" label followed by a card of rows.
class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Text(
              // No-op for Khmer, which has no letter case.
              title.toUpperCase(),
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                for (final (index, child) in children.indexed) ...[
                  if (index > 0) const Divider(),
                  child,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ValueRow extends StatelessWidget {
  const _ValueRow({required this.title, this.value, required this.onTap});

  final String title;
  final String? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(20, 4, 12, 4),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value case final value?)
            Text(
              value,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          const SizedBox(width: 4),
          Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant),
        ],
      ),
      onTap: onTap,
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final bool value;

  /// Null disables the switch.
  final ValueChanged<bool>? onChanged;

  /// Tapping the text; defaults to toggling the switch.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(20, 4, 12, 4),
      enabled: onChanged != null,
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(value: value, onChanged: onChanged),
      onTap: onTap ?? (onChanged == null ? null : () => onChanged!(!value)),
    );
  }
}

class _DailyGoalSheet extends StatefulWidget {
  const _DailyGoalSheet({required this.initialMinutes});

  final int initialMinutes;

  @override
  State<_DailyGoalSheet> createState() => _DailyGoalSheetState();
}

class _DailyGoalSheetState extends State<_DailyGoalSheet> {
  late int _minutes = widget.initialMinutes;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.settingsDailyGoal,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            GoalStepper(
              value: formatGoal(Duration(minutes: _minutes), l10n),
              decreaseTooltip: l10n.decrease,
              increaseTooltip: l10n.increase,
              onDecrease: _minutes > SettingsViewModel.minDailyGoalMinutes
                  ? () => setState(() => _minutes -= 30)
                  : null,
              onIncrease: _minutes < SettingsViewModel.maxDailyGoalMinutes
                  ? () => setState(() => _minutes += 30)
                  : null,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => Navigator.pop(context, _minutes),
              child: Text(l10n.save),
            ),
          ],
        ),
      ),
    );
  }
}
