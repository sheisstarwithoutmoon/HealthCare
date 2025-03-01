import 'package:flutter/material.dart';
import 'package:health/patient_screens/book_screen.dart';
// import 'package:health/widgets/custom_app_bar.dart';

class ViewOrBookAppointmentScreen extends StatefulWidget {
  const ViewOrBookAppointmentScreen({super.key, required void Function({required DateTime date, required String doctor, required String location, required String slot}) onAppointmentBooked});

  @override
  _ViewOrBookAppointmentScreenState createState() => _ViewOrBookAppointmentScreenState();
}

class _ViewOrBookAppointmentScreenState extends State<ViewOrBookAppointmentScreen> {
  List<Map<String, dynamic>> appointments = [
    {
      "doctor": "Dr. John Doe",
      "date": DateTime.now().add(const Duration(days: 2)),
      "slot": "10:00 AM - 11:00 AM"
    },
    {
      "doctor": "Dr. Jane Smith",
      "date": DateTime.now().add(const Duration(days: 5)),
      "slot": "3:00 PM - 4:00 PM"
    },
  ];

  void _navigateToBookAppointment() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookAppointmentScreen()),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        appointments.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar:  AppBar(
        title: const Text(
          "View or Book Appointment",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        centerTitle: true,
        elevation: 5,
        backgroundColor: Colors.teal.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Appointments",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: appointments.isEmpty
                  ? const Center(
                      child: Text(
                        "No appointments yet. Book one now!",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        final appointment = appointments[index];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: const Icon(Icons.calendar_today, color: Colors.blue),
                            title: Text(
                              appointment["doctor"],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "Date: ${appointment["date"].day}-${appointment["date"].month}-${appointment["date"].year}\n"
                              "Slot: ${appointment["slot"]}",
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _navigateToBookAppointment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 65, 97, 102),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text("Book New Appointment", 
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white
                  )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
