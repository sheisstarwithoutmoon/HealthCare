import 'package:health/patient_screens/services/notification_service.dart';
import 'package:health/models/appointment.dart';

class ReminderService {
  static const List<Duration> reminderIntervals = [
    Duration(days: 7),   // 1 week before
    Duration(days: 3),   // 3 days before
    Duration(days: 1),   // 1 day before
    Duration(hours: 4),  // 4 hours before
    Duration(hours: 1),  // 1 hour before
  ];
  
  static Future<void> scheduleAppointmentReminders(Appointment appointment) async {
    // Schedule multiple reminders at different intervals
    for (var interval in reminderIntervals) {
      DateTime reminderTime = appointment.date.subtract(interval);
      
      // Only schedule if the reminder time is in the future
      if (reminderTime.isAfter(DateTime.now())) {
        String timeDescription = _getTimeDescription(interval);
        
        await NotificationService.scheduleNotification(
          reminderTime,
          "Upcoming Appointment",
          "Reminder: You have an appointment with ${appointment.doctorName} at ${appointment.location} ${timeDescription}. Time: ${appointment.slot}",
          appointment.id,
          "reminder_${interval.inHours}",
        );
      }
    }
    
    // Also schedule a "day of" notification
    DateTime dayOfReminder = DateTime(
      appointment.date.year,
      appointment.date.month,
      appointment.date.day,
      8, 0, 0, // 8:00 AM on appointment day
    );
    
    if (dayOfReminder.isAfter(DateTime.now())) {
      await NotificationService.scheduleNotification(
        dayOfReminder,
        "Appointment Today",
        "You have an appointment with ${appointment.doctorName} today at ${appointment.slot} at ${appointment.location}.",
        appointment.id,
        "day_of",
      );
    }
  }
  
  static String _getTimeDescription(Duration interval) {
    if (interval.inDays >= 1) {
      return interval.inDays == 1 ? "tomorrow" : "in ${interval.inDays} days";
    } else if (interval.inHours >= 1) {
      return "in ${interval.inHours} hours";
    } else {
      return "soon";
    }
  }
  
  static Future<void> cancelAppointmentReminders(int appointmentId) async {
    await NotificationService.cancelAppointmentNotifications(appointmentId);
  }
  
  static Future<void> rescheduleAppointmentReminders(Appointment updatedAppointment) async {
    // First cancel all existing reminders
    await cancelAppointmentReminders(updatedAppointment.id);
    // Then schedule new ones
    await scheduleAppointmentReminders(updatedAppointment);
  }
}