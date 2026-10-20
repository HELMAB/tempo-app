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
}
