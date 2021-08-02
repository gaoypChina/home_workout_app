import 'package:flutter/material.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/helper/recent_workout_db_helper.dart';
import 'package:full_workout/helper/weight_db_helper.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/models/recent_workout.dart';
import 'package:full_workout/models/weight_model.dart';
import 'package:full_workout/pages/main/home_page/leading_widget.dart';
import 'package:full_workout/pages/main/report_page/weight_report/weight_report_detail.dart';
import 'package:full_workout/pages/main/report_page/weight_report/weight_report.dart';
import 'package:full_workout/pages/main/report_page/weight_report/weight_report_statics.dart';
import 'package:full_workout/pages/main/report_page/workout_report/weekly_workout_report.dart';
import 'package:full_workout/pages/main/report_page/workout_report/workout_detail_report.dart';
import 'package:full_workout/pages/services/bmi_service/bmi_card.dart';
import 'package:full_workout/widgets/achivement.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';

class ReportPage extends StatefulWidget {
  static const routeName = "report-page";

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  WeightDatabaseHelper weightDb = WeightDatabaseHelper();
  SpHelper spHelper = SpHelper();
  Constants constants = Constants();
  SpKey spKey = SpKey();
  RecentDatabaseHelper workoutDb = RecentDatabaseHelper();
  List<WeightModel> weight = [];

  Map<DateTime, List<dynamic>> events = {};
  List<RecentWorkout> recentWorkout = [];
  List<List<RecentWorkout>> workoutModelList = [];
  Set<String> dateSet = {};

  _readWeightData() async {
    print(weight.length);
    List items = await weightDb.getAllWeight();
    items.forEach((element) {
      setState(() {
        weight.add(WeightModel.map(element));
      });
    });
    print("Weight data = " + weight.length.toString());
  }

  _readWorkoutData() async {
    recentWorkout = [];
    List items = await workoutDb.getAllWorkOut();
    items.forEach((element) {
      setState(() {
        recentWorkout.add(RecentWorkout.map(element));
      });
    });
  }

  Map<DateTime, List<dynamic>> _getWorkout() {
    List<RecentWorkout> currDateWorkout = [];
    List workoutTitle = [];
    workoutModelList = [];
    for (int i = 0; i < recentWorkout.length; i++) {
      DateTime date = DateTime.parse(recentWorkout[i].date);
      String formatedDay = DateFormat.yMMMd().format(date);
      dateSet.add(formatedDay);
    }
    for (int i = 0; i < dateSet.length; i++) {
      currDateWorkout = [];
      workoutTitle = [];
      RecentWorkout model;
      for (int j = 0; j < recentWorkout.length; j++) {
        DateTime date = DateTime.parse(recentWorkout[j].date);
        String formatedDay = DateFormat.yMMMd().format(date);
        dateSet.add(formatedDay);

        print("${dateSet.elementAt(i)}    and     $formatedDay\n");
        if (dateSet.elementAt(i) == formatedDay) {
          model = RecentWorkout(
              recentWorkout[j].date,
              recentWorkout[j].workoutTitle,
              recentWorkout[j].activeTime,
              recentWorkout[j].stars,
              recentWorkout[j].calories,
              recentWorkout[j].exercise);
          currDateWorkout.add(model);
          workoutTitle.add(recentWorkout[j].workoutTitle);
        }
      }
      events.addAll({DateTime.parse(model.date): workoutTitle});
      workoutModelList.add(currDateWorkout);
    }
    return events;
  }

  Map<DateTime, List<dynamic>> _getWorkoutData() {
    events = {};
    int n = recentWorkout.length - 1;
    int i = 0;
    int j = 1;
    List<dynamic> title = [];
    for (i = 0; i < n; i++) {
      DateTime date = DateTime.parse(recentWorkout[i].date);
      print(date);
      String workoutTitle = recentWorkout[i].workoutTitle;
      String formatedDayI =
          DateFormat.yMMMd().format(DateTime.parse(recentWorkout[i].date));
      String formatedDayJ =
      DateFormat.yMMMd().format(DateTime.parse(recentWorkout[j].date));
      print(formatedDayI + " and " + formatedDayJ);
      if (formatedDayI == formatedDayJ) {
        print("$formatedDayI : $workoutTitle");
        title.add(workoutTitle as dynamic);
        print(i);
        j++;
        continue;
      } else {
        j++;
        print("$formatedDayI : $workoutTitle");
        title.add(workoutTitle as dynamic);
        setState(() {
          events.addAll({date: title});
        });
        title = [];
      }
    }
    print(events);
    return events;
  }


  @override
  void initState() {
    _readWorkoutData();
    _readWeightData();
    _getWorkout();
    _getWorkoutData();
    super.initState();
  }


  DateTime initDate = DateTime.now();
  double initWeight = 0.0;

  @override
  Widget build(BuildContext context) {

      initDate = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        actions: getLeading(context),
        automaticallyImplyLeading: false,
        title: Text(
          "Report",
          style: TextStyle(color: constants.appBarContentColor),
        ),
        backgroundColor: constants.appBarColor,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [

          SizedBox(height: 20,),
            Achievement(onTap: (){},),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                Text(
                  "History",
                  style:
                      textTheme.subtitle1.copyWith(fontWeight: FontWeight.w700),
                ),
                Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WorkoutDetailReport(

                              )));
                    },
                    child: Text(
                      "More",
                      style: textTheme.button,
                    )),
              ],
            ),
          ),
          WeeklyWorkoutReport(),

          constants.getDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                Text(
                  "Weight",
                  style:
                      textTheme.subtitle1.copyWith(fontWeight: FontWeight.w700),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeightReportDetail()));
                  },
                  child: Text(
                    "More",
                    style: textTheme.button,
                  ),
                ),
              ],
            ),
          ),
          Container(child: WeightReport()),
          WeightReportStatics(),
          constants.getDivider(),
          BmiCard(showBool: false,),
        ],
      ),
    );
  }
}
