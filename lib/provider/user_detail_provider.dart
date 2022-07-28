import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:full_workout/constants/constant.dart';
import 'package:full_workout/helper/weight_db_helper.dart';
import 'package:full_workout/provider/backup_provider.dart';
import 'package:full_workout/widgets/loading_indicator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../helper/sp_helper.dart';
import '../helper/sp_key_helper.dart';
import '../models/weight_model.dart';
import '../pages/main_page.dart';

class UserDetailProvider with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  String? name;
  int gender = 4;
  DateTime? dob;
  int unit = 0;
  double? weight;
  double? height;
  int? trainingDays;
  int? weeklyTrainingDay;
  int? firstDayOfWeek; //sat : 1, sun : 2, mon : 3
  bool isLoading = false;

  bool isStep1Completed = false;
  bool isStep2Completed = false;

  switchGender({required int index}) {
    gender = index;
    checkStep1();
    notifyListeners();
  }

  pickDOB({required BuildContext context}) async {
    final DateTime? picked = await showDatePicker(
      //theme: lightTheme,
      context: context,
      initialDate: DateTime(2000, 08, 12),
      firstDate: DateTime(DateTime.now().year - 110),
      lastDate: DateTime(DateTime.now().year - 12),
    );
    dob = picked;
    checkStep1();
    notifyListeners();
  }

  onNameSubmitted({required String? input}) {
    log(input.toString());
    name = input;
    checkStep1();
    notifyListeners();
  }

  checkStep1() {
    // log(gender.toString() + " " + name.toString() + " " + dob.toString());
    if (gender < 3 && nameController.text != "" && dob != null) {
      isStep1Completed = true;
      notifyListeners();
    }
  }

  setWeight(double value) async {
    SpHelper _spHelper = SpHelper();
    SpKey _spKey = SpKey();
    WeightDatabaseHelper _weightDb = WeightDatabaseHelper();
    weight = value;
    DateTime selectedDate = DateTime.now();
    await _spHelper.saveDouble(_spKey.weight, value);
    String key = DateFormat.yMd().format(selectedDate).toString();
    WeightModel weightModel = WeightModel(
      selectedDate.toIso8601String(),
      value,
      key,
      DateTime.now().millisecondsSinceEpoch,
    );
    await _weightDb.addWeight(value, weightModel, key);

    checkStep2();
    notifyListeners();
  }

  setHeight(double val) {
    height = val;
    checkStep2();
    notifyListeners();
  }

  switchUnit(int val) {
    unit = val;
    getHeightString;
    notifyListeners();
  }

  String get getHeightString {
    if (height != null) {
      if (unit == 0) {
        height!.roundToDouble();
        return "$height Cm";
      } else {
        double totalInches = height! / 2.54;
        int feet = totalInches ~/ 12;
        int inch = (totalInches - feet * 12).round();
        return "$feet ft, $inch in";
      }
    } else {
      return "Select your height";
    }
  }

  String get getWeightString {
    if (weight != null) {
      if (unit == 0) {
        return "$weight Kg";
      } else {
        return "${(weight! * 2.20462).roundToDouble()} Lbs";
      }
    } else {
      return "Enter your weight";
    }
  }

  checkStep2() {
    if (height != null && weight != null) {
      isStep2Completed = true;
      notifyListeners();
    }
  }

  setWeeklyTrainingDays(int? val) {
    weeklyTrainingDay = val;

    notifyListeners();
  }

  String get weeklyTrainingDayString {
    if (weeklyTrainingDay == null) {
      return "Total active days in week";
    } else {
      return weeklyTrainingDay == 1 ? "1 Day" : "$weeklyTrainingDay Days";
    }
  }

  setFirstDayOfWeek(int? val) {
    firstDayOfWeek = val;
    notifyListeners();
  }

  String get firstDayOfWeekString {
    if (firstDayOfWeek == null) {
      return "Select fist day of week";
    } else {
      if (firstDayOfWeek == 1) {
        return "Saturday";
      } else if (firstDayOfWeek == 2) {
        return "Sunday";
      } else {
        return "Monday";
      }
    }
  }

  saveLocalData() async {
    SpHelper _spHelper = SpHelper();
    SpKey _spKey = SpKey();
    await _spHelper.saveString(_spKey.name, nameController.text);
    await _spHelper.saveString(_spKey.date, dob!.toIso8601String());
    await _spHelper.saveInt(_spKey.gender, gender);
    await _spHelper.saveDouble(_spKey.height, height!);
    await _spHelper.saveDouble(_spKey.weight, weight!);
    await _spHelper.saveInt(_spKey.unit, unit);
    await _spHelper.saveInt(_spKey.trainingDay, trainingDays ?? 3);
    await _spHelper.saveInt(_spKey.firstDay, firstDayOfWeek ?? 1);
    await _spHelper.saveBool(_spKey.isGoalSet, true);
  }

  getLocalData() async{

    SpHelper _spHelper = SpHelper();
    SpKey _spKey = SpKey();
    name =await _spHelper.loadString(_spKey.name);
    nameController =TextEditingController(text: name);

    String? d =await _spHelper.loadString(_spKey.date);
    if(d != null){
      dob = DateTime.parse(d);
    }
    gender =await _spHelper.loadInt(_spKey.gender) ?? 3;

    height = await _spHelper.loadDouble(_spKey.height);
    weight = await _spHelper.loadDouble(_spKey.weight);
    unit = await _spHelper.loadInt(_spKey.unit)??0;
    notifyListeners();


  }

  saveData({required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    try {
      showDialog(context: context, builder: (builder)
      {
        return CustomLoadingIndicator(msg: "Creating profile",);
      });
      await saveLocalData();
      await Provider.of<BackupProvider>(context, listen: false)
          .syncData(context: context, isLoginPage: false,showMsg: false);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(e.toString()),
              ));
    } finally {
      isLoading = false;

      Constants().getToast("Profile Created Successfully");

      notifyListeners();
        Navigator.of(context).pushNamed(MainPage.routeName);
    }
  }
}
