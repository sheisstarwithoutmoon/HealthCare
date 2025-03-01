import 'package:flutter/material.dart';
import 'package:health/patient_screens/explore_screen.dart';

class ReminderScreen extends StatelessWidget {
  final String doctorName;
  final DateTime appointmentDate;
  final String appointmentSlot;
  final String appointmentLocation;

  const ReminderScreen({
    super.key,
    required this.doctorName,
    required this.appointmentDate,
    required this.appointmentSlot,
    required this.appointmentLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Reminders",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 5,
        backgroundColor: Colors.teal.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.access_alarm,
              size: 80,
              color: Color.fromARGB(255, 65, 97, 102),
            ),
            const SizedBox(height: 20),
            const Text(
              "Reminder for your appointment",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              // "You have an appointment with Dr. $doctorName on ${appointmentDate.day}-${appointmentDate.month}-${appointmentDate.year} at $appointmentSlot at $appointmentLocation.",
              "Your Appointment is scheduled at 7th March 2025 at 11:00 AM in Sunrise Clinic with Dr. Emily Brown",
              style: const TextStyle(fontSize: 18, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ExploreScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 65, 97, 102),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
        
              ),
              child: const Text(
                "OK, Got it!",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
