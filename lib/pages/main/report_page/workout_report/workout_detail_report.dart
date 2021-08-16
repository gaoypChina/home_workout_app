import 'package:flutter/material.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/helper/recent_workout_db_helper.dart';
import 'package:full_workout/models/recent_workout.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_icons/flutter_icons.dart';

class WorkoutDetailReport extends StatefulWidget {
  static const routeName = "workout-detail-report";
  @override
  _WorkoutDetailReportState createState() => _WorkoutDetailReportState();
}
class _WorkoutDetailReportState extends State<WorkoutDetailReport> {
  RecentDatabaseHelper workoutDb = RecentDatabaseHelper();
  List<RecentWorkout> recentWorkout = [];
  double weightValue;
  double lbsWeight;
  Constants constants = Constants();
  Map<DateTime, List<dynamic>> events = {};
  List<List<RecentWorkout>> workoutModelList = [];
  Set<String> dateSet = {};
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.disabled;
  DateTime _focusedDay = DateTime.now();
  bool isLoading = true;

  _readWorkoutData() async {
    List items = await workoutDb.getAllWorkOut();
    items.forEach((element) {
      recentWorkout.add(RecentWorkout.map(element));
    });
  }

  Map<DateTime, List<dynamic>> _getWorkout() {
    print(recentWorkout.length);

    List<RecentWorkout> currDateWorkout = [];
    List workoutTitle = [];
    for (int i = 0; i < recentWorkout.length; i++) {
      print(i);
      DateTime date = DateTime.parse(recentWorkout[i].date);
      String formatedDay = DateFormat.yMMMd().format(date);
      dateSet.add(formatedDay);
    }
    print(dateSet);
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
    await _readWorkoutData();
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

  getCard(RecentWorkout workout, var size, bool isDark) {
    getImage(String tag) {
      var tagList = tag.split(" ");
      if (tagList[0].toLowerCase() == "abs")
        return "assets/animated-cover/abs.png";
      if (tagList[0].toLowerCase() == "chest")
        return "assets/animated-cover/chest.png";
      if (tagList[0].toLowerCase() == "shoulder")
        return "assets/animated-cover/sholder.png";
      if (tagList[0].toLowerCase() == "legs")
        return "assets/animated-cover/legs.png";
      if (tagList[0].toLowerCase() == "arms")
        return "assets/animated-cover/arms.png";
      if (tagList[0].toLowerCase() == "full")
        return "assets/animated-cover/full_body.png";
      return "assets/animated-cover/full_body.png";
    }

    Color textColor = isDark ? Colors.white : Colors.black;
    return Column(
      children: [
        Container(
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                      padding: EdgeInsets.all(24),
                      height: size.height * .12,
                      width: size.height * .18,
                      child: workout.workoutTitle.toLowerCase().contains("abs")
                          ? Image.asset(
                              getImage(workout.workoutTitle),
                            )
                          : Image.asset(
                              getImage(workout.workoutTitle),
                              color: isDark ? Colors.white : Colors.black,
                            ))),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat(
                          "dd MMM yyyy  |  hh:mm aaa",
                        ).format(DateTime.parse(workout.date)),
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        workout.workoutTitle,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: textColor),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            color: Colors.grey,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            timeFormat(workout.activeTime) + " Min",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                                fontSize: 12),
                          ),
                          Spacer(),
                          Icon(
                            SimpleLineIcons.fire,
                            color: Colors.grey,
                            size: 18,
                          ),

                          Text(
                            (workout.activeTime * (18 / 60))
                                    .toStringAsFixed(2) +
                                " Cal",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
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
        Divider(
          height: 1,
          color: Colors.grey,
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

  getDetail(var size, bool isDark) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: workoutModelList.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          List<RecentWorkout> events = workoutModelList[index];
          return ListView.builder(
              shrinkWrap: true,
              itemCount: events.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, idx) {
                return getCard(events[idx], size, isDark);
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "History",
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
        backgroundColor: isDark ? Colors.black : Colors.white,
      ),
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
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
                              if (events[DateTime(
                                      event.year, event.month, event.day)] ==
                                  null)
                                return [];
                              else
                                return events[DateTime(
                                    event.year, event.month, event.day)];
                            },
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: TextStyle(color: isDark?Colors.white:Colors.black),
                                weekendStyle: TextStyle(color: isDark?Colors.white:Colors.black)

                            ),
                            calendarStyle: CalendarStyle(
                              weekendTextStyle: TextStyle(color: isDark?Colors.white:Colors.black),
                                todayDecoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(34))),
                                markerDecoration: BoxDecoration(
                                    color: Colors.blue,
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
                        constants.getDivider(isDark),
                        getDetail(MediaQuery.of(context).size, isDark),
                        SizedBox(
                          height: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
