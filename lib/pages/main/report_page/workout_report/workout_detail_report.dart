import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../../constants/constant.dart';
import '../../../../helper/recent_workout_db_helper.dart';
import '../../../../models/recent_workout.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class WorkoutDetailReport extends StatefulWidget {
  static const routeName = "workout-detail-report";
  @override
  _WorkoutDetailReportState createState() => _WorkoutDetailReportState();
}

class _WorkoutDetailReportState extends State<WorkoutDetailReport> {
  RecentDatabaseHelper workoutDb = RecentDatabaseHelper();
  List<RecentWorkout> recentWorkout = [];
  late double weightValue;
  late double lbsWeight;
  Constants constants = Constants();
  Map<DateTime, List<dynamic>> events = {};
  Map<DateTime, List<dynamic>> calenderEvents = {};
  List<List<RecentWorkout>> workoutModelList = [];
  Set<String> dateSet = {};
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.disabled;
  DateTime _focusedDay = DateTime.now();
  bool isLoading = true;

  _readWorkoutData() async {
    try {
      List items = await workoutDb.getAllWorkOut();
      print("length");
      print(items.length);
      items.forEach((element) {
        recentWorkout.add(RecentWorkout.map(element));
      });
    } catch (e) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              content: Text(e.toString()),
            );
          });
    }
  }

  Map<DateTime, List<dynamic>> _getWorkout() {
    print(recentWorkout.length);

    List<RecentWorkout> currDateWorkout = [];
    List workoutTitle = [];
    for (int i = 0; i < recentWorkout.length; i++) {
      DateTime date = DateTime.parse(recentWorkout[i].date);
      String formatedDay = DateFormat.yMMMd().format(date);
      dateSet.add(formatedDay);
    }
    print(dateSet);
    for (int i = 0; i < dateSet.length; i++) {
      currDateWorkout = [];
      workoutTitle = [];
      late RecentWorkout model;
      for (int j = 0; j < recentWorkout.length; j++) {
        DateTime date = DateTime.parse(recentWorkout[j].date);
        String formatedDay = DateFormat.yMMMd().format(date);
        dateSet.add(formatedDay);

        if (dateSet.elementAt(i) == formatedDay) {
          model = RecentWorkout(
              recentWorkout[j].date,
              recentWorkout[j].workoutTitle,
              recentWorkout[j].activeTime,
              recentWorkout[j].stars,
              recentWorkout[j].id,
              recentWorkout[j].calories,
              recentWorkout[j].exercise);
          currDateWorkout.add(model);
          workoutTitle.add(recentWorkout[j].workoutTitle);
        }
      }
      DateTime curr = DateTime.parse(model.date);
      events.addAll({curr: workoutTitle});

      calenderEvents
          .addAll({DateTime(curr.year, curr.month, curr.day): workoutTitle});
      workoutModelList.add(currDateWorkout);
    }
    return events;
  }

  Map<DateTime, List<dynamic>> _getWorkoutData() {
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

  setData() async {
    setState(() {
      isLoading = true;
    });
    log("cp1");
    await _readWorkoutData();
    log("cp2");
    _getWorkout();
    _getWorkoutData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  getCard(
    RecentWorkout workout,
    Size size,
  ) {
    getImage(String tag) {
      var tagList = tag.split(" ");
      if (tagList[0].toLowerCase() == "abs")
        return "assets/icons/exercises.png";
      if (tagList[0].toLowerCase() == "chest") return "assets/icons/chest.png";
      if (tagList[0].toLowerCase() == "shoulder")
        return "assets/icons/back.png";
      if (tagList[0].toLowerCase() == "legs") return "assets/icons/lunges.png";
      if (tagList[0].toLowerCase() == "arms") return "assets/icons/push-up.png";
      if (tagList[0].toLowerCase() == "full") return "assets/icons/lunges.png";
      return "assets/icons/exercises.png";
    }

    return Column(
      children: [
        Container(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.all(12),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade500.withOpacity(.1),
                      borderRadius: BorderRadius.all(Radius.circular(18))),
                  height: 70,
                  width: 70,
                  child: Image.asset(
                    getImage(workout.workoutTitle),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 8.0, left: 8, top: 18, bottom: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workout.workoutTitle,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        DateFormat(
                          "dd MMM yyyy, hh:mm aaa",
                        ).format(DateTime.parse(workout.date)),
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1,
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!
                                .withOpacity(.9)),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_filled,
                            color: Colors.green.withOpacity(.8),
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            timeFormat(workout.activeTime) + " Min",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                                fontSize: 12),
                          ),
                          Spacer(),
                          Icon(
                            Icons.local_fire_department_sharp,
                            color: Colors.orangeAccent.withOpacity(.8),
                            size: 20,
                          ),
                          Text(
                            " " +
                                (workout.activeTime * (18 / 60))
                                    .toStringAsFixed(2) +
                                " Cal",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                                fontSize: 12),
                          ),
                          Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          color: Theme.of(context).dividerColor,
        ),
      ],
    );
  }

  timeFormat(int time) {
    int sec = time % 60;
    int min = (time / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute:$second";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "History",
          ),
        ),
        body: isLoading == true
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: workoutModelList.length,
                itemBuilder: (context, index) {
                  List<RecentWorkout> currentDayWorkout =
                      workoutModelList[index];
                  if (index == 0) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: TableCalendar(
                            firstDay: DateTime(2021, 01, 01),
                            lastDay: DateTime.now(),
                            focusedDay: _focusedDay,
                            sixWeekMonthsEnforced: true,
                            calendarFormat: _calendarFormat,
                            rangeSelectionMode: _rangeSelectionMode,
                            availableGestures:
                                AvailableGestures.horizontalSwipe,
                            eventLoader: (DateTime event) {
                              log("event : " +
                                  DateTime.parse(event.toIso8601String())
                                      .toString());
                              if (calenderEvents[DateTime(
                                      event.year, event.month, event.day)] ==
                                  null) {
                                log("inside null");
                                return [];
                              } else {
                                List? temp = calenderEvents[DateTime(
                                    event.year, event.month, event.day)];
                                return temp ?? [];
                              }
                            },
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            daysOfWeekStyle: DaysOfWeekStyle(),
                            calendarStyle: CalendarStyle(
                                todayDecoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(34))),
                                markerDecoration: BoxDecoration(
                                    color: Colors.blue.shade200,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)))),
                            onFormatChanged: (format) {
                              if (_calendarFormat != format) {
                                setState(() {
                                  _calendarFormat = format;
                                });
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        constants.getDivider(context: context),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: currentDayWorkout.length,
                            itemBuilder: (context, idx) {
                              return getCard(currentDayWorkout[idx],
                                  MediaQuery.of(context).size);
                            }),
                      ],
                    );
                  } else {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: currentDayWorkout.length,
                        itemBuilder: (context, idx) {
                          return getCard(currentDayWorkout[idx],
                              MediaQuery.of(context).size);
                        });
                  }
                }));
  }
}
