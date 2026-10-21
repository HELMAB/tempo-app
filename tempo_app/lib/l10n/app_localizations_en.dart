// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navToday => 'Today';

  @override
  String get navProjects => 'Projects';

  @override
  String get navReports => 'Reports';

  @override
  String get navSettings => 'Settings';

  @override
  String get noProject => 'No project';

  @override
  String get noDescription => 'No description';

  @override
  String get projectPickerTitle => 'Project';

  @override
  String get cancel => 'Cancel';

  @override
  String get add => 'Add';

  @override
  String get close => 'Close';

  @override
  String get more => 'More';

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String durationMinutes(int minutes) {
    return '${minutes}m';
  }

  @override
  String durationHours(int hours) {
    return '${hours}h';
  }

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingTrackedToday => 'tracked today';

  @override
  String get onboardingHeadline => 'Know where your hours go.';

  @override
  String get onboardingBody =>
      'Start a timer in one tap, sort your time by project, and see your week at a glance.';

  @override
  String get onboardingFeatureTimer => 'One-tap start and stop';

  @override
  String get onboardingFeatureProjects => 'Projects with weekly goals';

  @override
  String get onboardingFeatureReports => 'Weekly reports, offline-first';

  @override
  String get onboardingGetStarted => 'Get started';

  @override
  String get onboardingSaveError => 'Could not save, please try again.';

  @override
  String get todayLoadError => 'Could not load today.';

  @override
  String get trackedToday => 'Tracked today';

  @override
  String goalProgress(int percent, String goal) {
    return '$percent% of $goal goal';
  }

  @override
  String get quickStartHint => 'What are you working on?';

  @override
  String get startTimer => 'Start timer';

  @override
  String get stopTimer => 'Stop timer';

  @override
  String get entriesTitle => 'Entries';

  @override
  String get addManually => 'Add manually';

  @override
  String get entriesEmpty =>
      'No entries yet. Start a timer or add one manually.';

  @override
  String get continueEntry => 'Continue';

  @override
  String get timerLoadError => 'Could not load the timer.';

  @override
  String get timerNothingRunning => 'No timer running';

  @override
  String get backToToday => 'Back to Today';

  @override
  String get timerTracking => 'Tracking';

  @override
  String get timerPaused => 'Paused';

  @override
  String focusGoal(String goal) {
    return 'of $goal focus goal';
  }

  @override
  String get timerStarted => 'Started';

  @override
  String get timerDiscard => 'Discard';

  @override
  String get timerStopAndSave => 'Stop & save';

  @override
  String get timerPause => 'Pause';

  @override
  String get timerResume => 'Resume';

  @override
  String get timerNote => 'Note';

  @override
  String get timerNoteHint => 'What did you get done?';

  @override
  String get timerAddTag => '+ Tag';

  @override
  String get editEntry => 'Edit entry';

  @override
  String get discardDialogTitle => 'Discard this timer?';

  @override
  String get discardDialogBody =>
      'The time tracked in this session is not saved.';

  @override
  String get discardDialogKeep => 'Keep';

  @override
  String get newTagTitle => 'New tag';

  @override
  String get newTagHint => 'e.g. Deep work';

  @override
  String get newEntryTitle => 'New entry';

  @override
  String get newProjectTitle => 'New project';

  @override
  String screenNotBuilt(String file) {
    return 'Not built yet · see prototype/$file';
  }

  @override
  String get settingsLanguage => 'Language';

  @override
  String get timeNow => 'now';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get saveFailed => 'Could not save, please try again.';

  @override
  String get entryDescription => 'Description';

  @override
  String get entryDescriptionHint => 'What did you work on?';

  @override
  String get entryDate => 'Date';

  @override
  String get entryStart => 'Start';

  @override
  String get entryEnd => 'End';

  @override
  String get entryDuration => 'Duration';

  @override
  String get entryTags => 'Tags';

  @override
  String get entryNewTag => '+ New tag';

  @override
  String get entryNoteHint => 'Anything worth remembering?';

  @override
  String get entryRunning => 'Running';

  @override
  String get entryDelete => 'Delete entry';

  @override
  String get entryDeleteTitle => 'Delete this entry?';

  @override
  String get entryDeleteBody => 'This can\'t be undone.';

  @override
  String get entryEndBeforeStart => 'End must be after start.';

  @override
  String get entryStartInFuture => 'Start can\'t be in the future.';

  @override
  String get entryNotFound => 'This entry no longer exists.';

  @override
  String get entryLoadError => 'Could not load the entry.';

  @override
  String get projectsLoadError => 'Could not load projects.';

  @override
  String get projectsThisWeek => 'This week';

  @override
  String get projectsAllTime => 'All time';

  @override
  String get projectsEmpty =>
      'No projects yet. Create one to set a weekly goal.';

  @override
  String projectTotal(Object tracked) {
    return '$tracked in total';
  }

  @override
  String get editProjectTitle => 'Edit project';

  @override
  String get projectName => 'Name';

  @override
  String get projectNameHint => 'e.g. Side project';

  @override
  String get projectColour => 'Colour';

  @override
  String get projectWeeklyGoal => 'Weekly goal';

  @override
  String get projectNoGoal => 'No weekly goal';

  @override
  String get projectDecreaseGoal => 'Decrease weekly goal';

  @override
  String get projectIncreaseGoal => 'Increase weekly goal';

  @override
  String get projectCountsTowardDaily => 'Count toward daily goal';

  @override
  String get projectCreate => 'Create project';

  @override
  String get projectArchive => 'Archive project';

  @override
  String get projectRestore => 'Restore project';

  @override
  String get projectNotFound => 'This project no longer exists.';

  @override
  String projectsActiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count active',
    );
    return '$_temp0';
  }

  @override
  String projectGoalProgress(String tracked, String goal) {
    return '$tracked of $goal goal';
  }

  @override
  String projectsArchivedCount(int count) {
    return 'Archived · $count';
  }

  @override
  String projectGoalPerDay(String perDay) {
    return 'about $perDay a day';
  }

  @override
  String projectCountsTowardDailyBody(String goal) {
    return 'Adds this project\'s time to your $goal target';
  }

  @override
  String projectColourLabel(int number) {
    return 'Colour $number';
  }

  @override
  String get reportsLoadError => 'Could not load reports.';

  @override
  String get reportsDay => 'Day';

  @override
  String get reportsWeek => 'Week';

  @override
  String get reportsMonth => 'Month';

  @override
  String get reportsExport => 'Export CSV';

  @override
  String get reportsPrevious => 'Previous';

  @override
  String get reportsNext => 'Next';

  @override
  String get reportsTotalToday => 'Total today';

  @override
  String get reportsTotalThisWeek => 'Total this week';

  @override
  String get reportsTotalThisMonth => 'Total this month';

  @override
  String get reportsTotal => 'Total';

  @override
  String get reportsByProject => 'By project';

  @override
  String get reportsEmpty => 'Nothing tracked in this period.';

  @override
  String get exportFailed => 'Could not export, please try again.';

  @override
  String get settingsTracking => 'Tracking';

  @override
  String get settingsDailyGoal => 'Daily goal';

  @override
  String get settingsWeekStartsOn => 'Week starts on';

  @override
  String get settingsIdleDetection => 'Idle detection';

  @override
  String get settingsReminders => 'Reminders';

  @override
  String get settingsRemindToStart => 'Remind me to start';

  @override
  String get settingsRunningTimerNotification => 'Running timer notification';

  @override
  String get settingsRunningTimerNotificationBody =>
      'Shows the running timer on the lock screen';

  @override
  String get settingsNotificationsUnavailable => 'Not available on this device';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get settingsData => 'Data';

  @override
  String get settingsExportCsv => 'Export as CSV';

  @override
  String get settingsBackup => 'Backup & restore';

  @override
  String get backupCreate => 'Create backup';

  @override
  String get backupCreateBody => 'Save all projects and entries to a file.';

  @override
  String get backupRestore => 'Restore from a backup';

  @override
  String get backupRestoreBody => 'Replace everything with a backup file.';

  @override
  String get backupFileType => 'Tempo backup';

  @override
  String get restoreConfirmTitle => 'Replace all data?';

  @override
  String get restoreConfirmBody =>
      'Projects and entries on this device will be replaced by the backup.';

  @override
  String get restoreConfirm => 'Replace';

  @override
  String get restoreInvalid => 'That file is not a Tempo backup.';

  @override
  String get notificationsDenied =>
      'Notifications are turned off for Tempo in system settings.';

  @override
  String get decrease => 'Decrease';

  @override
  String get increase => 'Increase';

  @override
  String get idleBody =>
      'Your timer kept running while you were away. Keep that time?';

  @override
  String get idleKeep => 'Keep it';

  @override
  String get reminderTitle => 'Time to start tracking';

  @override
  String get reminderBody => 'Start a timer for what you\'re working on.';

  @override
  String get reminderChannel => 'Reminders';

  @override
  String get runningTimerChannel => 'Running timer';

  @override
  String get runningTimerFallbackTitle => 'Timer running';

  @override
  String reportsVsLast(String diff, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'day': 'yesterday',
      'week': 'last week',
      'other': 'last month',
    });
    return '$diff vs $_temp0';
  }

  @override
  String reportsVsPrevious(String diff, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'day': 'the day before',
      'week': 'the week before',
      'other': 'the month before',
    });
    return '$diff vs $_temp0';
  }

  @override
  String reportsAverage(String duration) {
    return 'avg $duration';
  }

  @override
  String durationCompact(int hours, String minutes) {
    return '${hours}h$minutes';
  }

  @override
  String settingsIdleDetectionBody(int minutes) {
    return 'Ask when I\'m back after $minutes min away';
  }

  @override
  String settingsRemindToStartBody(String time) {
    return 'Weekdays at $time';
  }

  @override
  String settingsVersion(String version) {
    return 'Tempo $version';
  }

  @override
  String restoreDone(int projects, int entries) {
    return 'Restored $projects projects and $entries entries.';
  }

  @override
  String idleTitle(String duration) {
    return 'You were away for $duration';
  }

  @override
  String idleStopAt(String time) {
    return 'Stop at $time';
  }

  @override
  String runningTimerBody(String time) {
    return 'Started at $time';
  }
}
