import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:health/doctor_screens/patient_details_screen.dart';
import 'package:health/doctor_screens/records_screen.dart';
import 'package:health/services/authentication.dart'; // Import authentication service

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Doctor Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal.shade700,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Profile Picture & Name
            Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/doctor_profile.jpg'), // Update image if needed
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Dr. Alexander Smith",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Cardiologist | 10+ Years Experience",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Contact Information
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              "Contact Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildContactTile(IconlyLight.call, "+1 123-456-7890"),
            _buildContactTile(IconlyLight.message, "alex.smith@hospital.com"),

            const SizedBox(height: 16),

            // 🔹 Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(IconlyBold.edit, color: Colors.teal),
                  label: const Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.teal),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.teal.shade700),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PatientsScreen()),
                    );
                  },
                  icon: const Icon(IconlyBold.calendar),
                  label: const Text("View Appointments"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 🔹 Recent Patients
            const Text(
              "Recent Patients",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildPatientList(context),

            const SizedBox(height: 24),

            // 🔹 Logout Option
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  AuthServices().signOut();
                },
                icon: const Icon(IconlyBold.logout),
                label: const Text("Logout"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactTile(IconData icon, String text) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal.shade100,
          child: Icon(icon, color: Colors.teal.shade800),
        ),
        title: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildPatientList(BuildContext context) {
    List<Map<String, String>> patients = [
      {"name": "John Doe", "reason": "Heart Check-up"},
      {"name": "Jane Smith", "reason": "Regular Check-up"},
      {"name": "David Johnson", "reason": "Hypertension Treatment"},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: patients.length,
      itemBuilder: (context, index) {
        return _buildPatientTile(context, patients[index]['name']!, patients[index]['reason']!);
      },
    );
  }

  Widget _buildPatientTile(BuildContext context, String name, String reason) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: const Icon(IconlyLight.user2, color: Colors.blue),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(reason, style: const TextStyle(fontSize: 14, color: Colors.black54)),
        trailing: const Icon(IconlyLight.arrowRight2, color: Colors.teal),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatientRecordsScreen(name: name),
            ),
          );
        },
      ),
    );
  }
}
