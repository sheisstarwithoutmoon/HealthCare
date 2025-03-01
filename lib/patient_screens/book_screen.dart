import 'package:flutter/material.dart';
import 'package:health/controllers/appointment_controller.dart';
import 'package:health/models/appointment.dart';
import 'package:health/patient_screens/services/notification_service.dart';
import 'reminder_screen.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  String? _selectedDoctor;
  DateTime? _selectedDate;
  String? _selectedSlot;
  String? _selectedLocation;
  final String _userId = "user_123";
  final AppointmentController _appointmentController = AppointmentController();

  final List<String> _doctors = [
    "Dr. John Doe",
    "Dr. Jane Smith",
    "Dr. Emily Brown",
    "Dr. Robert Wilson"
  ];

  final List<String> _locations = [
    "City Hospital",
    "Sunrise Clinic",
    "Green Valley Medical Center",
    "Downtown Health Center"
  ];

  final List<String> allSlots = [
    "9:00 AM - 10:00 AM",
    "10:00 AM - 11:00 AM",
    "11:00 AM - 12:00 PM",
    "2:00 PM - 3:00 PM",
    "3:00 PM - 4:00 PM",
    "4:00 PM - 5:00 PM",
  ];

  final List<String> bookedSlots = ["10:00 AM - 11:00 AM", "3:00 PM - 4:00 PM"];

  List<String> get availableSlots =>
      allSlots.where((slot) => !bookedSlots.contains(slot)).toList();

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _selectedSlot = null;
      });
    }
  }

  void _confirmAppointment(BuildContext context) async {
    if (_selectedDoctor != null &&
        _selectedDate != null &&
        _selectedSlot != null &&
        _selectedLocation != null) {
      
      int appointmentId = DateTime.now().millisecondsSinceEpoch;

      Appointment appointment = Appointment(
        id: appointmentId,
        userId: _userId,
        doctorName: _selectedDoctor!,
        date: _selectedDate!,
        slot: _selectedSlot!,
        location: _selectedLocation!,
        status: "upcoming",
      );

      await _appointmentController.bookAppointment(appointment);

      List<DateTime> reminders = [
        _selectedDate!.subtract(Duration(days: 7)),
        _selectedDate!.subtract(Duration(days: 3)),
        _selectedDate!.subtract(Duration(days: 2)),
        _selectedDate!.subtract(Duration(days: 1)),
        _selectedDate!.subtract(Duration(hours: 4)),
      ];

      for (var reminder in reminders) {
        if (reminder.isAfter(DateTime.now())) {
          await NotificationService.scheduleNotification(
            appointmentId as DateTime, // Notification ID (unique)
            reminder as String, // Scheduled time
            "Upcoming Appointment", // Title
            "Reminder: You have an appointment with $_selectedDoctor at $_selectedLocation." as int, // Body
            "appointment_reminder", // Payload
          );
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Appointment Booked Successfully!")),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReminderScreen(
            doctorName: _selectedDoctor!,
            appointmentDate: _selectedDate!,
            appointmentSlot: _selectedSlot!,
            appointmentLocation: _selectedLocation!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select all details before confirming."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Book Appointment",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Doctor", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _selectedDoctor,
              hint: const Text("Choose a doctor"),
              isExpanded: true,
              items: _doctors.map((doctor) {
                return DropdownMenuItem<String>(
                  value: doctor,
                  child: Text(doctor),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDoctor = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text("Select Date", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: _pickDate,
              child: Text(
                _selectedDate != null
                    ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                    : "Choose Date",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Select Time Slot", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _selectedSlot,
              hint: const Text("Choose a slot"),
              isExpanded: true,
              items: availableSlots.map((slot) {
                return DropdownMenuItem<String>(
                  value: slot,
                  child: Text(slot),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSlot = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text("Select Location", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _selectedLocation,
              hint: const Text("Choose a location"),
              isExpanded: true,
              items: _locations.map((location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLocation = newValue;
                });
              },
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () => _confirmAppointment(context),
                child: const Text("Confirm Appointment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
