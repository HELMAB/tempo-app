import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/routes.dart';
import '../../../core/widgets/screen_placeholder.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenPlaceholder(
      title: 'Today',
      prototype: '02 · Today (Home).png',
      actions: [
        FilledButton.icon(
          onPressed: () => context.push(Routes.timer),
          icon: const Icon(Icons.play_arrow_rounded),
          label: const Text('Start timer'),
        ),
        OutlinedButton.icon(
          onPressed: () => context.push(Routes.newEntry),
          icon: const Icon(Icons.add),
          label: const Text('Add manually'),
        ),
      ],
    );
  }
}
