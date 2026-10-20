import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/data/repositories/settings_repository.dart';
import 'package:tempo_app/domain/models/app_settings.dart';

import '../../testing/test_dependencies.dart';

void main() {
  test('returns defaults on a fresh install', () async {
    final repository = SettingsRepository(
      preferences: await createTestPreferences(),
    );

    expect(repository.current, const AppSettings());
  });

  test('update persists and emits the new settings', () async {
    final preferences = await createTestPreferences();
    final repository = SettingsRepository(preferences: preferences);
    final emitted = repository.watch().take(2).toList();

    await repository.update(
      (s) => s.copyWith(dailyGoalMinutes: 360, theme: ThemePreference.dark),
    );

    const expected = AppSettings(
      dailyGoalMinutes: 360,
      theme: ThemePreference.dark,
    );
    expect(await emitted, [const AppSettings(), expected]);
    expect(
      SettingsRepository(preferences: preferences).current,
      expected,
      reason: 'a new repository reads the persisted values',
    );
  });

  test('ignores an unknown stored theme', () async {
    final repository = SettingsRepository(
      preferences: await createTestPreferences({'theme': 'sepia'}),
    );

    expect(repository.current.theme, ThemePreference.system);
  });
}
