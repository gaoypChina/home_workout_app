import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/helper/recent_workout_db_helper.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/main.dart';
import 'package:full_workout/pages/main/report_page/workout_report/workout_detail_report.dart';
import 'package:full_workout/widgets/active_goal_settings.dart';
import 'package:full_workout/pages/main/report_page/workout_report/weekly_workout_report.dart';
import 'package:intl/intl.dart';

class ActiveGoal extends StatefulWidget {
  @override
  _ActiveGoalState createState() => _ActiveGoalState();
}

class _ActiveGoalState extends State<ActiveGoal> {
  RecentDatabaseHelper recentDatabaseHelper = RecentDatabaseHelper();
  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();

  List<Workout> workoutList = [];
  List<ActiveDay> activeDayList = [];
  int completed;
  int daySelected;
  int trainingDay;

  _loadData() async {
    trainingDay = await spHelper.loadInt(spKey.trainingDay) ?? 7;
    daySelected = await spHelper.loadInt(spKey.firstDay) ?? 7;
    setState(() {});
    _getWorkDoneList();
  }

  _getWorkDoneList() async {
    activeDayList = [];
    completed = 0;
    int today = DateTime.now().weekday;
    DateTime startDate = (today - daySelected) >= 0
        ? DateTime.now().subtract(Duration(days: today - daySelected))
        : DateTime.now()
            .add(Duration(days: daySelected - today))
            .subtract(Duration(days: 7));
    DateTime endDate = startDate.add(Duration(days: 7));

    DateTime parsedStartDate =
        DateTime(startDate.year, startDate.month, startDate.day - 1);
    DateTime parsedEndDate =
        DateTime(endDate.year, endDate.month, endDate.day - 1);

    List items =
        await recentDatabaseHelper.getRangeData(parsedStartDate, parsedEndDate);

    for (int i = 0; i < 7; i++) {
      bool value = false;
      for (int j = 0; j < items.length; j++) {
        DateTime parsedDate = DateTime.parse(items[j]["date"]);
        DateTime currDate = startDate.add(Duration(days: i));
        print(parsedDate.day.toString() + " : " + currDate.day.toString());
        if (parsedDate.day == currDate.day &&
            parsedDate.month == currDate.month) {
          value = true;
          completed++;
          break;
        }
      }
      activeDayList.add(ActiveDay(
          index: i, isDone: value, date: startDate.add(Duration(days: i))));
    }

    setState(() {});
  }

  @override
  void initState() {
    _loadData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.white;
    double height =MediaQuery.of(context).size.height;
    getTitle() {
      onTap() async {
        var res = await showDialog(
            context: context,
            builder: (context) {
              return WeekGoalSettings();
            });
        if (res != null) {
          setState(() {
            daySelected = res[0];
            trainingDay = res[1];
            _getWorkDoneList();
          });
        }
      }

      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(16), topLeft: Radius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
          child: Row(
            children: [
              Text(
                "Week Goal ",
                style: textTheme.bodyText1.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: textColor),
              ),
              InkWell(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 8),
                  child: Row(
                    children: [
                      Icon(
                        Feather.edit,
                        size: 18,
                        color: textColor,
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Text(
                "$completed/$trainingDay",
                style: TextStyle(color: textColor),
              )
            ],
          ),
        ),
      );
    }

    getWeeklyUpdate() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: activeDayList
            .map((activeDay) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Column(
                    children: [
                      Text(
                        DateFormat('EEEE').format(activeDay.date)[0],
                        style: TextStyle(fontWeight: FontWeight.w600,color: textColor),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      CircleAvatar(
                          backgroundColor: DateTime.now().day == activeDay.date.day
                              ?Colors.white: activeDay.isDone
                             ?Colors.white
                              : Colors.grey.shade200,
                          child: CircleAvatar(
                            backgroundColor: activeDay.isDone
                                ? Colors.white
                                :  DateTime.now().day == activeDay.date.day
                                ?Colors.white:Colors.grey.shade200,
                            radius: 12,
                            child: activeDay.isDone
                                ? Icon(
                                    Icons.check,
                                    color: Colors.blue,
                                  )
                                : CircleAvatar(
                                    radius: 6,
                                    backgroundColor:
                                        DateTime.now().day == activeDay.date.day
                                            ? Colors.blue
                                            :DateTime.now().day >= activeDay.date.day?Colors.grey: Colors.grey.shade400,
                                  ),
                          ),
                          radius: 15),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        activeDay.date.day.toString(),
                        style: TextStyle(fontWeight: FontWeight.w500,color: textColor),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ))
            .toList(),
      );
    }

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child:InkWell(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    onTap: () => Navigator.pushNamed(context, WorkoutDetailReport.routeName),
    child:  Material(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          elevation: 2,
        child: Container(
          height: height*.16,

            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                gradient: LinearGradient(
                  colors: [Colors.blue.shade300,Colors.blue.shade700],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft
                )),
            child: Column(
              children: [
                getTitle(),
                getWeeklyUpdate(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
