import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:tempo_app/config/dependencies.dart';
import 'package:tempo_app/data/services/database/app_database.dart';

/// Fresh in-memory SQLite database per test.
AppDatabase createTestDatabase() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  return AppDatabase(NativeDatabase.memory());
}

/// In-memory preferences, optionally pre-filled with raw key/values.
Future<SharedPreferencesWithCache> createTestPreferences([
  Map<String, Object> values = const {},
]) {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.withData(values);
  return SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(),
  );
}

/// Container wired to an in-memory database and preferences, with a clock
/// that tests control by returning a mutable `now`.
Future<ProviderContainer> createTestContainer({
  required DateTime Function() clock,
  Map<String, Object> preferences = const {'onboarding_complete': true},
}) async {
  final database = createTestDatabase();
  addTearDown(database.close);
  return ProviderContainer.test(
    overrides: [
      clockProvider.overrideWithValue(clock),
      appDatabaseProvider.overrideWithValue(database),
      sharedPreferencesProvider.overrideWithValue(
        await createTestPreferences(preferences),
      ),
    ],
  );
}

/// Lets drift streams and dependent providers catch up after a write.
Future<void> settle() async {
  for (var i = 0; i < 20; i++) {
    await Future<void>.delayed(Duration.zero);
  }
}
