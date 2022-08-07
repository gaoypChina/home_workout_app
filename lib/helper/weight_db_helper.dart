import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/weight_model.dart';

class WeightDatabaseHelper {
  static final WeightDatabaseHelper _instance =
      new WeightDatabaseHelper.internal();
  factory WeightDatabaseHelper() => _instance;
  final String tableName = "BmiReport";
  final String columnId = "id";
  final String columnDate = "date";
  final String columnWeight = "weight";
  final String columnKey = "key";

  Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  WeightDatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "WeightDb.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      "CREATE TABLE $tableName("
      "$columnId INTEGER PRIMARY KEY,"
      " $columnDate TEXT, "
      "$columnWeight REAL,"
      "$columnKey TEXT)",
    );
  }

  // Insert
  Future<int> saveWeight(WeightModel weightModel) async {
    var dbClient = await db;
    print("weight db : " + dbClient.toString());
    int res = await dbClient.insert('$tableName', weightModel.toMap());
    return res;
  }

  // Get Weight
  Future<List> getAllWeight() async {
    Database dbClient = await db;
    var result =
        await dbClient.rawQuery("SELECT * FROM $tableName ORDER BY $columnId");
    return result.toList();
  }

  Future<void> setAllWeightData({required List weightList}) async {
    var dbClient = await db;
    List allLocalWeight = await getAllWeight();
    for (var weight in weightList) {
      if (!isPresent(weight, allLocalWeight)) {
        await dbClient.insert('$tableName', weight);
      }
    }
  }

  bool isPresent(Map<String, dynamic> data, List allLocalWeight) {
    for (Map<String, dynamic> localWeight in allLocalWeight) {
      if (localWeight["id"] == data["id"]) {
        return true;
      }
    }
    return false;
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

  Future<List> getMaxWeight() async {
    var dbClient = await db;
    var result =
        await dbClient.rawQuery("SELECT MAX($columnWeight) FROM $tableName");
    return result.toList();
  }

  Future<List> getMinWeight() async {
    var dbClient = await db;
    var result =
        await dbClient.rawQuery("SELECT MIN($columnWeight) FROM $tableName");
    print("min len");
    print(result);
    return result.toList();
  }

  Future<List> getCurrWeight() async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableName ORDER BY $columnId DESC LIMIT 1");
    return result.toList();
  }

  Future<int?> getCount(String key) async {
    var dbClient = await db;
    int? result = Sqflite.firstIntValue(await dbClient.rawQuery(
        "SELECT COUNT(*) FROM $tableName WHERE $columnKey =?", [key]));
    return result;
  }

  Future<WeightModel?> getWeight(int id) async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableName WHERE $columnId = $id");
    if (result.length == 0) return null;
    return WeightModel.fromMap(result.first);
  }

  Future<int> deleteWeight(String key) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableName, where: "$columnKey = ?", whereArgs: [key]);
  }

  Future<int?> addWeight(
      double value, WeightModel weightModel, String key) async {
    var dbClient = await db;
    int? count;
    count = await getCount(key) ?? 0;
    if (count > 0) {
      return await dbClient.rawUpdate('''
      UPDATE $tableName SET $columnWeight = ? 
      WHERE $columnKey = ?
    ''', [value, key]);
    } else {
      return await saveWeight(weightModel);
    }
  }

  Future<int> updateWeight(WeightModel weightModel) async {
    var dbClient = await db;
    return await dbClient.update(tableName, weightModel.toMap(),
        where: "$columnId = ?", whereArgs: [weightModel.weight]);
  }

  Future<void> deleteDataBase() async {
    var dbClient = await db;
    dbClient.delete(tableName);

    // await close();
    // Directory documentDirectory = await getApplicationDocumentsDirectory();
    // String path = join(documentDirectory.path, "WeightDb.db");
    // await deleteDatabase(path);
  }

  Future close() async {
    var dbClient = await db;

    return dbClient.close();
  }
}
