import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/dependencies.dart';
import '../../../../domain/models/app_settings.dart';

final settingsViewModelProvider =
    AsyncNotifierProvider.autoDispose<SettingsViewModel, AppSettings>(
      SettingsViewModel.new,
    );

class SettingsViewModel extends AsyncNotifier<AppSettings> {
  @override
  Future<AppSettings> build() => ref.watch(appSettingsProvider.future);

  Future<void> setLanguage(AppLanguage language) => ref
      .read(settingsRepositoryProvider)
      .update((settings) => settings.copyWith(language: language));
}
