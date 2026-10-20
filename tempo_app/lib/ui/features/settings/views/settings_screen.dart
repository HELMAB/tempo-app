import 'package:flutter/material.dart';

import '../../../core/widgets/screen_placeholder.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenPlaceholder(
      title: 'Settings',
      prototype: '08 · Settings.png',
    );
  }
}
