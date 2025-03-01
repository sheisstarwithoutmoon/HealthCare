import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String hintText;
  final IconData icon;

  const TextFieldWidget({
    super.key,
    required this.controller,
    this.isPassword = false,
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:360,
      child: TextField(
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black45, fontSize:18),
          prefixIcon: Icon(
            icon,
            color: Colors.black45,
          ),
          contentPadding: EdgeInsets.symmetric(vertical:15, horizontal: 20),
          border: InputBorder.none,
          filled: true,
          fillColor: Color(0xFFedf0f8),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width:2, color: Color.fromARGB(255, 65, 97, 102)),
            borderRadius: BorderRadius.circular(30),
          ),
        )
      ),
    );
  }
}