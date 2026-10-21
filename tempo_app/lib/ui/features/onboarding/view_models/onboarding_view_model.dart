import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/dependencies.dart';

final onboardingViewModelProvider =
    NotifierProvider.autoDispose<OnboardingViewModel, AsyncValue<void>>(
      OnboardingViewModel.new,
    );

/// State is the status of the "Get started" command.
class OnboardingViewModel extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> getStarted() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(settingsRepositoryProvider)
          .update((settings) => settings.copyWith(onboardingComplete: true)),
    );
  }

  /// Restores a backup, then finishes onboarding. False when the user
  /// cancels the file picker; throws [FormatException] for a file that
  /// isn't a Tempo backup.
  Future<bool> restoreFromBackup({required String fileTypeLabel}) async {
    final backups = ref.read(backupRepositoryProvider);
    final backup = await backups.pickBackup(fileTypeLabel: fileTypeLabel);
    if (backup == null) return false;
    await backups.restore(backup);
    await getStarted();
    return true;
  }
}
