import 'package:flutter/material.dart';

import '../../../core/localization.dart';
import '../../../core/widgets/screen_placeholder.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenPlaceholder(
      title: context.l10n.navReports,
      prototype: '07 · Reports.png',
    );
  }
}
