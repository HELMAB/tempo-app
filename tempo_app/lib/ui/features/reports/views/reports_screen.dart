import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/use_cases/period_report.dart';
import '../../../core/formatters/date_format.dart';
import '../../../core/formatters/duration_format.dart';
import '../../../core/localization.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/widgets/clock_builder.dart';
import '../../../core/widgets/pill_segmented_control.dart';
import '../view_models/reports_ui_state.dart';
import '../view_models/reports_view_model.dart';
import 'project_breakdown.dart';
import 'report_chart.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reportsViewModelProvider);

    return SafeArea(
      child: switch (state) {
        AsyncValue(:final value?) => ClockBuilder(
          ticking: value.hasRunningEntry,
          builder: (context, now) => _ReportsContent(state: value, now: now),
        ),
        AsyncError(:final error) => Center(
          child: Text('${context.l10n.reportsLoadError}\n$error'),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _ReportsContent extends ConsumerWidget {
  const _ReportsContent({required this.state, required this.now});

  final ReportsUiState state;
  final DateTime now;

  Future<void> _export(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(reportsViewModelProvider.notifier).exportCsv();
    } on Exception {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.l10n.exportFailed)));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final l10n = context.l10n;
    final viewModel = ref.read(reportsViewModelProvider.notifier);
    final report = state.reportAt(now);
    final period = state.range.period;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.navReports,
                style: theme.textTheme.headlineMedium,
              ),
            ),
            IconButton.outlined(
              tooltip: l10n.reportsExport,
              style: IconButton.styleFrom(
                minimumSize: const Size.square(48),
                backgroundColor: colors.surface,
                side: BorderSide(color: colors.outlineVariant),
              ),
              onPressed: () => _export(context, ref),
              icon: const Icon(Icons.download_outlined),
            ),
          ],
        ),
        const SizedBox(height: 16),
        PillSegmentedControl<ReportPeriod>(
          segments: [
            (value: ReportPeriod.day, label: l10n.reportsDay),
            (value: ReportPeriod.week, label: l10n.reportsWeek),
            (value: ReportPeriod.month, label: l10n.reportsMonth),
          ],
          selected: period,
          onChanged: viewModel.selectPeriod,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              tooltip: l10n.reportsPrevious,
              onPressed: viewModel.showPrevious,
              icon: const Icon(Icons.chevron_left),
            ),
            Expanded(
              child: Text(
                formatReportRange(state.range, l10n),
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium,
              ),
            ),
            IconButton(
              tooltip: l10n.reportsNext,
              onPressed: state.canShowNextAt(now) ? viewModel.showNext : null,
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _totalLabel(l10n, period, current: state.isCurrentAt(now)),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      Text(
                        formatHoursMinutes(report.total, l10n),
                        style: theme.textTheme.displaySmall,
                      ),
                      _ComparisonChip(
                        state: state,
                        total: report.total,
                        now: now,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ReportChart(
                  range: state.range,
                  report: report,
                  average: state.averageAt(now, report),
                  now: now,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ProjectBreakdown(report: report, projectsById: state.projectsById),
      ],
    );
  }

  static String _totalLabel(
    AppLocalizations l10n,
    ReportPeriod period, {
    required bool current,
  }) {
    if (!current) return l10n.reportsTotal;
    return switch (period) {
      ReportPeriod.day => l10n.reportsTotalToday,
      ReportPeriod.week => l10n.reportsTotalThisWeek,
      ReportPeriod.month => l10n.reportsTotalThisMonth,
    };
  }
}

/// "+3h 20m vs last week" — green when up, red when down.
class _ComparisonChip extends StatelessWidget {
  const _ComparisonChip({
    required this.state,
    required this.total,
    required this.now,
  });

  final ReportsUiState state;
  final Duration total;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final previous = state.previousTotalAt(now);
    if (total == Duration.zero && previous == Duration.zero) {
      return const SizedBox.shrink();
    }
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final diff = total - previous;
    final colour = diff.isNegative
        ? theme.colorScheme.error
        : AppColors.success;
    final signed = formatSignedHoursMinutes(diff, l10n);
    final period = state.range.period.name;

    return DecoratedBox(
      decoration: ShapeDecoration(
        color: colour.withValues(alpha: 0.12),
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Text(
          state.isCurrentAt(now)
              ? l10n.reportsVsLast(signed, period)
              : l10n.reportsVsPrevious(signed, period),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colour,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
