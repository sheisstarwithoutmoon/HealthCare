import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:health/doctor_screens/home_screen.dart';
import 'package:health/forgot_pass_screen.dart';
import 'package:health/patient_screens/home_screen.dart';
import 'package:health/services/authentication.dart';
import 'package:health/singup_screen.dart';
import 'package:health/widgets/button.dart';
import 'package:health/widgets/text_field.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _email = TextEditingController();
  late final TextEditingController _password = TextEditingController();
  bool isloading = false;

  @override
  // void initState() {
  //   super.initState();
  //   requestNotificationPermission();
  //   setUpPushNotifications();
  // }
  // // void setUpPushNotifications() async{
  // //   final fcm = FirebaseMessaging.instance;
  // //   await fcm.requestPermission();
  // //   fcm.subscribeToTopic('patient');
  // // }
  // /// ✅ Request notification permission properly
  // Future<void> requestNotificationPermission() async {
  //   if (await Permission.notification.isDenied) {
  //     await Permission.notification.request();
  //   }
  // }

  // /// ✅ Set up FCM & get token
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
      
  //     final token = await fcm.getToken();
  //     print('Permission granted');
  //     print('FCM Token: $token');
  //   }
  // }
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void userLogin() async {
    Map<String, dynamic>? userData = (await AuthServices().userLogin(
      email: _email.text,
      password: _password.text,
    )) as Map<String, dynamic>?;

    if (userData != null && userData["status"] == "Successful") {
      setState(() {
        isloading = true;
      });

      String role = userData["role"]; // Fetch role from database

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => role == "Doctor" ? DoctorHomeScreen() : PatientHomeScreen(),
        ),
      );
    } else {
      setState(() {
        isloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(userData?["message"] ?? "Login failed")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height / 2.8,
                child: Image.asset("assets/images/login.png"),
              ),
              SizedBox(height: 20),
              TextFieldWidget(controller: _email, icon: Icons.email, hintText: "Enter Your Email"),
              SizedBox(height: 10),
              TextFieldWidget(controller: _password, icon: Icons.lock, isPassword: true, hintText: "Enter Your Password"),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                    },
                    child: Text("Forgot Password?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue)),
                  ),
                ),
              ),
              
              Button(onPressed: userLogin, text: "Login"),
              SizedBox(height: height / 15),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't Have an Account? ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                    },
                    child: Text("Sign Up", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
