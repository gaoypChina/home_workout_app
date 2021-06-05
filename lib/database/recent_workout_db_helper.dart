import 'dart:async';
import 'dart:io';

import '../models/recent_workout.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  final String tableName = "Workout";
  final String columnId = "id";
  final String columnDate = "date";
  final String columnActiveTime = "activeTime";
  final String columnWorkoutTitle = "workoutTitle";
  final String columnStars = "stars";
  final String columnCalories = "calories";
  final String columnExercise = "exercise";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "WorkoutData.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      "CREATE TABLE $tableName("
      "$columnId INTEGER PRIMARY KEY,"
      " $columnDate TEXT, "
          "$columnWorkoutTitle TEXT,"
      "$columnActiveTime INTEGER,"
          "$columnStars INTEGER,"
          "$columnCalories REAL,"
          "$columnExercise INTEGER)",
    );
  }

  // Insert
  Future<int> saveWorkOut(RecentWorkout recentWorkout) async {
    var dbClient = await db;
    int res = await dbClient.insert('$tableName', recentWorkout.toMap());
    return res;
  }

  // Get Task
  Future<List> getAllWorkOut() async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableName ORDER BY $columnId ASC");
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName"));
  }

  Future<RecentWorkout> getWorkOut(int id) async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableName WHERE $columnId = $id");
    if (result.length == 0) return null;
    return RecentWorkout.fromMap(result.first);
  }

  Future<int> deleteWorkOut(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableName, where: "$columnId = ?", whereArgs: [id]);
  }



  Future<int> updateWorkout(RecentWorkout recentWorkout) async {
    var dbClient = await db;
    return await dbClient.update(tableName, recentWorkout.toMap(),
        where: "$columnId = ?", whereArgs: [recentWorkout.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
