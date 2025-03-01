import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:health/doctor_screens/explore_screen.dart';
import 'package:health/doctor_screens/patient_details_screen.dart';
import 'package:health/doctor_screens/profile_screen.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart'; // Import for exiting the app

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  int currentIndex = 0;
  DateTime? lastBackPressed; // Track last back button press time

  final List<Widget> screens = [
    ExploreScreen(),
    // DoctorAppointmentsScreen(),
    PatientsScreen(),
    DoctorProfileScreen(),
  ];

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
      
      final token = await fcm.getToken();
      print('Permission granted');
      print('FCM Token: $token');
    }
  }
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (lastBackPressed == null || now.difference(lastBackPressed!) > Duration(seconds: 2)) {
          lastBackPressed = now;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Press again to exit"),
              duration: Duration(seconds: 2),
            ),
          );
          return false; // Prevent exit on first press
        }
        exit(0); // Exit the app on second press within 2 seconds
      },
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color.fromARGB(255, 31, 89, 88),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.home),
              label: "Home",
              activeIcon: Icon(IconlyBold.home),
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(IconlyLight.calendar),
            //   label: "Appointments",
            //   activeIcon: Icon(IconlyBold.calendar),
            // ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.user2),
              label: "Patients",
              activeIcon: Icon(IconlyBold.user2),
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.profile),
              label: "Profile",
              activeIcon: Icon(IconlyBold.profile),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          "$title Screen",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
