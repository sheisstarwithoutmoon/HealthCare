import 'package:health/models/user.dart';

class Patient extends User {
  final int age;
  final String gender;
  final String medicalHistory;

  Patient({
    required String name,
    required String email,
    required String pass,
    required this.age,
    required this.gender,
    required this.medicalHistory,
  }) : super(name: name, email: email, pass: pass, role: 'patient');
}
