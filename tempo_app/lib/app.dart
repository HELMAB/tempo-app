import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/dependencies.dart';
import 'domain/models/app_settings.dart';
import 'routing/router.dart';
import 'ui/core/themes/app_theme.dart';

class TempoApp extends ConsumerWidget {
  const TempoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final theme = ref.watch(
      appSettingsProvider.select((settings) => settings.value?.theme),
    );

    return MaterialApp.router(
      title: 'Tempo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: switch (theme) {
        ThemePreference.light => ThemeMode.light,
        ThemePreference.dark => ThemeMode.dark,
        ThemePreference.system || null => ThemeMode.system,
      },
      routerConfig: router,
    );
  }
}
