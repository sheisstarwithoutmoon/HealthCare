import 'package:flutter/material.dart';

class RoleDropdownWidget extends StatelessWidget {
  final String? selectedRole;
  final ValueChanged<String?> onChanged;

  const RoleDropdownWidget({
    super.key,
    required this.selectedRole,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: DropdownButtonFormField<String>(
        value: selectedRole,
        decoration: InputDecoration(
          hintText: "Select Role",
          hintStyle: const TextStyle(color: Colors.black45, fontSize: 18),
          prefixIcon: const Icon(Icons.person_outline, color: Colors.black45),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          border: InputBorder.none,
          filled: true,
          fillColor: const Color(0xFFedf0f8),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Color.fromARGB(255, 65, 97, 102)),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        items: ["Doctor", "Patient"].map((role) {
          return DropdownMenuItem(
            value: role,
            child: Text(
              role,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        dropdownColor: Colors.white,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.black45),
      ),
    );
  }
}
