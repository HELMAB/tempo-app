import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/use_cases/period_report.dart';
import '../../../core/formatters/duration_format.dart';
import '../../../core/localization.dart';
import '../../../core/themes/app_motion.dart';

/// Bars per hour (day), per day (week, with values on top) or per day of
/// the month, plus a dashed average line.
class ReportChart extends StatelessWidget {
  const ReportChart({
    super.key,
    required this.range,
    required this.report,
    required this.average,
    required this.now,
  });

  final ReportRange range;
  final PeriodReport report;
  final Duration? average;
  final DateTime now;

  static double _hours(Duration d) => d.inSeconds / Duration.secondsPerHour;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final l10n = context.l10n;
    final buckets = range.buckets;
    final week = range.period == ReportPeriod.week;
    final currentIndex = buckets.lastIndexWhere((b) => !b.isAfter(now));
    final showsCurrent = range.contains(now);

    final peak = report.buckets.fold(
      0.0,
      (peak, bucket) => _hours(bucket) > peak ? _hours(bucket) : peak,
    );
    // Head-room for the labels above the bars; never flatter than 1h.
    final maxY = (peak * 1.3).clamp(1.0, double.infinity);
    final labelStyle = theme.textTheme.bodySmall?.copyWith(
      color: colors.onSurfaceVariant,
    );

    return SizedBox(
      height: 220,
      // Bars grow from the baseline whenever the shown period changes.
      child: TweenAnimationBuilder<double>(
        key: ValueKey(range),
        tween: Tween(begin: 0, end: 1),
        duration: AppMotion.of(context, AppMotion.long),
        curve: AppMotion.enter,
        builder: (context, grow, _) => LayoutBuilder(
          builder: (context, constraints) {
            final slot = constraints.maxWidth / buckets.length;
            final barWidth = (slot * 0.62).clamp(3.0, 40.0);

            return BarChart(
              BarChartData(
                maxY: maxY,
                alignment: BarChartAlignment.spaceAround,
                barTouchData: const BarTouchData(enabled: false),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        final label = _bottomLabel(index, l10n);
                        final today = showsCurrent && index == currentIndex;
                        return SideTitleWidget(
                          meta: meta,
                          child: Text(
                            label,
                            style: today && week
                                ? labelStyle?.copyWith(
                                    color: colors.primary,
                                    fontWeight: FontWeight.w700,
                                  )
                                : labelStyle,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                extraLinesData: ExtraLinesData(
                  horizontalLines: [
                    if (average case final average?
                        when average > Duration.zero)
                      HorizontalLine(
                        y: _hours(average),
                        color: colors.outline,
                        strokeWidth: 1,
                        dashArray: const [4, 4],
                        label: HorizontalLineLabel(
                          show: true,
                          alignment: Alignment.topRight,
                          padding: const EdgeInsets.only(bottom: 2),
                          style: labelStyle,
                          labelResolver: (_) => l10n.reportsAverage(
                            formatGoal(_roundToMinute(average), l10n),
                          ),
                        ),
                      ),
                  ],
                ),
                barGroups: [
                  for (final (index, bucket) in report.buckets.indexed)
                    BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: _hours(bucket) * grow,
                          width: barWidth,
                          color: showsCurrent && index == currentIndex
                              ? colors.onPrimaryContainer
                              : colors.primary,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(barWidth / 3),
                          ),
                          label: BarChartRodLabel(
                            show: week && bucket > Duration.zero,
                            text: formatCompact(bucket, l10n),
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              // Our grow tween drives the motion; fl_chart's own would fight it.
              duration: Duration.zero,
            );
          },
        ),
      ),
    );
  }

  String _bottomLabel(int index, AppLocalizations l10n) {
    final bucket = range.buckets[index];
    return switch (range.period) {
      ReportPeriod.day => index % 6 == 0 ? DateFormat('HH').format(bucket) : '',
      ReportPeriod.week =>
        range.contains(now) && _sameDay(bucket, now)
            ? l10n.navToday
            : DateFormat('EEE', l10n.localeName).format(bucket),
      ReportPeriod.month =>
        bucket.day == 1 || bucket.day % 5 == 0 ? '${bucket.day}' : '',
    };
  }

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static Duration _roundToMinute(Duration d) =>
      Duration(minutes: (d.inSeconds / 60).round());
}
