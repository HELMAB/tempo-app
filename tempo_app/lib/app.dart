import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/dependencies.dart';
import 'domain/models/app_settings.dart';
import 'l10n/app_localizations.dart';
import 'routing/router.dart';
import 'ui/core/themes/app_theme.dart';
import 'ui/features/idle/views/idle_watcher.dart';

class TempoApp extends ConsumerWidget {
  const TempoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    // Keep notifications in step with settings and the running timer.
    ref
      ..listen(reminderSyncProvider, (_, _) {})
      ..listen(runningTimerNotificationSyncProvider, (_, _) {});
    final (theme, language) = ref.watch(
      appSettingsProvider.select((settings) {
        final value = settings.value ?? const AppSettings();
        return (value.theme, value.language);
      }),
    );
    // The app's own setting decides the language (Khmer by default),
    // not the device locale.
    final locale = Locale(language.code);

    return MaterialApp.router(
      onGenerateTitle: (context) => 'Tempo',
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: AppTheme.light(locale),
      darkTheme: AppTheme.dark(locale),
      themeMode: switch (theme) {
        ThemePreference.light => ThemeMode.light,
        ThemePreference.dark => ThemeMode.dark,
        ThemePreference.system => ThemeMode.system,
      },
      routerConfig: router,
      builder: (context, child) => IdleWatcher(child: child!),
    );
  }
}
