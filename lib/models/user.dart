class User {
  final String name;
  final String email;
  final String pass;
  final String role; // Role can be 'doctor' or 'patient'

  User({required this.name, required this.email, required this.pass, required this.role});
}