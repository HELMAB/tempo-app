import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/config/dependencies.dart';
import 'package:tempo_app/ui/features/onboarding/view_models/onboarding_view_model.dart';

import '../../../testing/test_dependencies.dart';

void main() {
  test('getStarted marks onboarding as complete', () async {
    final container = ProviderContainer.test(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(
          await createTestPreferences(),
        ),
      ],
    );
    final subscription = container.listen(
      onboardingViewModelProvider,
      (_, _) {},
    );

    await container.read(onboardingViewModelProvider.notifier).getStarted();

    expect(subscription.read(), const AsyncData<void>(null));
    expect(
      container.read(settingsRepositoryProvider).current.onboardingComplete,
      isTrue,
    );
  });
}
