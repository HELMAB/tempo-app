import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/routes.dart';
import '../../../core/formatters/duration_format.dart';
import '../../../core/localization.dart';
import '../../../core/widgets/motion.dart';
import '../../../core/widgets/progress_ring.dart';
import '../../../core/widgets/tempo_logo.dart';
import '../view_models/onboarding_view_model.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  /// Onboarding is the first screen after launch: let the reveal run first.
  static const _entranceDelay = Duration(milliseconds: 700);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(onboardingViewModelProvider, (previous, next) {
      switch (next) {
        case AsyncData() when previous is AsyncLoading:
          context.go(Routes.today);
        case AsyncError():
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.l10n.onboardingSaveError)),
          );
        default:
      }
    });

    final status = ref.watch(onboardingViewModelProvider);
    final viewModel = ref.read(onboardingViewModelProvider.notifier);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  const TempoLogo(),
                  const SizedBox(width: 8),
                  Text(
                    'Tempo',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: status.isLoading ? null : viewModel.getStarted,
                    child: Text(l10n.onboardingSkip),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: ProgressRing(
                      progress: 0.71,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CountUpDuration(
                            duration: const Duration(hours: 5, minutes: 42),
                            format: (d) => formatHoursMinutes(d, l10n),
                            style: theme.textTheme.displaySmall,
                          ),
                          Text(
                            l10n.onboardingTrackedToday,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              FadeSlideIn(
                index: 0,
                delay: OnboardingScreen._entranceDelay,
                child: Text(
                  l10n.onboardingHeadline,
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              const SizedBox(height: 12),
              FadeSlideIn(
                index: 1,
                delay: OnboardingScreen._entranceDelay,
                child: Text(
                  l10n.onboardingBody,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FadeSlideIn(
                index: 2,
                delay: OnboardingScreen._entranceDelay,
                child: _Feature(
                  icon: Icons.play_arrow_rounded,
                  label: l10n.onboardingFeatureTimer,
                ),
              ),
              FadeSlideIn(
                index: 3,
                delay: OnboardingScreen._entranceDelay,
                child: _Feature(
                  icon: Icons.folder_outlined,
                  label: l10n.onboardingFeatureProjects,
                ),
              ),
              FadeSlideIn(
                index: 4,
                delay: OnboardingScreen._entranceDelay,
                child: _Feature(
                  icon: Icons.bar_chart_outlined,
                  label: l10n.onboardingFeatureReports,
                ),
              ),
              const SizedBox(height: 32),
              FadeSlideIn(
                index: 5,
                delay: OnboardingScreen._entranceDelay,
                child: FilledButton(
                  onPressed: status.isLoading ? null : viewModel.getStarted,
                  child: Text(l10n.onboardingGetStarted),
                ),
              ),
              const SizedBox(height: 8),
              FadeSlideIn(
                index: 6,
                delay: OnboardingScreen._entranceDelay,
                child: Center(
                  child: TextButton(
                    onPressed: status.isLoading
                        ? null
                        : () => _restore(context, viewModel),
                    child: Text(l10n.backupRestore),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _restore(
  BuildContext context,
  OnboardingViewModel viewModel,
) async {
  final l10n = context.l10n;
  try {
    await viewModel.restoreFromBackup(fileTypeLabel: l10n.backupFileType);
  } on FormatException {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.restoreInvalid)));
    }
  }
}

class _Feature extends StatelessWidget {
  const _Feature({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(icon, color: colors.primary, size: 20),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
