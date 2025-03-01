import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class PatientRecordsScreen extends StatelessWidget {
  final String name;
  const PatientRecordsScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$name's Records",
          style: const TextStyle(
            fontWeight: FontWeight.bold, // Make text bold
            color: Colors.white, // Make text white
          ),
        ),
        centerTitle: true,
        elevation: 5,
        backgroundColor: Colors.teal.shade600,
      ),
      body: Container(
        color: Colors.grey.shade100, // Light background
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Medical History",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildRecordCard(
                    icon: IconlyBold.heart,
                    title: "Diagnosis: Hypertension",
                    subtitle: "Last Visit: 10 Aug 2023",
                  ),
                  _buildRecordCard(
                    icon: IconlyBold.document,
                    title: "Medication: Amlodipine",
                    subtitle: "Dosage: 5mg daily",
                  ),
                  _buildRecordCard(
                    icon: IconlyBold.calendar,
                    title: "Upcoming Test: Blood Pressure Check",
                    subtitle: "Scheduled: 15 Sept 2023",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordCard({required IconData icon, required String title, required String subtitle}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          backgroundColor: Colors.teal.shade100,
          child: Icon(icon, color: Colors.teal.shade700),
        ),
        title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.black54)),
      ),
    );
  }
}
