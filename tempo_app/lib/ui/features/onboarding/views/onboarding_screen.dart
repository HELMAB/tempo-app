import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/routes.dart';
import '../view_models/onboarding_view_model.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(onboardingViewModelProvider, (previous, next) {
      switch (next) {
        case AsyncData() when previous is AsyncLoading:
          context.go(Routes.today);
        case AsyncError():
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not save, please try again.')),
          );
        default:
      }
    });

    final status = ref.watch(onboardingViewModelProvider);
    final viewModel = ref.read(onboardingViewModelProvider.notifier);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

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
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        Icons.timer_outlined,
                        color: colors.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('Tempo', style: theme.textTheme.titleLarge),
                  const Spacer(),
                  TextButton(
                    onPressed: status.isLoading ? null : viewModel.getStarted,
                    child: const Text('Skip'),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                'Know where your hours go.',
                style: theme.textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(
                'Start a timer in one tap, sort your time by project, '
                'and see your week at a glance.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              const _Feature(
                icon: Icons.play_arrow_rounded,
                label: 'One-tap start and stop',
              ),
              const _Feature(
                icon: Icons.folder_outlined,
                label: 'Projects with weekly goals',
              ),
              const _Feature(
                icon: Icons.bar_chart_outlined,
                label: 'Weekly reports, offline-first',
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: status.isLoading ? null : viewModel.getStarted,
                child: const Text('Get started'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
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
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
