import 'dart:async';
import 'dart:developer';
import 'dart:io';

import '../models/recent_workout.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class RecentDatabaseHelper {
  static final RecentDatabaseHelper _instance = new RecentDatabaseHelper.internal();
  factory RecentDatabaseHelper() => _instance;
  final String tableName = "Workout";
  final String columnId = "id";
  final String columnDate = "date";
  final String columnActiveTime = "activeTime";
  final String columnWorkoutTitle = "workoutTitle";
  final String columnStars = "stars";
  final String columnCalories = "calories";
  final String columnExercise = "exercise";

    Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  RecentDatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "RecentWorkout.db");
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
    Database dbClient = await db;
    int res = await dbClient.insert('$tableName', recentWorkout.toMap());
    return res;
  }

  // Get Task
  Future<List> getAllWorkOut() async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableName ORDER BY $columnId DESC");
    log("results : " + result.toString());
    return result.toList();
  }

 Future<void> setAllWorkout({required List workoutList})async{
      Database dbClient = await db;
      List allLocalWorkout = await getAllWorkOut();
      for(Map<String,dynamic> workout in workoutList){
        if(!isPresent(workout, allLocalWorkout)){
          await dbClient.insert('$tableName', workout);
        }
      }

  }

 bool isPresent(Map<String,dynamic> data, List allLocalWorkout){
    for(Map<String,dynamic> localWorkout in allLocalWorkout){
      if(localWorkout["id"] == data["id"]){
        return true;
      }
    }
    return false;
  }

  Future<int?> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName"));
  }

  Future<RecentWorkout?> getWorkOut(int id) async {
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

  Future<List> getRangeData(DateTime selectedFromDate, selectedToDate) async {
    String twoDigitDate(String date) {
      if (date.length <= 1) {
        return "0$date";
      }
      return date;
    }

    String fromDate =
        "${selectedFromDate.year}-${twoDigitDate(selectedFromDate.month.toString())}-${twoDigitDate(selectedFromDate.day.toString())}";
    String toDate =
        "${selectedToDate.year}-${twoDigitDate(selectedToDate.month.toString())}-${twoDigitDate(selectedToDate.day.toString())}";
    print("fromDate: $fromDate, toDate: $toDate");

    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM $tableName WHERE $columnDate >= '$fromDate' AND $columnDate <= '$toDate' ORDER BY $columnDate DESC");
    return result.toList();
  }

  Future<void> deleteDataBase()async{
    print("deleted");
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "RecentWorkout.db");
   await deleteDatabase(path);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
