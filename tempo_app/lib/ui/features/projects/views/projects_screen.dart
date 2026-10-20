import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/routes.dart';
import '../../../core/widgets/screen_placeholder.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenPlaceholder(
      title: 'Projects',
      prototype: '05 · Projects.png',
      actions: [
        FilledButton.icon(
          onPressed: () => context.go(Routes.newProject),
          icon: const Icon(Icons.add),
          label: const Text('New project'),
        ),
      ],
    );
  }
}
