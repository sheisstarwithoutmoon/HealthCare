import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:health/patient_screens/explore_screen.dart';
import 'package:health/patient_screens/reminder_screen.dart';
import 'package:health/patient_screens/view_book_appointment.dart';
import 'package:health/patient_screens/records_screen.dart';
import 'package:health/patient_screens/profile_screen.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart'; // Import for exiting the app

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<PatientHomeScreen> {

  int currentIndex = 0;
  DateTime? lastBackPressed;

  // Appointment details (initialize with null-safe values)
  String? _selectedDoctor;
  DateTime? _selectedDate;
  String? _selectedSlot;
  String? _selectedLocation;

  // Function to update appointment details
  void updateAppointmentDetails({
    required String doctor,
    required DateTime date,
    required String slot,
    required String location,
  }) {
    setState(() {
      _selectedDoctor = doctor;
      _selectedDate = date;
      _selectedSlot = slot;
      _selectedLocation = location;
    });
  }

  @override
  void initState() {
    super.initState();
    requestNotificationPermission();
    setUpPushNotifications();
  }
  // void setUpPushNotifications() async{
  //   final fcm = FirebaseMessaging.instance;
  //   await fcm.requestPermission();
  //   fcm.subscribeToTopic('patient');
  // }
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
      print('Permission granted');
      final token = await fcm.getToken();
      print('FCM Token: $token');
    }
  }
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      ExploreScreen(),
      ReminderScreen(
        doctorName: _selectedDoctor ?? "No Doctor",
        appointmentDate: _selectedDate ?? DateTime.now(),
        appointmentSlot: _selectedSlot ?? "No Slot",
        appointmentLocation: _selectedLocation ?? "No Location",
      ),
      ViewOrBookAppointmentScreen(
        onAppointmentBooked: updateAppointmentDetails,
      ),
      HealthRecordScreen(),
      ProfileScreen(),
    ];

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
          return false;
        }
        exit(0);
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
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.home),
              label: "Home",
              activeIcon: Icon(IconlyBold.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.calendar),
              label: "Reminders",
              activeIcon: Icon(IconlyBold.calendar),
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.timeSquare),
              label: "Appointments",
              activeIcon: Icon(IconlyBold.timeSquare),
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.document),
              label: "Records",
              activeIcon: Icon(IconlyBold.document),
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
