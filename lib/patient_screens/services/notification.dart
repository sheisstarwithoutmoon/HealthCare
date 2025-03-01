import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationManager {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationManager() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initNotifications();
  }

  void initNotifications() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print('Notification clicked: ${response.payload}');
      },
    );
  }

  /// Schedules a notification for a doctor's appointment (Android Only)
  Future<void> scheduleAppointmentReminder({
    required int id,
    required String doctorName,
    required String hospitalName,
    required DateTime appointmentTime,
  }) async {
    DateTime reminderTime =
        appointmentTime.subtract(const Duration(minutes: 30)); // 30 min before

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'appointment_channel', // Unique channel ID
      'Doctor Appointments', // Channel name
      channelDescription: 'Reminders for upcoming doctor appointments',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'Appointment Reminder',
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Appointment Reminder',
      'Your appointment with Dr. $doctorName at $hospitalName is at ${appointmentTime.hour}:${appointmentTime.minute}.',
      _convertTimeToTZDateTime(reminderTime),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, // ✅ FIXED
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    print('Reminder set for ${reminderTime.toLocal()}');
  }

  /// Helper function to convert DateTime to time zone-specific format
  tz.TZDateTime _convertTimeToTZDateTime(DateTime dateTime) {
    return tz.TZDateTime(
      tz.local,
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
    );
  }

  /// Cancel a scheduled reminder
  void removeReminder(int notificationId) {
    flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}
