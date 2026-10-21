import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/models/app_settings.dart';
import '../../../core/localization.dart';
import '../../../core/widgets/screen_placeholder.dart';
import '../view_models/settings_view_model.dart';

/// Only the language row is built so far; the rest follows build step 5.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(
      settingsViewModelProvider.select((s) => s.value?.language),
    );

    return ScreenPlaceholder(
      title: context.l10n.navSettings,
      prototype: '08 · Settings.png',
      actions: [
        Card(
          clipBehavior: Clip.antiAlias,
          child: ListTile(
            title: Text(context.l10n.settingsLanguage),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(language?.nativeName ?? ''),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap: language == null
                ? null
                : () => _pickLanguage(context, ref, language),
          ),
        ),
      ],
    );
  }

  Future<void> _pickLanguage(
    BuildContext context,
    WidgetRef ref,
    AppLanguage current,
  ) async {
    final picked = await showModalBottomSheet<AppLanguage>(
      context: context,
      builder: (context) => SafeArea(
        child: RadioGroup<AppLanguage>(
          groupValue: current,
          onChanged: (value) => Navigator.pop(context, value),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final language in AppLanguage.values)
                RadioListTile<AppLanguage>(
                  value: language,
                  title: Text(language.nativeName),
                ),
            ],
          ),
        ),
      ),
    );
    if (picked != null && picked != current) {
      await ref.read(settingsViewModelProvider.notifier).setLanguage(picked);
    }
  }
}
