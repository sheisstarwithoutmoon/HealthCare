import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:health/doctor_screens/records_screen.dart';
import 'package:intl/intl.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  DateTime selectedDate = DateTime.now();
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> patients = [
    {'name': 'John Doe', 'time': '10:00 AM', 'status': 'Completed'},
    {'name': 'Jane Smith', 'time': '11:30 AM', 'status': 'Pending'},
    {'name': 'David Johnson', 'time': '1:00 PM', 'status': 'Completed'},
    {'name': 'Emily Brown', 'time': '2:30 PM', 'status': 'Pending'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Scheduled Patients",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1F5958),
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildSearchBar(),
            const SizedBox(height: 10),
            _buildDatePicker(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: patients.length,
                itemBuilder: (context, index) {
                  final patient = patients[index];
                  final isVisible = patient['name']!
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase());

                  if (!isVisible) return const SizedBox.shrink();

                  return _buildPatientCard(patient, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Search Bar
  Widget _buildSearchBar() {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: "Search Patient by Name",
        prefixIcon: const Icon(IconlyLight.search),
        filled: true,
        contentPadding: const EdgeInsets.all(12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        fillColor: Colors.grey[100],
        
      ),
      onChanged: (value) {
        setState(() {});
      },
    );
  }

  // Date Picker Section
  Widget _buildDatePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ElevatedButton.icon(
          onPressed: _pickDate,
          icon: const Icon(Icons.calendar_today, size: 18, color: Colors.white),
          label: const Text("Pick a Date", 
          style: TextStyle(color: Colors.white),), 
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            backgroundColor: const Color(0xFF1F5958),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  // Patient Card
  Widget _buildPatientCard(Map<String, String> patient, int index) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(IconlyBold.user2, color: Colors.white),
        ),
        title: Text(
          patient['name']!,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Time: ${patient['time']}",
          style: const TextStyle(color: Colors.black54),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                if (patient['status'] == 'Pending') {
                  _showConfirmationDialog(index);
                }
              },
              child: _statusIndicator(patient['status']!),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PatientRecordsScreen(name: patient['name']!),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                backgroundColor: const Color(0xFF84AD6F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Records",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Status Indicator
  Widget _statusIndicator(String status) {
    Color color;
    switch (status) {
      case 'Pending':
        color = const Color(0xFFBC2B2B);
        break;
      case 'Completed':
        color = const Color(0xFF416162);
        break;
      default:
        color = Colors.grey;
    }
    return Chip(
      label: Text(status, style: const TextStyle(color: Colors.white, fontSize: 12)),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    );
  }

  // Show Confirmation Dialog
  void _showConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text("Mark as Complete?"),
          content: const Text(
              "Are you sure you want to mark this appointment as completed?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  patients[index]['status'] = 'Completed';
                });
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F5958),
              ),
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  // Date Picker Function
  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
}
