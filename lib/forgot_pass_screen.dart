import 'package:health/widgets/button.dart';
import 'package:health/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    final email = _controller.text.trim();

    if (email.isEmpty) {
      _showErrorDialog("Please enter an email address.");
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _controller.clear();
      _showSuccessDialog();
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(e.message ?? "An error occurred. Please try again.");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success"),
          content: const Text("A password reset link has been sent to your email."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        automaticallyImplyLeading: false,
      ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFieldWidget(
              controller: _controller,
              icon: Icons.email,
              hintText: "Enter your Email",
            ),
            const SizedBox(height: 10),
            Button(
              onPressed: _resetPassword,
              text: "Send Reset Link",
            ),
            TextButton(
                onPressed: () {
                  // Navigate back to the login screen
                  Navigator.pop(context);
                },
                child: const Text("Back to Login"),
            ),
            ],
          ),
      ),
      );
  }
}
