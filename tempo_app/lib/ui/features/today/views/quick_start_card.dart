import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/routes.dart';
import '../../../core/formatters/duration_format.dart';
import '../../../core/localization.dart';
import '../../../core/themes/app_motion.dart';
import '../../../core/widgets/motion.dart';
import '../../../core/widgets/project_chip.dart';
import '../../../core/widgets/project_picker_sheet.dart';
import '../view_models/today_ui_state.dart';
import '../view_models/today_view_model.dart';

/// "What are you working on?" + project + start. While a timer runs it
/// shows that timer instead, and tapping it opens the timer screen.
class QuickStartCard extends ConsumerStatefulWidget {
  const QuickStartCard({super.key, required this.state, required this.now});

  final TodayUiState state;
  final DateTime now;

  @override
  ConsumerState<QuickStartCard> createState() => _QuickStartCardState();
}

class _QuickStartCardState extends ConsumerState<QuickStartCard> {
  final _description = TextEditingController();

  @override
  void dispose() {
    _description.dispose();
    super.dispose();
  }

  TodayViewModel get _viewModel => ref.read(todayViewModelProvider.notifier);

  Future<void> _start() async {
    await HapticFeedback.mediumImpact();
    await _viewModel.startTimer(description: _description.text);
    _description.clear();
    if (mounted) await context.push(Routes.timer);
  }

  Future<void> _stop() async {
    await HapticFeedback.lightImpact();
    await _viewModel.stopTimer();
  }

  Future<void> _pickProject() async {
    final choice = await showProjectPicker(
      context,
      projects: widget.state.projects,
      selectedId: widget.state.quickStartProject?.id,
    );
    if (choice != null) _viewModel.selectQuickStartProject(choice.projectId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final running = widget.state.running;
    final l10n = context.l10n;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: running == null ? null : () => context.push(Routes.timer),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
          child: Row(
            children: [
              Expanded(
                // Grows / shrinks smoothly between idle and running.
                child: AnimatedSize(
                  duration: AppMotion.of(context, AppMotion.medium),
                  curve: AppMotion.move,
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (running == null)
                        TextField(
                          controller: _description,
                          textInputAction: TextInputAction.go,
                          onSubmitted: (_) => _start(),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: l10n.quickStartHint,
                            isCollapsed: true,
                            filled: false,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        )
                      else
                        Text(
                          running.entry.description.isEmpty
                              ? l10n.noDescription
                              : running.entry.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium,
                        ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Flexible(
                            child: ProjectChip(
                              project: running == null
                                  ? widget.state.quickStartProject
                                  : running.project,
                              onPressed: running == null ? _pickProject : null,
                            ),
                          ),
                          if (running != null) ...[
                            const SizedBox(width: 12),
                            Text(
                              formatClock(running.entry.durationAt(widget.now)),
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontFeatures: const [
                                  FontFeature.tabularFigures(),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton.filled(
                iconSize: 32,
                style: IconButton.styleFrom(minimumSize: const Size.square(64)),
                tooltip: running == null ? l10n.startTimer : l10n.stopTimer,
                onPressed: running == null ? _start : _stop,
                icon: ScaleSwitcher(
                  child: Icon(
                    running == null
                        ? Icons.play_arrow_rounded
                        : Icons.stop_rounded,
                    key: ValueKey(running == null),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
