import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repositories/backup_repository.dart';
import '../data/repositories/notification_repository.dart';
import '../data/repositories/project_repository.dart';
import '../data/repositories/settings_repository.dart';
import '../data/repositories/time_entry_repository.dart';
import '../data/services/database/app_database.dart';
import '../data/services/file_service.dart';
import '../data/services/notification_service.dart';
import '../domain/models/app_settings.dart';
import '../domain/models/project.dart';
import '../domain/models/time_entry.dart';

// Dependency graph: services -> repositories. ViewModels live next to their
// feature in lib/ui/features/*/view_models and read repositories from here.

// --- Services ---------------------------------------------------------------

/// Current time; overridden in tests to freeze the clock.
final clockProvider = Provider<DateTime Function()>((ref) => DateTime.now);

/// Created asynchronously in `main()` and injected with `overrideWithValue`.
final sharedPreferencesProvider = Provider<SharedPreferencesWithCache>(
  (ref) => throw UnimplementedError('Override sharedPreferencesProvider'),
);

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

final fileServiceProvider = Provider<FileService>((ref) => FileService());

final notificationServiceProvider = Provider<NotificationService>(
  (ref) => NotificationService(),
);

/// App version for the Settings footer.
final appVersionProvider = FutureProvider<String>(
  (ref) async => (await PackageInfo.fromPlatform()).version,
);

// --- Repositories -----------------------------------------------------------

final backupRepositoryProvider = Provider<BackupRepository>(
  (ref) => BackupRepository(
    database: ref.watch(appDatabaseProvider),
    projects: ref.watch(projectRepositoryProvider),
    entries: ref.watch(timeEntryRepositoryProvider),
    files: ref.watch(fileServiceProvider),
    clock: ref.watch(clockProvider),
  ),
);

final notificationRepositoryProvider = Provider<NotificationRepository>(
  (ref) =>
      NotificationRepository(service: ref.watch(notificationServiceProvider)),
);

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
  (ref) => TimeEntryRepository(
    database: ref.watch(appDatabaseProvider),
    clock: ref.watch(clockProvider),
  ),
);

// --- App-wide state ---------------------------------------------------------

/// Current settings, re-emitted on every change (daily goal, theme...).
final appSettingsProvider = StreamProvider<AppSettings>(
  (ref) => ref.watch(settingsRepositoryProvider).watch(),
);

/// Every project, archived included; filter `archived` for pickers.
final projectsProvider = StreamProvider<List<Project>>(
  (ref) => ref.watch(projectRepositoryProvider).watchAllProjects(),
);

/// The entry whose `endAt` is null, if a timer is running.
final runningEntryProvider = StreamProvider<TimeEntry?>(
  (ref) => ref.watch(timeEntryRepositoryProvider).watchRunningEntry(),
);

final tagNamesProvider = StreamProvider<List<String>>(
  (ref) => ref.watch(timeEntryRepositoryProvider).watchTagNames(),
);

/// Entries started on [day] (a local date at midnight), oldest first.
final entriesOnDayProvider = StreamProvider.autoDispose
    .family<List<TimeEntry>, DateTime>(
      (ref, day) => ref
          .watch(timeEntryRepositoryProvider)
          .watchEntries(
            from: day,
            to: DateTime(day.year, day.month, day.day + 1),
          ),
    );

/// Finished time per project for entries started in `[from, to)`; null
/// bounds are open. Combine with [runningEntryProvider] for live totals.
final finishedTotalsByProjectProvider = StreamProvider.autoDispose
    .family<Map<int?, Duration>, ({DateTime? from, DateTime? to})>(
      (ref, range) => ref
          .watch(timeEntryRepositoryProvider)
          .watchFinishedTotalsByProject(from: range.from, to: range.to),
    );

/// Entries started in `[from, to)`, oldest first.
final entriesBetweenProvider = StreamProvider.autoDispose
    .family<List<TimeEntry>, ({DateTime from, DateTime to})>(
      (ref, range) => ref
          .watch(timeEntryRepositoryProvider)
          .watchEntries(from: range.from, to: range.to),
    );

/// Keeps the weekday reminder in step with its settings and the language.
/// Listened to by the app root.
final reminderSyncProvider = FutureProvider<void>((ref) async {
  // Only re-schedule when a field the reminder depends on changes.
  await ref.watch(
    appSettingsProvider.selectAsync(
      (s) => (s.remindToStart, s.reminderMinuteOfDay, s.language),
    ),
  );
  await ref
      .read(notificationRepositoryProvider)
      .syncReminder(ref.read(settingsRepositoryProvider).current);
});

/// Shows or clears the ongoing "timer running" notification.
final runningTimerNotificationSyncProvider = FutureProvider<void>((ref) async {
  final (settings, running) = await (
    ref.watch(appSettingsProvider.future),
    ref.watch(runningEntryProvider.future),
  ).wait;
  await ref
      .read(notificationRepositoryProvider)
      .syncRunningTimer(settings, running);
});
