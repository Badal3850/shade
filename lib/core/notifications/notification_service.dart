import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(const InitializationSettings(android: android));
    _initialized = true;
  }

  static Future<void> showNeglectReminder(String petName) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'neglect',
        'Neglect Reminders',
        channelDescription: 'Reminders when your pet needs attention',
        importance: Importance.high,
        priority: Priority.high,
      ),
    );
    final name = petName.isNotEmpty ? petName : 'your shade';
    await _plugin.show(
      0,
      '$name is suffering',
      'You\'ve been ignoring them. Classic.',
      details,
    );
  }

  static Future<void> cancelAll() async => _plugin.cancelAll();
}
