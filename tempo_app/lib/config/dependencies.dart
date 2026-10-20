import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repositories/project_repository.dart';
import '../data/repositories/settings_repository.dart';
import '../data/repositories/time_entry_repository.dart';
import '../data/services/database/app_database.dart';
import '../domain/models/app_settings.dart';

// Dependency graph: services -> repositories. ViewModels live next to their
// feature in lib/ui/features/*/view_models and read repositories from here.

// --- Services ---------------------------------------------------------------

/// Created asynchronously in `main()` and injected with `overrideWithValue`.
final sharedPreferencesProvider = Provider<SharedPreferencesWithCache>(
  (ref) => throw UnimplementedError('Override sharedPreferencesProvider'),
);

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

// --- Repositories -----------------------------------------------------------

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final repository = SettingsRepository(
    preferences: ref.watch(sharedPreferencesProvider),
  );
  ref.onDispose(repository.dispose);
  return repository;
});

final projectRepositoryProvider = Provider<ProjectRepository>(
  (ref) => ProjectRepository(database: ref.watch(appDatabaseProvider)),
);

final timeEntryRepositoryProvider = Provider<TimeEntryRepository>(
  (ref) => TimeEntryRepository(database: ref.watch(appDatabaseProvider)),
);

// --- App-wide state ---------------------------------------------------------

/// Current settings, re-emitted on every change (daily goal, theme...).
final appSettingsProvider = StreamProvider<AppSettings>(
  (ref) => ref.watch(settingsRepositoryProvider).watch(),
);
