/// Paths from the user flow (prototype/User flow.png).
abstract final class Routes {
  static const onboarding = '/onboarding';

  // Bottom tabs (StatefulShellRoute branches).
  static const today = '/';
  static const projects = '/projects';
  static const reports = '/reports';
  static const settings = '/settings';

  // Full-screen routes above the shell.
  static const timer = '/timer';
  static const newEntry = '/entry/new';
  static String entry(int id) => '/entry/$id';

  /// Bottom sheets over the Projects tab.
  static const newProject = '/projects/new';
  static String project(int id) => '/projects/$id';
}
