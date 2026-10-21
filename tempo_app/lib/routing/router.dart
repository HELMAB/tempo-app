import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../config/dependencies.dart';
import '../ui/core/widgets/app_shell.dart';
import '../ui/core/widgets/fade_through_branches.dart';
import '../ui/core/widgets/modal_bottom_sheet_page.dart';
import '../ui/features/entry_editor/views/entry_editor_screen.dart';
import '../ui/features/onboarding/views/onboarding_screen.dart';
import '../ui/features/projects/views/project_sheet.dart';
import '../ui/features/projects/views/projects_screen.dart';
import '../ui/features/reports/views/reports_screen.dart';
import '../ui/features/settings/views/settings_screen.dart';
import '../ui/features/timer/views/timer_screen.dart';
import '../ui/features/today/views/today_screen.dart';
import 'routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final settings = ref.watch(settingsRepositoryProvider);
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.today,
    redirect: (context, state) {
      final onboarded = settings.current.onboardingComplete;
      final atOnboarding = state.matchedLocation == Routes.onboarding;
      if (!onboarded && !atOnboarding) return Routes.onboarding;
      if (onboarded && atOnboarding) return Routes.today;
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      StatefulShellRoute(
        builder: (context, state, shell) => AppShell(navigationShell: shell),
        navigatorContainerBuilder: (context, shell, children) =>
            FadeThroughBranches(
              currentIndex: shell.currentIndex,
              children: children,
            ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.today,
                builder: (context, state) => const TodayScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.projects,
                builder: (context, state) => const ProjectsScreen(),
                routes: [
                  // `new` is declared before `:id` so it is matched first.
                  GoRoute(
                    path: 'new',
                    parentNavigatorKey: rootNavigatorKey,
                    pageBuilder: (context, state) => ModalBottomSheetPage<void>(
                      key: state.pageKey,
                      child: const ProjectSheet(),
                    ),
                  ),
                  GoRoute(
                    path: ':id',
                    parentNavigatorKey: rootNavigatorKey,
                    redirect: (context, state) =>
                        int.tryParse(state.pathParameters['id']!) == null
                        ? Routes.projects
                        : null,
                    pageBuilder: (context, state) => ModalBottomSheetPage<void>(
                      key: state.pageKey,
                      child: ProjectSheet(
                        projectId: int.parse(state.pathParameters['id']!),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.reports,
                builder: (context, state) => const ReportsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.settings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: Routes.timer,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          fullscreenDialog: true,
          child: const TimerScreen(),
        ),
      ),
      // `new` is declared before `:id` so it is matched first.
      GoRoute(
        path: Routes.newEntry,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          fullscreenDialog: true,
          child: const EntryEditorScreen(),
        ),
      ),
      GoRoute(
        path: '/entry/:id',
        redirect: (context, state) =>
            int.tryParse(state.pathParameters['id']!) == null
            ? Routes.today
            : null,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          fullscreenDialog: true,
          child: EntryEditorScreen(
            entryId: int.parse(state.pathParameters['id']!),
          ),
        ),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
