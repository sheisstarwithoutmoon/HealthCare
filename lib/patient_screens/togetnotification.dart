import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class Screentest extends StatefulWidget {
  @override
  State<Screentest> createState() => _ScreentestState();
}

class _ScreentestState extends State<Screentest> {
  @override
  void initState() {
    super.initState();
    requestNotificationPermission();
    setUpPushNotifications();
  }

  /// ✅ Request notification permission properly
  Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  /// ✅ Set up FCM & get token
  // Future<void> setUpPushNotifications() async {
  //   final FirebaseMessaging fcm = FirebaseMessaging.instance;

  //   // Request permissions again in case they were not granted
  //   NotificationSettings settings = await fcm.requestPermission(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );

  //   if (settings.authorizationStatus == AuthorizationStatus.denied) {
  //     print('Permission denied');
  //     return;
  //   } else {
  //     print('Permission granted');
  //     final token = await fcm.getToken();
  //     print('FCM Token:$token');
  //   }
  // }
  void setUpPushNotifications() async{
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    fcm.subscribeToTopic('patient');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Screentest'),
            ElevatedButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text('Pop'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          SystemNavigator.pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Screentest()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
