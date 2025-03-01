import 'package:health/models/doctor_model.dart';

// Doctor data for Hospital-1
Doctor arun = Doctor(
  name: 'Dr. Arun Sharma',
  email: 'arun.sharma@gmail.com',
  pass: "123456",
  hospitalName: 'Hospital-1',
);

// Doctor data for Hospital-2
Doctor neha = Doctor(
  name: 'Dr. Neha Verma',
  email: 'neha.verma@gmail.com',
  pass: "123456",
  hospitalName: 'Hospital-2',
);

// Doctor data for Hospital-3
Doctor rajiv = Doctor(
  name: 'Dr. Rajiv Malhotra',
  email: 'rajiv.malhotra@gmail.com',
  pass: "123456",
  hospitalName: 'Hospital-3',
);

// Doctor data for Hospital-4
Doctor sneha = Doctor(
  name: 'Dr. Sneha Kapoor',
  email: 'sneha.kapoor@gmail.com',
  pass: "123456",
  hospitalName: 'Hospital-4',
);

// List of Doctors
List<Doctor> doctors = [arun, neha, rajiv, sneha];
