import 'package:tempo_app/data/services/file_service.dart';
import 'package:tempo_app/data/services/notification_service.dart';

/// Records shared files and returns [pickedText] from the picker.
class FakeFileService implements FileService {
  final shared = <({String fileName, String mimeType, String contents})>[];
  String? pickedText;

  @override
  Future<void> shareText({
    required String fileName,
    required String mimeType,
    required String contents,
  }) async =>
      shared.add((fileName: fileName, mimeType: mimeType, contents: contents));

  @override
  Future<String?> pickText({
    required String label,
    required List<String> extensions,
    required List<String> mimeTypes,
    required List<String> appleTypes,
  }) async => pickedText;
}

/// A supported platform whose calls are recorded instead of sent to the OS.
class FakeNotificationService implements NotificationService {
  FakeNotificationService({this.grantPermission = true});

  bool grantPermission;
  ({int hour, int minute, String title})? reminder;
  ({String title, String body, DateTime startedAt})? runningTimer;

  @override
  bool get isSupported => true;

  @override
  Future<bool> requestPermission() async => grantPermission;

  @override
  Future<void> scheduleWeekdayReminder({
    required int hour,
    required int minute,
    required String title,
    required String body,
    required String channelName,
  }) async => reminder = (hour: hour, minute: minute, title: title);

  @override
  Future<void> cancelWeekdayReminder() async => reminder = null;

  @override
  Future<void> showRunningTimer({
    required String title,
    required String body,
    required DateTime startedAt,
    required String channelName,
  }) async => runningTimer = (title: title, body: body, startedAt: startedAt);

  @override
  Future<void> cancelRunningTimer() async => runningTimer = null;
}
