// import 'package:flutter/material.dart';
// import 'package:health/doctor_screens/doctor_login.dart';
// // import 'package:health/doctor_screens/doctor_login_screen.dart';
// import 'package:health/patient_screens/patient_login_screen.dart';

// class UserTypeSelectionScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Colors.grey.shade200, Colors.grey.shade100],
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15),
//                     border: Border.all(
//                       color: Colors.grey.shade300,
//                       width: 1.5,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         spreadRadius: 2,
//                         blurRadius: 10,
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Text(
//                         'Welcome to the App!',
//                         style: TextStyle(
//                           fontSize: 29,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                           letterSpacing: 1.5,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 20),
//                       Text(
//                         'Select User Type',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black.withOpacity(0.7),
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 20),
//                       _buildLoginButton(
//                         context,
//                         'Doctor Login',
//                         Color.fromARGB(255, 100, 181, 246),
//                         () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => LoginScreen(),
//                             ),
//                           );
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       _buildLoginButton(
//                         context,
//                         'Patient Login',
//                         Color.fromARGB(255, 76, 175, 80),
//                         () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => PatientLoginScreen(),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLoginButton(BuildContext context, String label, Color color, VoidCallback onPressed) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       child: Text(
//         label,
//         style: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//       style: ElevatedButton.styleFrom(
//         minimumSize: Size(double.infinity, 60),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         backgroundColor: color,
//         elevation: 8,
//         shadowColor: Colors.black.withOpacity(0.2),
//       ),
//     );
//   }
// }
