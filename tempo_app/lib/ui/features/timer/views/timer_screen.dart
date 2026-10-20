import 'package:flutter/material.dart';

import '../../../core/widgets/screen_placeholder.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const ScreenPlaceholder(
        title: 'Running timer',
        prototype: '03 · Running timer.png',
      ),
    );
  }
}
