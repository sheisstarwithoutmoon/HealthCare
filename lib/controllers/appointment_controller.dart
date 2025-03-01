import 'package:get/get.dart';
import 'package:health/models/appointment.dart';
import 'package:health/data/database_helper.dart';

class AppointmentController extends GetxController {
  var appointments = <Appointment>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAppointments();
  }

  // Load appointments from DB
  Future<void> loadAppointments() async {
    List<Appointment> appointmentList = await DatabaseHelper.getAppointments();
    appointments.assignAll(appointmentList);
  }

  // Add appointment
  Future<void> addAppointment(Appointment appointment) async {
    int id = await DatabaseHelper.insertAppointment(appointment);
    Appointment newAppointment = appointment.copyWith(id: id);
    appointments.add(newAppointment);
  }

  // Update appointment
  Future<void> updateAppointment(Appointment appointment) async {
    int result = await DatabaseHelper.updateAppointment(appointment);
    if (result > 0) {
      int index = appointments.indexWhere((a) => a.id == appointment.id);
      if (index != -1) {
        appointments[index] = appointment;
      }
    }
  }

  // Delete appointment
  Future<void> deleteAppointment(int id) async {
    int result = await DatabaseHelper.deleteAppointment(id);
    if (result > 0) {
      appointments.removeWhere((a) => a.id == id);
    }
  }

  bookAppointment(Appointment appointment) {}
}
