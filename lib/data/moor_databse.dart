// import 'package:moor_flutter/moor_flutter.dart';

// part 'moor_database.g.dart';

// @DataClassName('Medicine')
// class Medicines extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   TextColumn get name => text().withLength(min: 1, max: 100)();
//   TextColumn get image => text().nullable()(); // Optional image URL
//   TextColumn get dose => text().withLength(min: 1, max: 50)();
// }

// @UseMoor(tables: [Medicines])
// class AppDatabase extends _$AppDatabase {
//   AppDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));

//   @override
//   int get schemaVersion => 1;

//   // Insert a medicine
//   Future<int> insertMedicine(Medicine medicine) => into(medicines).insert(medicine);

//   // Get all medicines
//   Future<List<Medicine>> getAllMedicines() => select(medicines).get();

//   // Update a medicine
//   Future<bool> updateMedicine(Medicine medicine) => update(medicines).replace(medicine);

//   // Delete a medicine
//   Future<int> deleteMedicine(Medicine medicine) => delete(medicines).delete(medicine);
// }
