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
