import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/dependencies.dart';
import '../../../../domain/use_cases/period_report.dart';
import 'reports_ui_state.dart';

final reportsViewModelProvider =
    AsyncNotifierProvider.autoDispose<ReportsViewModel, ReportsUiState>(
      ReportsViewModel.new,
    );

class ReportsViewModel extends AsyncNotifier<ReportsUiState> {
  ReportPeriod _period = ReportPeriod.week;

  /// A moment inside the shown period; null follows the current one.
  DateTime? _anchor;

  @override
  Future<ReportsUiState> build() async {
    final settings = await ref.watch(appSettingsProvider.future);
    final range = ReportRange.containing(
      _anchor ?? ref.watch(clockProvider)(),
      _period,
      weekStartsOn: settings.weekStartsOn,
    );
    final previous = range.previous;
    final (entries, previousEntries, projects) = await (
      ref.watch(
        entriesBetweenProvider((from: range.start, to: range.end)).future,
      ),
      ref.watch(
        entriesBetweenProvider((from: previous.start, to: previous.end)).future,
      ),
      ref.watch(projectsProvider.future),
    ).wait;

    return ReportsUiState(
      range: range,
      entries: entries,
      previousEntries: previousEntries,
      projectsById: {for (final p in projects) p.id: p},
    );
  }

  void selectPeriod(ReportPeriod period) {
    if (period == _period) return;
    _period = period;
    ref.invalidateSelf();
  }

  void showPrevious() {
    final range = state.value?.range;
    if (range == null) return;
    _anchor = range.previous.start;
    ref.invalidateSelf();
  }

  void showNext() {
    final range = state.value?.range;
    if (range == null) return;
    final now = ref.read(clockProvider)();
    if (range.next.start.isAfter(now)) return;
    // Back to "current" once the next period contains today.
    _anchor = range.next.contains(now) ? null : range.next.start;
    ref.invalidateSelf();
  }

  Future<void> exportCsv() async {
    final range = state.value?.range;
    if (range == null) return;
    await ref
        .read(backupRepositoryProvider)
        .exportCsv(from: range.start, to: range.end);
  }
}
