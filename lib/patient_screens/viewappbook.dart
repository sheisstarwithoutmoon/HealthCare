import 'package:flutter/material.dart';

class ViewOrBookAppointmentScreen extends StatelessWidget {
  final Function({
    required String doctor,
    required DateTime date,
    required String slot,
    required String location,
  })? onAppointmentBooked;

  const ViewOrBookAppointmentScreen({super.key, this.onAppointmentBooked});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Appointment")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Sample appointment details
            onAppointmentBooked?.call(
              doctor: "Dr. John Doe",
              date: DateTime.now(),
              slot: "10:00 AM - 11:00 AM",
              location: "City Hospital",
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Appointment booked successfully!")),
            );
          },
          child: Text("Book Appointment"),
        ),
      ),
    );
  }
}
