// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter/material.dart';
// // // import 'package:health/doctor_screens/home_screen.dart';
// // // import 'package:health/patient_screens/home_screen.dart';
// // import 'package:health/user_type.dart';
// // // import 'package:health/patient_screens/home_screen.dart';
// // // import 'package:health/user_type.dart';

// // void main() async{
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
  
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
// //         useMaterial3: true,
// //       ),
// //       home: UserTypeSelectionScreen(),
// //     );
// //   }
// // }

// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:health/doctor_screens/home_screen.dart';
// // import 'package:flutter/material.dart';

// // import 'package:health/doctor_screens/doctor_login.dart';
// // import 'package:health/doctor_screens/doctor_login.dart';
// // import 'package:health/doctor_screens/home_screen.dart';
// // import 'package:health/patient_screens/home_screen.dart';
// // import 'package:health/patient_screens/services/notification_service.dart';
// // import 'package:timezone/data/latest_all.dart' as tz;

// // Future<void> main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   tz.initializeTimeZones();

// //   // Initialize Notification Settings
// //   const AndroidInitializationSettings initializationSettingsAndroid =
// //       AndroidInitializationSettings('@mipmap/ic_launcher');
// //   final InitializationSettings initializationSettings =
// //       InitializationSettings(android: initializationSettingsAndroid);

// //   // await flutterLocalNotificationsPlugin.initialize(initializationSettings);
// //   await Firebase.initializeApp();
// //   // await NotificationServices.initialize();
// //   await NotificationService.initialize();
// //   FirebaseMessaging.instance.requestPermission();

// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: StreamBuilder(
// //           stream: FirebaseAuth.instance.authStateChanges(),
// //           builder: (context, snapshot) {
// //             if (snapshot.hasData) {
// //               return PatientHomeScreen();
// //             } else {
// //               return LoginScreen();
// //            }
// //           }),
// //     );
// //   }
// // }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:health/doctor_screens/home_screen.dart';
import 'package:health/login_screen.dart';
import 'package:health/patient_screens/home_screen.dart';
import 'package:health/patient_screens/services/notification_service.dart';
import 'package:health/patient_screens/togetnotification.dart';
import 'package:timezone/data/latest_all.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await NotificationService.initialize();
  FirebaseMessaging.instance.requestPermission();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      return userDoc["role"] as String?;
    } catch (e) {
      print("Error fetching user role: $e");
      return null;
    }
  }

  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final User? user = snapshot.data;
            if (user != null) {
              return FutureBuilder<String?>(
                future: getUserRole(user.uid),
                builder: (context, roleSnapshot) {
                  if (roleSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (roleSnapshot.hasError || !roleSnapshot.hasData) {
                    return LoginScreen(); 
                  }
                  if (roleSnapshot.data == "Doctor") {
                    return DoctorHomeScreen();
                  } else {
                    return PatientHomeScreen();
                  }
                },
              );
            }
          }
          return LoginScreen();
        },
      ),
    );
  }
}



// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:health/patient_screens/togetnotification.dart';
// import 'package:permission_handler/permission_handler.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(); // Initialize Firebase
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Screentest(),
//     );
//   }
// }
