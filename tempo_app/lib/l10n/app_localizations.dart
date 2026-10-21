import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_km.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('km'),
  ];

  /// Bottom tab and Today screen title.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get navToday;

  /// Bottom tab and Projects screen title.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get navProjects;

  /// Bottom tab and Reports screen title.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get navReports;

  /// Bottom tab and Settings screen title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// Shown instead of a project name when an entry has none.
  ///
  /// In en, this message translates to:
  /// **'No project'**
  String get noProject;

  /// Shown when a time entry has an empty description.
  ///
  /// In en, this message translates to:
  /// **'No description'**
  String get noDescription;

  /// Title of the bottom sheet for choosing a project.
  ///
  /// In en, this message translates to:
  /// **'Project'**
  String get projectPickerTitle;

  /// Dismisses a dialog without changes.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Confirms adding an item in a dialog.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// Tooltip for a button that closes the screen.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Tooltip for the overflow menu button.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// A duration of whole hours plus minutes, e.g. 5h 42m. Minutes are zero-padded.
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m'**
  String durationHoursMinutes(int hours, String minutes);

  /// A duration under one hour, e.g. 48m.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m'**
  String durationMinutes(int minutes);

  /// A whole number of hours, used for goals, e.g. 8h.
  ///
  /// In en, this message translates to:
  /// **'{hours}h'**
  String durationHours(int hours);

  /// Skips onboarding.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// Caption under the sample total in the onboarding ring.
  ///
  /// In en, this message translates to:
  /// **'tracked today'**
  String get onboardingTrackedToday;

  /// Onboarding headline.
  ///
  /// In en, this message translates to:
  /// **'Know where your hours go.'**
  String get onboardingHeadline;

  /// Onboarding body text.
  ///
  /// In en, this message translates to:
  /// **'Start a timer in one tap, sort your time by project, and see your week at a glance.'**
  String get onboardingBody;

  /// Onboarding feature list item.
  ///
  /// In en, this message translates to:
  /// **'One-tap start and stop'**
  String get onboardingFeatureTimer;

  /// Onboarding feature list item.
  ///
  /// In en, this message translates to:
  /// **'Projects with weekly goals'**
  String get onboardingFeatureProjects;

  /// Onboarding feature list item.
  ///
  /// In en, this message translates to:
  /// **'Weekly reports, offline-first'**
  String get onboardingFeatureReports;

  /// Finishes onboarding and opens Today.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get onboardingGetStarted;

  /// Snackbar when finishing onboarding fails.
  ///
  /// In en, this message translates to:
  /// **'Could not save, please try again.'**
  String get onboardingSaveError;

  /// Error shown when Today fails to load.
  ///
  /// In en, this message translates to:
  /// **'Could not load today.'**
  String get todayLoadError;

  /// Label of the daily total card.
  ///
  /// In en, this message translates to:
  /// **'Tracked today'**
  String get trackedToday;

  /// Progress toward the daily goal, e.g. 71% of 8h goal.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of {goal} goal'**
  String goalProgress(int percent, String goal);

  /// Hint of the quick-start description field.
  ///
  /// In en, this message translates to:
  /// **'What are you working on?'**
  String get quickStartHint;

  /// Tooltip of the button that starts a timer.
  ///
  /// In en, this message translates to:
  /// **'Start timer'**
  String get startTimer;

  /// Tooltip of the button that stops the running timer.
  ///
  /// In en, this message translates to:
  /// **'Stop timer'**
  String get stopTimer;

  /// Section title above today's time entries.
  ///
  /// In en, this message translates to:
  /// **'Entries'**
  String get entriesTitle;

  /// Opens the editor to add a time entry by hand.
  ///
  /// In en, this message translates to:
  /// **'Add manually'**
  String get addManually;

  /// Shown when today has no entries.
  ///
  /// In en, this message translates to:
  /// **'No entries yet. Start a timer or add one manually.'**
  String get entriesEmpty;

  /// Tooltip: starts a new timer with the same details as an entry.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueEntry;

  /// Error shown when the timer screen fails to load.
  ///
  /// In en, this message translates to:
  /// **'Could not load the timer.'**
  String get timerLoadError;

  /// Timer screen when nothing is running.
  ///
  /// In en, this message translates to:
  /// **'No timer running'**
  String get timerNothingRunning;

  /// Button that returns to the Today screen.
  ///
  /// In en, this message translates to:
  /// **'Back to Today'**
  String get backToToday;

  /// Timer status while running.
  ///
  /// In en, this message translates to:
  /// **'Tracking'**
  String get timerTracking;

  /// Timer status while paused.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get timerPaused;

  /// Caption under the running time, e.g. of 2h focus goal.
  ///
  /// In en, this message translates to:
  /// **'of {goal} focus goal'**
  String focusGoal(String goal);

  /// Label before the time the timer started, e.g. Started 17:02.
  ///
  /// In en, this message translates to:
  /// **'Started'**
  String get timerStarted;

  /// Deletes the running timer without saving.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get timerDiscard;

  /// Stops the timer and keeps the entry.
  ///
  /// In en, this message translates to:
  /// **'Stop & save'**
  String get timerStopAndSave;

  /// Pauses the running timer.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get timerPause;

  /// Resumes a paused timer.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get timerResume;

  /// Label above the note field.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get timerNote;

  /// Hint of the note field.
  ///
  /// In en, this message translates to:
  /// **'What did you get done?'**
  String get timerNoteHint;

  /// Chip that adds a new tag.
  ///
  /// In en, this message translates to:
  /// **'+ Tag'**
  String get timerAddTag;

  /// Menu item and screen title for editing a time entry.
  ///
  /// In en, this message translates to:
  /// **'Edit entry'**
  String get editEntry;

  /// Title of the discard confirmation.
  ///
  /// In en, this message translates to:
  /// **'Discard this timer?'**
  String get discardDialogTitle;

  /// Body of the discard confirmation.
  ///
  /// In en, this message translates to:
  /// **'The time tracked in this session is not saved.'**
  String get discardDialogBody;

  /// Closes the discard confirmation and keeps the timer.
  ///
  /// In en, this message translates to:
  /// **'Keep'**
  String get discardDialogKeep;

  /// Title of the new tag dialog.
  ///
  /// In en, this message translates to:
  /// **'New tag'**
  String get newTagTitle;

  /// Example in the new tag field.
  ///
  /// In en, this message translates to:
  /// **'e.g. Deep work'**
  String get newTagHint;

  /// Title of the editor when adding an entry.
  ///
  /// In en, this message translates to:
  /// **'New entry'**
  String get newEntryTitle;

  /// Title of the new project sheet and its button.
  ///
  /// In en, this message translates to:
  /// **'New project'**
  String get newProjectTitle;

  /// Temporary note on screens that are not built yet.
  ///
  /// In en, this message translates to:
  /// **'Not built yet · see prototype/{file}'**
  String screenNotBuilt(String file);

  /// Settings row for choosing the app language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// End of a time range while the timer is still running, e.g. 17:02–now.
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get timeNow;

  /// Saves the form.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Confirms deleting something.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Snackbar when saving fails.
  ///
  /// In en, this message translates to:
  /// **'Could not save, please try again.'**
  String get saveFailed;

  /// Label of the entry description field.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get entryDescription;

  /// Hint of the entry description field.
  ///
  /// In en, this message translates to:
  /// **'What did you work on?'**
  String get entryDescriptionHint;

  /// Label of the entry date row.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get entryDate;

  /// Label of the entry start time field.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get entryStart;

  /// Label of the entry end time field.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get entryEnd;

  /// Label of the computed entry duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get entryDuration;

  /// Label above the tag chips.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get entryTags;

  /// Chip that creates a new tag.
  ///
  /// In en, this message translates to:
  /// **'+ New tag'**
  String get entryNewTag;

  /// Hint of the entry note field.
  ///
  /// In en, this message translates to:
  /// **'Anything worth remembering?'**
  String get entryNoteHint;

  /// Shown instead of an end time while the entry's timer runs.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get entryRunning;

  /// Button that deletes the entry.
  ///
  /// In en, this message translates to:
  /// **'Delete entry'**
  String get entryDelete;

  /// Title of the delete confirmation.
  ///
  /// In en, this message translates to:
  /// **'Delete this entry?'**
  String get entryDeleteTitle;

  /// Body of the delete confirmation.
  ///
  /// In en, this message translates to:
  /// **'This can\'t be undone.'**
  String get entryDeleteBody;

  /// Validation error for the entry times.
  ///
  /// In en, this message translates to:
  /// **'End must be after start.'**
  String get entryEndBeforeStart;

  /// Validation error for the entry start time.
  ///
  /// In en, this message translates to:
  /// **'Start can\'t be in the future.'**
  String get entryStartInFuture;

  /// Shown when opening an entry that was deleted.
  ///
  /// In en, this message translates to:
  /// **'This entry no longer exists.'**
  String get entryNotFound;

  /// Error shown when the entry editor fails to load.
  ///
  /// In en, this message translates to:
  /// **'Could not load the entry.'**
  String get entryLoadError;

  /// Error shown when Projects fails to load.
  ///
  /// In en, this message translates to:
  /// **'Could not load projects.'**
  String get projectsLoadError;

  /// Projects segment: totals for the current week.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get projectsThisWeek;

  /// Projects segment: totals since the start.
  ///
  /// In en, this message translates to:
  /// **'All time'**
  String get projectsAllTime;

  /// Shown when there are no active projects.
  ///
  /// In en, this message translates to:
  /// **'No projects yet. Create one to set a weekly goal.'**
  String get projectsEmpty;

  /// Project card subtitle for all-time totals, e.g. 42h 10m in total.
  ///
  /// In en, this message translates to:
  /// **'{tracked} in total'**
  String projectTotal(Object tracked);

  /// Title of the project sheet when editing.
  ///
  /// In en, this message translates to:
  /// **'Edit project'**
  String get editProjectTitle;

  /// Label of the project name field.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get projectName;

  /// Hint of the project name field.
  ///
  /// In en, this message translates to:
  /// **'e.g. Side project'**
  String get projectNameHint;

  /// Label above the project colour swatches.
  ///
  /// In en, this message translates to:
  /// **'Colour'**
  String get projectColour;

  /// Label of the weekly goal stepper.
  ///
  /// In en, this message translates to:
  /// **'Weekly goal'**
  String get projectWeeklyGoal;

  /// Shown when the weekly goal is zero.
  ///
  /// In en, this message translates to:
  /// **'No weekly goal'**
  String get projectNoGoal;

  /// Tooltip of the minus button.
  ///
  /// In en, this message translates to:
  /// **'Decrease weekly goal'**
  String get projectDecreaseGoal;

  /// Tooltip of the plus button.
  ///
  /// In en, this message translates to:
  /// **'Increase weekly goal'**
  String get projectIncreaseGoal;

  /// Switch title in the project sheet.
  ///
  /// In en, this message translates to:
  /// **'Count toward daily goal'**
  String get projectCountsTowardDaily;

  /// Button that creates the project.
  ///
  /// In en, this message translates to:
  /// **'Create project'**
  String get projectCreate;

  /// Button that archives the project.
  ///
  /// In en, this message translates to:
  /// **'Archive project'**
  String get projectArchive;

  /// Button that restores an archived project.
  ///
  /// In en, this message translates to:
  /// **'Restore project'**
  String get projectRestore;

  /// Shown when opening a project that was deleted.
  ///
  /// In en, this message translates to:
  /// **'This project no longer exists.'**
  String get projectNotFound;

  /// Subtitle above the Projects title, e.g. 5 active.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, other{{count} active}}'**
  String projectsActiveCount(int count);

  /// Project card subtitle, e.g. 9h 15m of 10h goal.
  ///
  /// In en, this message translates to:
  /// **'{tracked} of {goal} goal'**
  String projectGoalProgress(String tracked, String goal);

  /// Row that shows archived projects.
  ///
  /// In en, this message translates to:
  /// **'Archived · {count}'**
  String projectsArchivedCount(int count);

  /// Under the weekly goal, e.g. about 43m a day.
  ///
  /// In en, this message translates to:
  /// **'about {perDay} a day'**
  String projectGoalPerDay(String perDay);

  /// Switch subtitle, e.g. Adds this project's time to your 8h target.
  ///
  /// In en, this message translates to:
  /// **'Adds this project\'s time to your {goal} target'**
  String projectCountsTowardDailyBody(String goal);

  /// Accessibility label of a colour swatch.
  ///
  /// In en, this message translates to:
  /// **'Colour {number}'**
  String projectColourLabel(int number);

  /// Error shown when Reports fails to load.
  ///
  /// In en, this message translates to:
  /// **'Could not load reports.'**
  String get reportsLoadError;

  /// Reports period segment.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get reportsDay;

  /// Reports period segment.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get reportsWeek;

  /// Reports period segment.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get reportsMonth;

  /// Tooltip of the Reports export button.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get reportsExport;

  /// Tooltip: go to the previous period.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get reportsPrevious;

  /// Tooltip: go to the next period.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get reportsNext;

  /// Total label when viewing today.
  ///
  /// In en, this message translates to:
  /// **'Total today'**
  String get reportsTotalToday;

  /// Total label when viewing this week.
  ///
  /// In en, this message translates to:
  /// **'Total this week'**
  String get reportsTotalThisWeek;

  /// Total label when viewing this month.
  ///
  /// In en, this message translates to:
  /// **'Total this month'**
  String get reportsTotalThisMonth;

  /// Total label when viewing a past period.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get reportsTotal;

  /// Title of the per-project breakdown.
  ///
  /// In en, this message translates to:
  /// **'By project'**
  String get reportsByProject;

  /// Shown when the period has no time.
  ///
  /// In en, this message translates to:
  /// **'Nothing tracked in this period.'**
  String get reportsEmpty;

  /// Snackbar when an export fails.
  ///
  /// In en, this message translates to:
  /// **'Could not export, please try again.'**
  String get exportFailed;

  /// Settings section title.
  ///
  /// In en, this message translates to:
  /// **'Tracking'**
  String get settingsTracking;

  /// Settings row and sheet title.
  ///
  /// In en, this message translates to:
  /// **'Daily goal'**
  String get settingsDailyGoal;

  /// Settings row and sheet title.
  ///
  /// In en, this message translates to:
  /// **'Week starts on'**
  String get settingsWeekStartsOn;

  /// Settings switch title.
  ///
  /// In en, this message translates to:
  /// **'Idle detection'**
  String get settingsIdleDetection;

  /// Settings section title.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get settingsReminders;

  /// Settings switch title.
  ///
  /// In en, this message translates to:
  /// **'Remind me to start'**
  String get settingsRemindToStart;

  /// Settings switch title.
  ///
  /// In en, this message translates to:
  /// **'Running timer notification'**
  String get settingsRunningTimerNotification;

  /// Settings switch subtitle.
  ///
  /// In en, this message translates to:
  /// **'Shows the running timer on the lock screen'**
  String get settingsRunningTimerNotificationBody;

  /// Subtitle when the platform can't show notifications.
  ///
  /// In en, this message translates to:
  /// **'Not available on this device'**
  String get settingsNotificationsUnavailable;

  /// Settings section title.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// Settings row and sheet title.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// Theme option: follow the device.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// Theme option.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// Theme option.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// Settings section title.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get settingsData;

  /// Settings row: export all entries.
  ///
  /// In en, this message translates to:
  /// **'Export as CSV'**
  String get settingsExportCsv;

  /// Settings row and sheet title.
  ///
  /// In en, this message translates to:
  /// **'Backup & restore'**
  String get settingsBackup;

  /// Backup sheet action.
  ///
  /// In en, this message translates to:
  /// **'Create backup'**
  String get backupCreate;

  /// Backup sheet action description.
  ///
  /// In en, this message translates to:
  /// **'Save all projects and entries to a file.'**
  String get backupCreateBody;

  /// Backup sheet and onboarding action.
  ///
  /// In en, this message translates to:
  /// **'Restore from a backup'**
  String get backupRestore;

  /// Backup sheet action description.
  ///
  /// In en, this message translates to:
  /// **'Replace everything with a backup file.'**
  String get backupRestoreBody;

  /// File type label in the file picker.
  ///
  /// In en, this message translates to:
  /// **'Tempo backup'**
  String get backupFileType;

  /// Title of the restore confirmation.
  ///
  /// In en, this message translates to:
  /// **'Replace all data?'**
  String get restoreConfirmTitle;

  /// Body of the restore confirmation.
  ///
  /// In en, this message translates to:
  /// **'Projects and entries on this device will be replaced by the backup.'**
  String get restoreConfirmBody;

  /// Confirms the restore.
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get restoreConfirm;

  /// Shown when the picked file can't be read.
  ///
  /// In en, this message translates to:
  /// **'That file is not a Tempo backup.'**
  String get restoreInvalid;

  /// Shown when notification permission is refused.
  ///
  /// In en, this message translates to:
  /// **'Notifications are turned off for Tempo in system settings.'**
  String get notificationsDenied;

  /// Tooltip of a minus button.
  ///
  /// In en, this message translates to:
  /// **'Decrease'**
  String get decrease;

  /// Tooltip of a plus button.
  ///
  /// In en, this message translates to:
  /// **'Increase'**
  String get increase;

  /// Body of the idle dialog.
  ///
  /// In en, this message translates to:
  /// **'Your timer kept running while you were away. Keep that time?'**
  String get idleBody;

  /// Keeps the time tracked while away.
  ///
  /// In en, this message translates to:
  /// **'Keep it'**
  String get idleKeep;

  /// Weekday reminder title.
  ///
  /// In en, this message translates to:
  /// **'Time to start tracking'**
  String get reminderTitle;

  /// Weekday reminder body.
  ///
  /// In en, this message translates to:
  /// **'Start a timer for what you\'re working on.'**
  String get reminderBody;

  /// Android notification channel name for reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminderChannel;

  /// Android notification channel name for the running timer.
  ///
  /// In en, this message translates to:
  /// **'Running timer'**
  String get runningTimerChannel;

  /// Running timer notification title when the entry has no description.
  ///
  /// In en, this message translates to:
  /// **'Timer running'**
  String get runningTimerFallbackTitle;

  /// Change against the previous period, e.g. +3h 20m vs last week.
  ///
  /// In en, this message translates to:
  /// **'{diff} vs {period, select, day{yesterday} week{last week} other{last month}}'**
  String reportsVsLast(String diff, String period);

  /// Change against the period before a past period.
  ///
  /// In en, this message translates to:
  /// **'{diff} vs {period, select, day{the day before} week{the week before} other{the month before}}'**
  String reportsVsPrevious(String diff, String period);

  /// Label of the average line on the chart, e.g. avg 4h.
  ///
  /// In en, this message translates to:
  /// **'avg {duration}'**
  String reportsAverage(String duration);

  /// Short duration above chart bars, e.g. 4h30. Minutes are zero-padded.
  ///
  /// In en, this message translates to:
  /// **'{hours}h{minutes}'**
  String durationCompact(int hours, String minutes);

  /// Idle detection subtitle.
  ///
  /// In en, this message translates to:
  /// **'Ask when I\'m back after {minutes} min away'**
  String settingsIdleDetectionBody(int minutes);

  /// Reminder subtitle, e.g. Weekdays at 09:00.
  ///
  /// In en, this message translates to:
  /// **'Weekdays at {time}'**
  String settingsRemindToStartBody(String time);

  /// App version at the bottom of Settings.
  ///
  /// In en, this message translates to:
  /// **'Tempo {version}'**
  String settingsVersion(String version);

  /// Shown after a restore.
  ///
  /// In en, this message translates to:
  /// **'Restored {projects} projects and {entries} entries.'**
  String restoreDone(int projects, int entries);

  /// Title of the idle dialog, e.g. You were away for 25m.
  ///
  /// In en, this message translates to:
  /// **'You were away for {duration}'**
  String idleTitle(String duration);

  /// Stops the timer at the time the user left.
  ///
  /// In en, this message translates to:
  /// **'Stop at {time}'**
  String idleStopAt(String time);

  /// Running timer notification body.
  ///
  /// In en, this message translates to:
  /// **'Started at {time}'**
  String runningTimerBody(String time);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'km'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'km':
      return AppLocalizationsKm();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
