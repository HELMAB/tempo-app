import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tempo_app/config/dependencies.dart';
import 'package:tempo_app/domain/use_cases/period_report.dart';
import 'package:tempo_app/ui/features/reports/view_models/reports_ui_state.dart';
import 'package:tempo_app/ui/features/reports/view_models/reports_view_model.dart';

import '../../../testing/test_dependencies.dart';

void main() {
  // Tuesday 20 October 2026, 17:00; Monday weeks.
  final now = DateTime(2026, 10, 20, 17);
  late ProviderContainer container;

  setUp(() async {
    container = await createTestContainer(clock: () => now);
    container.listen(reportsViewModelProvider, (_, _) {});
  });

  Future<ReportsUiState> state() async {
    await settle();
    return container.read(reportsViewModelProvider.future);
  }

  ReportsViewModel viewModel() =>
      container.read(reportsViewModelProvider.notifier);

  Future<void> add(DateTime start, Duration length) => container
      .read(timeEntryRepositoryProvider)
      .addEntry(startAt: start, endAt: start.add(length));

  test('starts on the current week', () async {
    await add(DateTime(2026, 10, 19, 9), const Duration(hours: 4));
    await add(DateTime(2026, 10, 20, 9), const Duration(hours: 2));

    final week = await state();
    expect(week.range.period, ReportPeriod.week);
    expect(week.range.start, DateTime(2026, 10, 19));
    expect(week.isCurrentAt(now), isTrue);
    expect(week.canShowNextAt(now), isFalse);
    final report = week.reportAt(now);
    expect(report.total, const Duration(hours: 6));
    expect(week.averageAt(now, report), const Duration(hours: 3));
  });

  test('compares with the same part of the previous week', () async {
    // Last Monday: 3h; last Wednesday: 5h (after "now" in that week).
    await add(DateTime(2026, 10, 12, 9), const Duration(hours: 3));
    await add(DateTime(2026, 10, 14, 9), const Duration(hours: 5));
    await add(DateTime(2026, 10, 19, 9), const Duration(hours: 4));

    final week = await state();
    expect(week.previousTotalAt(now), const Duration(hours: 3));
  });

  test('navigates back and forward, and switches period', () async {
    await state();
    viewModel().showPrevious();
    final previous = await state();
    expect(previous.range.start, DateTime(2026, 10, 12));
    expect(previous.canShowNextAt(now), isTrue);

    viewModel().showNext();
    expect((await state()).range.start, DateTime(2026, 10, 19));

    viewModel().selectPeriod(ReportPeriod.month);
    final month = await state();
    expect(month.range.start, DateTime(2026, 10));
    expect(month.range.buckets, hasLength(31));
  });
}
