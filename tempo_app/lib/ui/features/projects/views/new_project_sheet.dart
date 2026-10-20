import 'package:flutter/material.dart';

import '../../../core/widgets/screen_placeholder.dart';

class NewProjectSheet extends StatelessWidget {
  const NewProjectSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 320,
      child: ScreenPlaceholder(
        title: 'New project',
        prototype: '06 · New project (sheet).png',
      ),
    );
  }
}
