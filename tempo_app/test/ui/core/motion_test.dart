import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/ui/core/widgets/launch_overlay.dart';
import 'package:tempo_app/ui/core/widgets/motion.dart';

import '../../testing/app_tester.dart';

void main() {
  testApp('the launch intro plays once, then gets out of the way', (
    tester,
    _,
  ) async {
    // testApp has already settled, so the intro has finished.
    expect(find.byIcon(Icons.timer_outlined), findsNothing);
    expect(find.text('What are you working on?'), findsOneWidget);

    // Taps reach the app once the overlay is gone.
    await tester.tap(find.text('Add manually'));
    await tester.pumpAndSettle();
    expect(find.text('New entry'), findsOneWidget);
  }, reduceMotion: false);

  testWidgets('the launch intro starts as the native splash', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: LaunchOverlay(child: Text('app'))),
    );

    // First frame: brand blue with the white glyph covering the app.
    expect(find.byIcon(Icons.timer_outlined), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.timer_outlined), findsNothing);
    expect(find.text('app'), findsOneWidget);
  });

  testWidgets('FadeSlideIn ends fully visible in place', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: FadeSlideIn(index: 3, child: Text('row'))),
    );
    final opacity = tester.widget<FadeTransition>(
      find.descendant(
        of: find.byType(FadeSlideIn),
        matching: find.byType(FadeTransition),
      ),
    );
    expect(opacity.opacity.value, 0);

    // Past the stagger delay (no frames run while it waits), then settle.
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(opacity.opacity.value, 1);
  });

  testWidgets('reduce motion skips FadeSlideIn and the intro', (tester) async {
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

    await tester.pumpWidget(
      const MaterialApp(
        home: LaunchOverlay(child: FadeSlideIn(child: Text('row'))),
      ),
    );

    expect(find.byIcon(Icons.timer_outlined), findsNothing);
    final opacity = tester.widget<FadeTransition>(
      find.descendant(
        of: find.byType(FadeSlideIn),
        matching: find.byType(FadeTransition),
      ),
    );
    expect(opacity.opacity.value, 1);
  });
}
