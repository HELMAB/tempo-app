// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Khmer Central Khmer (`km`).
class AppLocalizationsKm extends AppLocalizations {
  AppLocalizationsKm([String locale = 'km']) : super(locale);

  @override
  String get navToday => 'ថ្ងៃនេះ';

  @override
  String get navProjects => 'គម្រោង';

  @override
  String get navReports => 'របាយការណ៍';

  @override
  String get navSettings => 'ការកំណត់';

  @override
  String get noProject => 'គ្មានគម្រោង';

  @override
  String get noDescription => 'គ្មានការពិពណ៌នា';

  @override
  String get projectPickerTitle => 'គម្រោង';

  @override
  String get cancel => 'បោះបង់';

  @override
  String get add => 'បន្ថែម';

  @override
  String get close => 'បិទ';

  @override
  String get more => 'ច្រើនទៀត';

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours ម៉ោង $minutes នាទី';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes នាទី';
  }

  @override
  String durationHours(int hours) {
    return '$hours ម៉ោង';
  }

  @override
  String get onboardingSkip => 'រំលង';

  @override
  String get onboardingTrackedToday => 'បានតាមដានថ្ងៃនេះ';

  @override
  String get onboardingHeadline => 'ដឹងថាម៉ោងរបស់អ្នកចំណាយទៅលើអ្វី។';

  @override
  String get onboardingBody =>
      'ចាប់ផ្ដើមកំណត់ម៉ោងដោយចុចតែម្ដង រៀបចំពេលវេលាតាមគម្រោង ហើយមើលសប្ដាហ៍របស់អ្នកភ្លាមៗ។';

  @override
  String get onboardingFeatureTimer => 'ចាប់ផ្ដើម និងបញ្ឈប់ដោយចុចតែម្ដង';

  @override
  String get onboardingFeatureProjects => 'គម្រោងដែលមានគោលដៅប្រចាំសប្ដាហ៍';

  @override
  String get onboardingFeatureReports =>
      'របាយការណ៍ប្រចាំសប្ដាហ៍ ប្រើបានដោយគ្មានអ៊ីនធឺណិត';

  @override
  String get onboardingGetStarted => 'ចាប់ផ្ដើម';

  @override
  String get onboardingSaveError => 'មិនអាចរក្សាទុកបានទេ សូមព្យាយាមម្ដងទៀត។';

  @override
  String get todayLoadError => 'មិនអាចផ្ទុកទិន្នន័យថ្ងៃនេះបានទេ។';

  @override
  String get trackedToday => 'បានតាមដានថ្ងៃនេះ';

  @override
  String goalProgress(int percent, String goal) {
    return '$percent% នៃគោលដៅ $goal';
  }

  @override
  String get quickStartHint => 'តើអ្នកកំពុងធ្វើអ្វី?';

  @override
  String get startTimer => 'ចាប់ផ្ដើមកំណត់ម៉ោង';

  @override
  String get stopTimer => 'បញ្ឈប់ការកំណត់ម៉ោង';

  @override
  String get entriesTitle => 'កំណត់ត្រា';

  @override
  String get addManually => 'បញ្ចូលដោយដៃ';

  @override
  String get entriesEmpty =>
      'មិនទាន់មានកំណត់ត្រានៅឡើយទេ។ ចាប់ផ្ដើមកំណត់ម៉ោង ឬបញ្ចូលដោយដៃ។';

  @override
  String get continueEntry => 'បន្ត';

  @override
  String get timerLoadError => 'មិនអាចផ្ទុកការកំណត់ម៉ោងបានទេ។';

  @override
  String get timerNothingRunning => 'មិនមានការកំណត់ម៉ោងកំពុងដំណើរការទេ';

  @override
  String get backToToday => 'ត្រឡប់ទៅថ្ងៃនេះ';

  @override
  String get timerTracking => 'កំពុងតាមដាន';

  @override
  String get timerPaused => 'បានផ្អាក';

  @override
  String focusGoal(String goal) {
    return 'នៃគោលដៅផ្ដោតអារម្មណ៍ $goal';
  }

  @override
  String get timerStarted => 'បានចាប់ផ្ដើម';

  @override
  String get timerDiscard => 'លុបចោល';

  @override
  String get timerStopAndSave => 'បញ្ឈប់ និងរក្សាទុក';

  @override
  String get timerPause => 'ផ្អាក';

  @override
  String get timerResume => 'បន្ត';

  @override
  String get timerNote => 'កំណត់សម្គាល់';

  @override
  String get timerNoteHint => 'តើអ្នកបានធ្វើអ្វីខ្លះ?';

  @override
  String get timerAddTag => '+ ស្លាក';

  @override
  String get editEntry => 'កែកំណត់ត្រា';

  @override
  String get discardDialogTitle => 'លុបចោលការកំណត់ម៉ោងនេះ?';

  @override
  String get discardDialogBody =>
      'ពេលវេលាដែលបានតាមដានក្នុងវគ្គនេះនឹងមិនត្រូវបានរក្សាទុកទេ។';

  @override
  String get discardDialogKeep => 'ទុកដដែល';

  @override
  String get newTagTitle => 'ស្លាកថ្មី';

  @override
  String get newTagHint => 'ឧ. ការងារផ្ដោតអារម្មណ៍';

  @override
  String get newEntryTitle => 'កំណត់ត្រាថ្មី';

  @override
  String get newProjectTitle => 'គម្រោងថ្មី';

  @override
  String screenNotBuilt(String file) {
    return 'មិនទាន់បង្កើតនៅឡើយ · មើល prototype/$file';
  }

  @override
  String get settingsLanguage => 'ភាសា';

  @override
  String get timeNow => 'ឥឡូវ';

  @override
  String get save => 'រក្សាទុក';

  @override
  String get delete => 'លុប';

  @override
  String get saveFailed => 'មិនអាចរក្សាទុកបានទេ សូមព្យាយាមម្ដងទៀត។';

  @override
  String get entryDescription => 'ការពិពណ៌នា';

  @override
  String get entryDescriptionHint => 'តើអ្នកបានធ្វើការលើអ្វី?';

  @override
  String get entryDate => 'កាលបរិច្ឆេទ';

  @override
  String get entryStart => 'ចាប់ផ្ដើម';

  @override
  String get entryEnd => 'បញ្ចប់';

  @override
  String get entryDuration => 'រយៈពេល';

  @override
  String get entryTags => 'ស្លាក';

  @override
  String get entryNewTag => '+ ស្លាកថ្មី';

  @override
  String get entryNoteHint => 'មានអ្វីដែលគួរចងចាំទេ?';

  @override
  String get entryRunning => 'កំពុងដំណើរការ';

  @override
  String get entryDelete => 'លុបកំណត់ត្រា';

  @override
  String get entryDeleteTitle => 'លុបកំណត់ត្រានេះ?';

  @override
  String get entryDeleteBody => 'សកម្មភាពនេះមិនអាចត្រឡប់វិញបានទេ។';

  @override
  String get entryEndBeforeStart => 'ពេលបញ្ចប់ត្រូវតែនៅក្រោយពេលចាប់ផ្ដើម។';

  @override
  String get entryStartInFuture => 'ពេលចាប់ផ្ដើមមិនអាចនៅពេលអនាគតបានទេ។';

  @override
  String get entryNotFound => 'កំណត់ត្រានេះលែងមានទៀតហើយ។';

  @override
  String get entryLoadError => 'មិនអាចផ្ទុកកំណត់ត្រាបានទេ។';

  @override
  String get projectsLoadError => 'មិនអាចផ្ទុកគម្រោងបានទេ។';

  @override
  String get projectsThisWeek => 'សប្ដាហ៍នេះ';

  @override
  String get projectsAllTime => 'គ្រប់ពេល';

  @override
  String get projectsEmpty =>
      'មិនទាន់មានគម្រោងនៅឡើយទេ។ បង្កើតគម្រោងមួយ ដើម្បីកំណត់គោលដៅប្រចាំសប្ដាហ៍។';

  @override
  String projectTotal(Object tracked) {
    return 'សរុប $tracked';
  }

  @override
  String get editProjectTitle => 'កែគម្រោង';

  @override
  String get projectName => 'ឈ្មោះ';

  @override
  String get projectNameHint => 'ឧ. គម្រោងផ្ទាល់ខ្លួន';

  @override
  String get projectColour => 'ពណ៌';

  @override
  String get projectWeeklyGoal => 'គោលដៅប្រចាំសប្ដាហ៍';

  @override
  String get projectNoGoal => 'គ្មានគោលដៅប្រចាំសប្ដាហ៍';

  @override
  String get projectDecreaseGoal => 'បន្ថយគោលដៅប្រចាំសប្ដាហ៍';

  @override
  String get projectIncreaseGoal => 'បង្កើនគោលដៅប្រចាំសប្ដាហ៍';

  @override
  String get projectCountsTowardDaily => 'រាប់បញ្ចូលក្នុងគោលដៅប្រចាំថ្ងៃ';

  @override
  String get projectCreate => 'បង្កើតគម្រោង';

  @override
  String get projectArchive => 'ទុកគម្រោងក្នុងបណ្ណសារ';

  @override
  String get projectRestore => 'ស្ដារគម្រោងវិញ';

  @override
  String get projectNotFound => 'គម្រោងនេះលែងមានទៀតហើយ។';

  @override
  String projectsActiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'សកម្ម $count',
    );
    return '$_temp0';
  }

  @override
  String projectGoalProgress(String tracked, String goal) {
    return '$tracked នៃគោលដៅ $goal';
  }

  @override
  String projectsArchivedCount(int count) {
    return 'បណ្ណសារ · $count';
  }

  @override
  String projectGoalPerDay(String perDay) {
    return 'ប្រហែល $perDay ក្នុងមួយថ្ងៃ';
  }

  @override
  String projectCountsTowardDailyBody(String goal) {
    return 'បូកពេលវេលានៃគម្រោងនេះចូលក្នុងគោលដៅ $goal របស់អ្នក';
  }

  @override
  String projectColourLabel(int number) {
    return 'ពណ៌ទី $number';
  }

  @override
  String get reportsLoadError => 'មិនអាចផ្ទុករបាយការណ៍បានទេ។';

  @override
  String get reportsDay => 'ថ្ងៃ';

  @override
  String get reportsWeek => 'សប្ដាហ៍';

  @override
  String get reportsMonth => 'ខែ';

  @override
  String get reportsExport => 'នាំចេញ CSV';

  @override
  String get reportsPrevious => 'មុន';

  @override
  String get reportsNext => 'បន្ទាប់';

  @override
  String get reportsTotalToday => 'សរុបថ្ងៃនេះ';

  @override
  String get reportsTotalThisWeek => 'សរុបសប្ដាហ៍នេះ';

  @override
  String get reportsTotalThisMonth => 'សរុបខែនេះ';

  @override
  String get reportsTotal => 'សរុប';

  @override
  String get reportsByProject => 'តាមគម្រោង';

  @override
  String get reportsEmpty => 'មិនមានការតាមដានក្នុងរយៈពេលនេះទេ។';

  @override
  String get exportFailed => 'មិនអាចនាំចេញបានទេ សូមព្យាយាមម្ដងទៀត។';

  @override
  String get settingsTracking => 'ការតាមដាន';

  @override
  String get settingsDailyGoal => 'គោលដៅប្រចាំថ្ងៃ';

  @override
  String get settingsWeekStartsOn => 'សប្ដាហ៍ចាប់ផ្ដើមនៅ';

  @override
  String get settingsIdleDetection => 'ការរកឃើញពេលទំនេរ';

  @override
  String get settingsReminders => 'ការរំលឹក';

  @override
  String get settingsRemindToStart => 'រំលឹកខ្ញុំឱ្យចាប់ផ្ដើម';

  @override
  String get settingsRunningTimerNotification => 'ការជូនដំណឹងពេលកំណត់ម៉ោង';

  @override
  String get settingsRunningTimerNotificationBody =>
      'បង្ហាញការកំណត់ម៉ោងលើអេក្រង់ចាក់សោ';

  @override
  String get settingsNotificationsUnavailable => 'មិនមាននៅលើឧបករណ៍នេះទេ';

  @override
  String get settingsAppearance => 'រូបរាង';

  @override
  String get settingsTheme => 'ផ្ទៃពណ៌';

  @override
  String get themeSystem => 'តាមប្រព័ន្ធ';

  @override
  String get themeLight => 'ភ្លឺ';

  @override
  String get themeDark => 'ងងឹត';

  @override
  String get settingsData => 'ទិន្នន័យ';

  @override
  String get settingsExportCsv => 'នាំចេញជា CSV';

  @override
  String get settingsBackup => 'បម្រុងទុក និងស្ដារ';

  @override
  String get backupCreate => 'បង្កើតការបម្រុងទុក';

  @override
  String get backupCreateBody =>
      'រក្សាទុកគម្រោង និងកំណត់ត្រាទាំងអស់ទៅក្នុងឯកសារ។';

  @override
  String get backupRestore => 'ស្ដារពីការបម្រុងទុក';

  @override
  String get backupRestoreBody => 'ជំនួសទិន្នន័យទាំងអស់ដោយឯកសារបម្រុងទុក។';

  @override
  String get backupFileType => 'ឯកសារបម្រុងទុក Tempo';

  @override
  String get restoreConfirmTitle => 'ជំនួសទិន្នន័យទាំងអស់?';

  @override
  String get restoreConfirmBody =>
      'គម្រោង និងកំណត់ត្រានៅលើឧបករណ៍នេះនឹងត្រូវបានជំនួសដោយការបម្រុងទុក។';

  @override
  String get restoreConfirm => 'ជំនួស';

  @override
  String get restoreInvalid => 'ឯកសារនោះមិនមែនជាការបម្រុងទុក Tempo ទេ។';

  @override
  String get notificationsDenied =>
      'ការជូនដំណឹងត្រូវបានបិទសម្រាប់ Tempo ក្នុងការកំណត់ប្រព័ន្ធ។';

  @override
  String get decrease => 'បន្ថយ';

  @override
  String get increase => 'បង្កើន';

  @override
  String get idleBody =>
      'ការកំណត់ម៉ោងរបស់អ្នកនៅតែដំណើរការពេលអ្នកមិននៅ។ រក្សាពេលនោះទុកទេ?';

  @override
  String get idleKeep => 'រក្សាទុក';

  @override
  String get reminderTitle => 'ដល់ពេលចាប់ផ្ដើមតាមដានហើយ';

  @override
  String get reminderBody => 'ចាប់ផ្ដើមកំណត់ម៉ោងសម្រាប់ការងារដែលអ្នកកំពុងធ្វើ។';

  @override
  String get reminderChannel => 'ការរំលឹក';

  @override
  String get runningTimerChannel => 'ការកំណត់ម៉ោងកំពុងដំណើរការ';

  @override
  String get runningTimerFallbackTitle => 'កំពុងកំណត់ម៉ោង';

  @override
  String reportsVsLast(String diff, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'day': 'ម្សិលមិញ',
      'week': 'សប្ដាហ៍មុន',
      'other': 'ខែមុន',
    });
    return '$diff ធៀបនឹង$_temp0';
  }

  @override
  String reportsVsPrevious(String diff, String period) {
    String _temp0 = intl.Intl.selectLogic(period, {
      'day': 'ថ្ងៃមុន',
      'week': 'សប្ដាហ៍មុន',
      'other': 'ខែមុន',
    });
    return '$diff ធៀបនឹង$_temp0';
  }

  @override
  String reportsAverage(String duration) {
    return 'មធ្យម $duration';
  }

  @override
  String durationCompact(int hours, String minutes) {
    return '$hours:$minutes';
  }

  @override
  String settingsIdleDetectionBody(int minutes) {
    return 'សួរពេលខ្ញុំត្រឡប់មកវិញក្រោយចាកចេញ $minutes នាទី';
  }

  @override
  String settingsRemindToStartBody(String time) {
    return 'ថ្ងៃធ្វើការ ម៉ោង $time';
  }

  @override
  String settingsVersion(String version) {
    return 'Tempo $version';
  }

  @override
  String restoreDone(int projects, int entries) {
    return 'បានស្ដារ $projects គម្រោង និង $entries កំណត់ត្រា។';
  }

  @override
  String idleTitle(String duration) {
    return 'អ្នកបានចាកចេញ $duration';
  }

  @override
  String idleStopAt(String time) {
    return 'បញ្ឈប់នៅ $time';
  }

  @override
  String runningTimerBody(String time) {
    return 'បានចាប់ផ្ដើមនៅ $time';
  }
}
