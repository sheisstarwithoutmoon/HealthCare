import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:health/models/appointment.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = "appointments";

  // Initialize the database
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  // Create database
  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'appointments.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId TEXT,
            doctorName TEXT,
            date TEXT,
            slot TEXT,
            location TEXT,
            status TEXT
          )
        ''');
      },
    );
  }

  // Insert appointment
  static Future<int> insertAppointment(Appointment appointment) async {
    final db = await database;
    return await db.insert(tableName, appointment.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Get all appointments
  static Future<List<Appointment>> getAppointments() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (i) {
      return Appointment.fromJson(maps[i]);
    });
  }

  // Update appointment
  static Future<int> updateAppointment(Appointment appointment) async {
    final db = await database;
    return await db.update(
      tableName,
      appointment.toJson(),
      where: 'id = ?',
      whereArgs: [appointment.id],
    );
  }

  // Delete appointment
  static Future<int> deleteAppointment(int id) async {
    final db = await database;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
