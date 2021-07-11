import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../models/weight_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class WeightDatabaseHelper {
  static final WeightDatabaseHelper _instance = new WeightDatabaseHelper.internal();
  factory WeightDatabaseHelper() => _instance;
  final String tableName = "BmiReport";
  final String columnId = "id";
  final String columnDate = "date";
  final String columnWeight = "weight";
  final String columnKey = "key";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
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
    int res = await dbClient.insert('$tableName', weightModel.toMap());
    return res;
  }

  // Get Weight
  Future<List> getAllWeight() async {
    print("here");
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableName ORDER BY $columnId DESC");
    return result.toList();
  }

  Future<List> getRangeData(DateTime currDate) async{
    var dbClient = await db;
    String fromDate = "${currDate.year}-${currDate.month}";
    String toDate = "${currDate.year}-${currDate.month+1}";
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableName WHERE $columnDate BETWEEN  $fromDate AND $toDate");
    return result.toList();
  }

  Future<double> getMaxWeight() async{
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT MAX($columnWeight) FROM $tableName");

    print("max"+result.toString());
  }


  Future<int> getCount(String key) async {
    var dbClient = await db;
   var result =  Sqflite.firstIntValue(
     await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName WHERE $columnKey =?",[key])
   );
   return result;
  }

  Future<WeightModel> getWeight(int id) async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableName WHERE $columnId = $id");
    if (result.length == 0) return null;
    return WeightModel.fromMap(result.first);
  }

  Future<int> deleteWeight(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableName, where: "$columnId = ?", whereArgs: [id]);
  }


  Future<int> addWeight(double value, WeightModel weightModel, String key) async {
    var dbClient = await db;
    int count =1;
    await getCount(key).then((value) => count = value);
    if(count > 0){
     return await dbClient.rawUpdate('''
      UPDATE $tableName SET $columnWeight = ? 
      WHERE $columnKey = ?
    ''', [value, key]);
    }else{
     return await saveWeight( weightModel);
    }
  }

  Future<int> updateWeight(WeightModel weightModel) async {
    var dbClient = await db;
    return await dbClient.update(tableName, weightModel.toMap(),
        where: "$columnId = ?", whereArgs: [weightModel.weight]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
