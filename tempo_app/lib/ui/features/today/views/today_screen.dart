import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/formatters/date_format.dart';
import '../../../core/localization.dart';
import '../../../core/widgets/clock_builder.dart';
import '../view_models/today_ui_state.dart';
import '../view_models/today_view_model.dart';
import 'entry_list.dart';
import 'quick_start_card.dart';
import 'tracked_card.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(todayViewModelProvider);

    return SafeArea(
      child: switch (state) {
        AsyncValue(:final value?) => _TodayContent(state: value),
        AsyncError(:final error) => Center(
          child: Text('${context.l10n.todayLoadError}\n$error'),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _TodayContent extends StatelessWidget {
  const _TodayContent({required this.state});

  final TodayUiState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClockBuilder(
      ticking: state.running != null,
      builder: (context, now) => ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
        children: [
          Text(
            formatDayHeading(state.day, context.l10n),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Text(context.l10n.navToday, style: theme.textTheme.headlineMedium),
          const SizedBox(height: 16),
          TrackedCard(progress: state.progressAt(now)),
          const SizedBox(height: 16),
          QuickStartCard(state: state, now: now),
          const SizedBox(height: 32),
          EntryList(entries: state.entries, now: now),
        ],
      ),
    );
  }
}
