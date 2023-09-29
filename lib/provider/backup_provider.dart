import 'dart:developer' as dev;
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../constants/constant.dart';
import '../../../helper/backup_helper.dart';
import '../../../helper/recent_workout_db_helper.dart';
import '../../../helper/sp_helper.dart';
import '../../../helper/sp_key_helper.dart';
import '../../../helper/weight_db_helper.dart';

import '../enums/app_conection_status.dart';
import '../pages/subscription_page/subscription_page.dart';

class BackupProvider extends ChangeNotifier {
  BackupHelper _dbHelper = BackupHelper();
  SpKey _spKey = SpKey();
  SpHelper _spHelper = SpHelper();
  RecentDatabaseHelper _recentDatabaseHelper = RecentDatabaseHelper();
  WeightDatabaseHelper _weightDatabaseHelper = WeightDatabaseHelper();
  AppConnectionStatus connectionStatus = AppConnectionStatus.none;
  Constants _constants = Constants();

  syncData(
      {required BuildContext context,
      required bool isLoginPage,
      required bool showMsg}) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw "user not found";
      }
      connectionStatus = AppConnectionStatus.loading;
      notifyListeners();
      await _getUser(user: user);
      await _setUser(user: user);
      await _getProUser(user: user);
      await _setProUser(user: user);
      await _getUserActivity(uid: user.uid);
      await _setUserActivity(uid: user.uid);
      await _spHelper.saveString(
          _spKey.backupTime, DateTime.now().toIso8601String());
      if (showMsg) _constants.getToast("Data Backup Successfully");
    } catch (e) {
      dev.log("syncing error : " + e.toString());
      if (showMsg) _constants.getToast("something went wrong");
    } finally {
      connectionStatus = AppConnectionStatus.success;
      notifyListeners();
    }
  }

  dailyBackup() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw "user not found";
      }
      String? savedTime = await _spHelper.loadString(_spKey.backupTime);
      bool isNewDay = false;
      if (savedTime != null) {
        isNewDay =
            DateTime.now().difference(DateTime.parse(savedTime)).inHours > 24;
      }

      if (savedTime == null || isNewDay) {
        await _getUser(user: user);
        await _setUser(user: user);
        await _getProUser(user: user);
        await _setProUser(user: user);
        await _getUserActivity(uid: user.uid);
        await _setUserActivity(uid: user.uid);

        await _spHelper.saveString(
            _spKey.backupTime, DateTime.now().toIso8601String());
      }
    } catch (e) {
      dev.log("daily backup error ${e.toString()}");
    }
  }



  saveData({required User user}) async {
    await _setUser(user: user);
    await _setProUser(user: user);
    await _setUserActivity(uid: user.uid);
  }

  _getUser({required User user}) async {
    var _snapshot = await _dbHelper.getUser(uid: user.uid);
    Map<String, dynamic>? _userData = _snapshot.data() as Map<String, dynamic>?;
    if (_userData == null) return;

    String? name = await _spHelper.loadString(_spKey.name);
    String? dob = await _spHelper.loadString(_spKey.date);
    int? gender = await _spHelper.loadInt(_spKey.gender);
    double? height = await _spHelper.loadDouble(_spKey.height);
    double? weight = await _spHelper.loadDouble(_spKey.weight);
    int? unit = await _spHelper.loadInt(_spKey.unit);

    if (_userData["name"] != null && name == null)
      await _spHelper.saveString(_spKey.name, _userData["name"]);

    if (_userData["dob"] != null && dob == null)
      await _spHelper.saveString(_spKey.date, _userData["dob"]);

    if (_userData["gender"] != null && gender == null)
      await _spHelper.saveInt(_spKey.gender, _userData["gender"]);

    if (_userData["height"] != null && height == null)
      await _spHelper.saveDouble(_spKey.height, _userData["height"]);

    if (_userData["weight"] != null && weight == null)
      await _spHelper.saveDouble(_spKey.weight, _userData["weight"]);

    if (_userData["unit"] != null && unit == null)
      await _spHelper.saveInt(_spKey.unit, _userData["unit"]);
  }

  _setUser({required User user}) async {
    String? name = await _spHelper.loadString(_spKey.name);
    String? dob = await _spHelper.loadString(_spKey.date);
    int? gender = await _spHelper.loadInt(_spKey.gender);
    double? height = await _spHelper.loadDouble(_spKey.height);
    double? weight = await _spHelper.loadDouble(_spKey.weight);
    int? unit = await _spHelper.loadInt(_spKey.unit);
    String? email = user.email;

    _dbHelper.saveUser(
        uid: user.uid,
        name: name,
        dob: dob,
        gender: gender,
        height: height,
        weight: weight,
        unit: unit,
        email: email);
  }

  _getProUser({required User user}) async {
    var _snapshot = await _dbHelper.getProUser(uid: user.uid);
    Map<String, dynamic>? _proUserData =
        _snapshot.data() as Map<String, dynamic>?;
    if (_proUserData == null) return;

    if (_proUserData["fist_date"] != null)
      await _spHelper.saveString(
          _spKey.subscriptionFistDate, _proUserData["first_date"]);

    if (_proUserData["last_date"] != null)
      await _spHelper.saveString(
          _spKey.subscriptionLastDate, _proUserData["last_date"]);
  }

  _setProUser({required User user}) async {
    String? firstDate = await _spHelper.loadString(_spKey.subscriptionFistDate);
    String? lastDate = await _spHelper.loadString(_spKey.subscriptionLastDate);
    String? price = await _spHelper.loadString(_spKey.subscriptionPrice);
    if (firstDate == null || lastDate == null || price == null) return;

    _dbHelper.saveProUser(
        uid: user.uid,
        firstDate: firstDate,
        lastDate: lastDate,
        userName: user.displayName,
        price: price);
  }

  _getUserActivity({required String uid}) async {
    var _snapshot = await _dbHelper.getUserActivity(uid: uid);
    Map<String, dynamic>? _userData = _snapshot.data() as Map<String, dynamic>?;
    if (_userData == null) return;
    List workoutList = _userData["workouts"] ?? [];
    List weightList = _userData["weights"] ?? [];
    Map<String, dynamic>? workoutData = _userData["workout_data"];
    await _weightDatabaseHelper.setAllWeightData(weightList: weightList);
    await _recentDatabaseHelper.setAllWorkout(workoutList: workoutList);
    if (workoutData != null) {
      await _setWorkoutData(workoutData: workoutData);
    }
  }

  _setWorkoutData({required Map<String, dynamic> workoutData}) async {
    /// full body day
    int localFullBodyDay =
        await _spHelper.loadInt(_spKey.fullBodyChallenge) ?? 0;
    int cloudFullBodyDay = workoutData["full_body"] ?? 0;

    await _spHelper.saveInt(
        _spKey.fullBodyChallenge, max(localFullBodyDay, cloudFullBodyDay));

    ///abs workout day
    int localAbsDay = await _spHelper.loadInt(_spKey.absChallenge) ?? 0;
    int cloudAbsDay = workoutData["abs"] ?? 0;
    await _spHelper.saveInt(_spKey.absChallenge, max(localAbsDay, cloudAbsDay));

    ///chest workout day
    int localChestDay = await _spHelper.loadInt(_spKey.chestChallenge) ?? 0;
    int cloudChestDay = workoutData["chest"] ?? 0;
    await _spHelper.saveInt(
        _spKey.chestChallenge, max(localChestDay, cloudChestDay));

    ///arms workout day
    int localArmsDay = await _spHelper.loadInt(_spKey.armChallenge) ?? 0;
    int cloudArmsDay = workoutData["arms"] ?? 0;
    await _spHelper.saveInt(
        _spKey.armChallenge, max(localArmsDay, cloudArmsDay));

    ///set exercise data
    int? localExercise = await _spHelper.loadInt(_spKey.exercise);
    int? cloudExercise = workoutData["exercise"];
    if (localExercise != null && cloudExercise != null) {
      int maxExe = max(localExercise, cloudExercise);
      await _spHelper.saveInt(_spKey.exercise, maxExe);
    } else if (localExercise != null) {
      await _spHelper.saveInt(_spKey.exercise, localExercise);
    } else if (cloudExercise != null) {
      await _spHelper.saveInt(_spKey.exercise, cloudExercise);
    } else {
      await _spHelper.saveInt(_spKey.exercise, 0);
    }

    ///set time data
    int? localTime = await _spHelper.loadInt(_spKey.time);
    int? cloudTime = workoutData["time"];
    if (localTime != null && cloudTime != null) {
      int maxTime = max(localTime, cloudTime);
      await _spHelper.saveInt(_spKey.time, maxTime);
    } else if (localTime != null) {
      await _spHelper.saveInt(_spKey.time, localTime);
    } else if (cloudTime != null) {
      await _spHelper.saveInt(_spKey.time, cloudTime);
    } else {
      await _spHelper.saveInt(_spKey.time, 0);
    }

    if (workoutData["total_training_day"] != null &&
        workoutData["training_first_day"] != null &&
        workoutData["goal_set"] != null) {
      await _spHelper.saveInt(
          _spKey.trainingDay, workoutData["total_training_day"]);
      await _spHelper.saveInt(
          _spKey.firstDay, workoutData["training_first_day"]);
      await _spHelper.saveBool(_spKey.isGoalSet, workoutData["goal_set"]);
    }
  }

  _setUserActivity({required String uid}) async {
    List workoutList = await _recentDatabaseHelper.getAllWorkOut();
    List weightList = await _weightDatabaseHelper.getAllWeight();
    Map<String, dynamic> workoutData = await _getUserWorkoutData();

    _dbHelper.saveUserActivity(
        uid: uid,
        workouts: workoutList,
        weights: weightList,
        workoutData: workoutData);
  }

  Future<Map<String, dynamic>> _getUserWorkoutData() async {
    int? fullBody = await _spHelper.loadInt(_spKey.fullBodyChallenge);
    int? abs = await _spHelper.loadInt(_spKey.absChallenge);
    int? chest = await _spHelper.loadInt(_spKey.chestChallenge);
    int? arms = await _spHelper.loadInt(_spKey.armChallenge);
    int? exercise = await _spHelper.loadInt(_spKey.exercise);
    int? time = await _spHelper.loadInt(_spKey.time);
    int? totalTrainingDay = await _spHelper.loadInt(_spKey.trainingDay);
    int? trainingFirstDay = await _spHelper.loadInt(_spKey.firstDay);
    bool? goalSet = await _spHelper.loadBool(_spKey.isGoalSet);
    Map<String, dynamic> workoutData = {};
    workoutData["full_body"] = fullBody;
    workoutData["abs"] = abs;
    workoutData["chest"] = chest;
    workoutData["arms"] = arms;
    workoutData["exercise"] = exercise;
    workoutData["time"] = time;
    workoutData["total_training_day"] = totalTrainingDay;
    workoutData["training_first_day"] = trainingFirstDay;
    workoutData["goal_set"] = goalSet;
    return workoutData;
  }

  resetUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    try {
      Map<String, dynamic> workoutData = await _getUserWorkoutData();
      await _dbHelper.resetUserProgress(
          uid: user.uid, workoutData: workoutData);
    } catch (e) {
      dev.log(e.toString());
    }
  }
}
