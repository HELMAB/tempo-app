import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// Wraps flutter_local_notifications. Only Android, iOS and macOS can
/// schedule notifications; everywhere else (web, Linux, Windows, tests)
/// [isSupported] is false and the app disables the reminder settings.
class NotificationService {
  NotificationService({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  Future<void>? _ready;

  bool get isSupported =>
      !kIsWeb &&
      switch (defaultTargetPlatform) {
        TargetPlatform.android ||
        TargetPlatform.iOS ||
        TargetPlatform.macOS => true,
        _ => false,
      };

  static const _runningTimerId = 1;

  /// One notification per weekday, Monday (101) to Friday (105).
  static const _reminderIds = [101, 102, 103, 104, 105];

  static const _darwin = DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  Future<void> _initialize() async {
    tz_data.initializeTimeZones();
    final zone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(zone.identifier));
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: _darwin,
        macOS: _darwin,
      ),
    );
  }

  Future<void> _ensureReady() => _ready ??= _initialize();

  /// Asks the OS for permission; true when notifications may be shown.
  Future<bool> requestPermission() async {
    await _ensureReady();
    final granted = switch (defaultTargetPlatform) {
      TargetPlatform.android =>
        await _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission(),
      TargetPlatform.iOS =>
        await _plugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >()
            ?.requestPermissions(alert: true, sound: true),
      TargetPlatform.macOS =>
        await _plugin
            .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin
            >()
            ?.requestPermissions(alert: true, sound: true),
      _ => false,
    };
    return granted ?? false;
  }

  /// Repeats every Monday–Friday at [hour]:[minute] local time.
  Future<void> scheduleWeekdayReminder({
    required int hour,
    required int minute,
    required String title,
    required String body,
    required String channelName,
  }) async {
    await _ensureReady();
    await cancelWeekdayReminder();
    final now = tz.TZDateTime.now(tz.local);
    for (final (index, id) in _reminderIds.indexed) {
      final weekday = DateTime.monday + index;
      var date = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hour,
        minute,
      );
      while (date.weekday != weekday || !date.isAfter(now)) {
        date = date.add(const Duration(days: 1));
      }
      await _plugin.zonedSchedule(
        id: id,
        scheduledDate: date,
        title: title,
        body: body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails('reminders', channelName),
          iOS: const DarwinNotificationDetails(),
          macOS: const DarwinNotificationDetails(),
        ),
        // Inexact is fine for a nudge and needs no exact-alarm permission.
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    }
  }

  Future<void> cancelWeekdayReminder() async {
    await _ensureReady();
    for (final id in _reminderIds) {
      await _plugin.cancel(id: id);
    }
  }

  /// An ongoing notification; Android shows a live chronometer.
  Future<void> showRunningTimer({
    required String title,
    required String body,
    required DateTime startedAt,
    required String channelName,
  }) async {
    await _ensureReady();
    await _plugin.show(
      id: _runningTimerId,
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          'running_timer',
          channelName,
          importance: Importance.low,
          priority: Priority.low,
          ongoing: true,
          autoCancel: false,
          onlyAlertOnce: true,
          showWhen: true,
          usesChronometer: true,
          when: startedAt.millisecondsSinceEpoch,
        ),
        iOS: const DarwinNotificationDetails(presentSound: false),
        macOS: const DarwinNotificationDetails(presentSound: false),
      ),
    );
  }

  Future<void> cancelRunningTimer() async {
    await _ensureReady();
    await _plugin.cancel(id: _runningTimerId);
  }
}
