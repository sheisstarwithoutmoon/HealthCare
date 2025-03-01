import 'package:flutter/material.dart';
import 'package:health/doctor_screens/home_screen.dart';
import 'package:health/login_screen.dart';
import 'package:health/patient_screens/home_screen.dart';
import 'package:health/services/authentication.dart';
import 'package:health/widgets/button.dart';
import 'package:health/widgets/dropdown.dart';
import 'package:health/widgets/text_field.dart';
// import 'package:health/screens/login_screen.dart'; // Ensure LoginScreen is imported

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();
  
  String _selectedRole = "Doctor"; // Default role

  bool isLoading = false;

  void userSignup() async {
    String? role = _selectedRole; // Assume role is selected during signup

    if (role == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a role")),
      );
      return;
    }

    Map<String, dynamic>? response = (await AuthServices().userSignup(
      email: _email.text,
      password: _password.text,
      role: role, username: _username.text,  // Store role in database
    )) as Map<String, dynamic>?;

    if (response != null && response["status"] == "Successful") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => role == "Doctor" ? DoctorHomeScreen() : PatientHomeScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response?["message"] ?? "Signup failed")),
      );
    }
  }


  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: height / 2.8,
                child: Image.asset("assets/images/signup.png"),
              ),
              TextFieldWidget(
                controller: _username,
                icon: Icons.person,
                hintText: "Enter your Name",
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                controller: _email,
                icon: Icons.email,
                hintText: "Enter your Email",
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                controller: _password,
                icon: Icons.lock,
                isPassword: true,
                hintText: "Enter your Password",
              ),
              const SizedBox(height: 10),
              
              // Role Selection Dropdown
              RoleDropdownWidget(
                selectedRole: _selectedRole,
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
              ),
              // DropdownButtonFormField<String>(
              //   value: _selectedRole,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: "Select Role",
              //   ),
              //   items: ["Doctor", "Patient"].map((role) {
              //     return DropdownMenuItem(value: role, child: Text(role));
              //   }).toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedRole = value!;
              //     });
              //   },
              // ),
              const SizedBox(height: 20),
              
              isLoading
                  ? const CircularProgressIndicator()
                  : Button(onPressed: userSignup, text: "Sign Up"),
              
              SizedBox(height: height / 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already Have An Account? ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
