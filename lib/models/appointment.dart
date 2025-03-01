class Appointment {
  final int id;
  final String userId;
  final String doctorName;
  final DateTime date;
  final String slot;
  final String location;
  final String status;

  Appointment({
    required this.id,
    required this.userId,
    required this.doctorName,
    required this.date,
    required this.slot,
    required this.location,
    this.status = "upcoming",
  });

  // Convert Appointment to JSON for SQLite
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'doctorName': doctorName,
      'date': date.toIso8601String(),
      'slot': slot,
      'location': location,
      'status': status,
    };
  }

  // Create an Appointment object from JSON
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      userId: json['userId'],
      doctorName: json['doctorName'],
      date: DateTime.parse(json['date']),
      slot: json['slot'],
      location: json['location'],
      status: json['status'],
    );
  }

  // Copy method for updating values
  Appointment copyWith({int? id}) {
    return Appointment(
      id: id ?? this.id,
      userId: userId,
      doctorName: doctorName,
      date: date,
      slot: slot,
      location: location,
      status: status,
    );
  }
}
