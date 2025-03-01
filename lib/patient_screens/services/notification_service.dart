import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:math';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Initialize timezones
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidInitialization =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitialization);

    await _notificationsPlugin.initialize(initializationSettings);

    // Request Notification Permissions
    await requestNotificationPermission();
  }

  Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  /// ✅ Set up FCM & get token
  Future<void> setUpPushNotifications() async {
    final FirebaseMessaging fcm = FirebaseMessaging.instance;

    // Request permissions again in case they were not granted
    NotificationSettings settings = await fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      print('Permission denied');
      return;
    } else {
      print('Permission granted');
      final token = await fcm.getToken();
      print('FCM Token: $token');
    }
  }
  static Future<void> scheduleNotification(
      DateTime scheduledTime, String title, String body, int appointmentId, String notificationType) async {
    // Generate a unique notification ID based on appointment ID and notification type
    final Random random = Random();
    final int notificationId = appointmentId + random.nextInt(1000);
    
    await _notificationsPlugin.zonedSchedule(
      notificationId, // Unique Notification ID
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'appointment_channel',
          'Appointment Notifications',
          channelDescription: 'Reminds about scheduled appointments',
          importance: Importance.high,
          priority: Priority.high,
          // We can use this to categorize notifications
          tag: notificationType,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
  
  // Cancel all notifications for a specific appointment
  static Future<void> cancelAppointmentNotifications(int appointmentId) async {
    // In a real app, you would store notification IDs associated with each appointment
    // Here we're simplifying by assuming a range of IDs
    for (int i = appointmentId; i < appointmentId + 1000; i++) {
      await _notificationsPlugin.cancel(i);
    }
  }
}