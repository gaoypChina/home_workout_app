import 'package:flutter/material.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/helper/recent_workout_db_helper.dart';
import 'package:full_workout/models/recent_workout.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timelines/timelines.dart';

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

  getCard(RecentWorkout workout) {
    Color textColor = Colors.white;
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: Colors.blue.shade700, // getBgColor(workout.workoutTitle),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 4,
          ),
          Text(
            DateFormat("dd,MMMM yyyy hh:mm aaa")
                .format(DateTime.parse(workout.date)),
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 16, color: textColor),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            workout.workoutTitle,
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 18, color: textColor),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Icon(
                Icons.timer,
                color: textColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                timeFormat(workout.activeTime) + " Min",
                style: TextStyle(color: textColor),
              ),
              SizedBox(
                width: 28,
              ),
              Icon(
                Icons.local_fire_department,
                color: textColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                (workout.activeTime * (18 / 60)).toString() + " Cal",
                style: TextStyle(color: textColor),
              )
            ],
          ),
          SizedBox(
            height: 4,
          )
        ],
      ),
    );
  }
  timeFormat(int time) {
    int sec = time % 60;
    int min = (time / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";

    return "$minute:$second";
  }
  getDetail() {






    return ListView.builder(
        shrinkWrap: true,
        itemCount: workoutModelList.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          List<RecentWorkout> events = workoutModelList[index];
          return Container(
            child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    DateFormat("dd,MMMM yyyy")
                        .format(DateTime.parse(events[0].date)),
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                  ),
                ),
                subtitle: ListView.builder(
                    shrinkWrap: true,
                    itemCount: events.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, idx) {
                      return getCard(events[idx]);
                    })),
          );
        });
  }

  getChallenges() {
    return ListView(
      shrinkWrap: true,
        children: [
      FixedTimeline.tileBuilder(
          theme: TimelineThemeData(
            nodePosition: 0,
            color: Colors.blue,
            indicatorTheme: IndicatorThemeData(
              position: 0.028,
              size: 18.0,
            ),
            connectorTheme: ConnectorThemeData(
              thickness: 2.5,
            ),
          ),
          builder: TimelineTileBuilder.connected(
              connectionDirection: ConnectionDirection.before,
              itemCount: workoutModelList.length,
              indicatorBuilder: (_, index) {
                if (index < 2) {
                  return Indicator.dot(
                    size: 20,
                    child: Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    ),
                    color: Colors.blue.shade700,
                  );
                }
                return Indicator.dot(
                  color: Colors.grey,
                  child: Icon(
                    Icons.flash_on,
                    size: 15,
                    color: Colors.white,
                  ),
                  size: 20,
                );
              },
              connectorBuilder: (_, index, ___) => index > 1
                  ? DashedLineConnector(
                      color: Colors.grey,
                      dash: 1,
                    )
                  : SolidLineConnector(color: Theme.of(context).primaryColor),
              contentsBuilder: (context, index) {

                return  ListView.builder(
                    shrinkWrap: true,
                    itemCount: events.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, idx) {
                      return getCard(events[index][idx]);
                    });
              }))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Report'),
      ),
      body: isLoading == true
          ? CircularProgressIndicator()
          : getChallenges(),
      // SingleChildScrollView(
      //         physics: BouncingScrollPhysics(),
      //         child: Column(
      //           children: [
      //             Container(
      //               child: TableCalendar(
      //                 firstDay: DateTime(2019, 01, 01),
      //                 lastDay: DateTime.now(),
      //                 focusedDay: _focusedDay,
      //                 sixWeekMonthsEnforced: true,
      //                 calendarFormat: _calendarFormat,
      //                 rangeSelectionMode: _rangeSelectionMode,
      //                 availableGestures: AvailableGestures.horizontalSwipe,
      //                 eventLoader: (DateTime event) {
      //                   if (events[
      //                           DateTime(event.year, event.month, event.day)] ==
      //                       null)
      //                     return [];
      //                   else
      //                     return events[
      //                         DateTime(event.year, event.month, event.day)];
      //                 },
      //                 startingDayOfWeek: StartingDayOfWeek.monday,
      //                 calendarStyle: CalendarStyle(
      //                     markersMaxCount: 1,
      //                     markersAnchor: 1,
      //                     markerSize: 42,
      //                     isTodayHighlighted: true,
      //                     markerSizeScale: 8,
      //
      //                     //  rowDecoration:  BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),color: Colors.red.shade700.withOpacity(.0)),
      //
      //                     outsideDecoration: BoxDecoration(
      //                       borderRadius: BorderRadius.all(
      //                         Radius.circular(8),
      //                       ),
      //                       color: Colors.grey.shade100.withOpacity(.8),
      //                     ),
      //                     weekendDecoration: BoxDecoration(
      //                       borderRadius: BorderRadius.all(
      //                         Radius.circular(8),
      //                       ),
      //                       color: Colors.grey.shade300,
      //                     ),
      //                     todayDecoration: BoxDecoration(
      //                         borderRadius:
      //                             BorderRadius.all(Radius.circular(8)),
      //                         color: Colors.blue.shade700.withOpacity(.0)),
      //                     disabledDecoration: BoxDecoration(
      //                       color: Colors.grey.shade100.withOpacity(.6),
      //                       borderRadius: BorderRadius.all(Radius.circular(8)),
      //                     ),
      //                     markerDecoration: BoxDecoration(
      //                       color: Colors.blue.shade900.withOpacity(.4),
      //                       borderRadius: BorderRadius.all(Radius.circular(8)),
      //                     ),
      //                     todayTextStyle: TextStyle(
      //                         color: Colors.black,
      //                         fontWeight: FontWeight.w500,
      //                         fontSize: 16),
      //                     defaultDecoration: BoxDecoration(
      //                       borderRadius: BorderRadius.all(
      //                         Radius.circular(8),
      //                       ),
      //                       color: Colors.grey.shade300,
      //                     )),
      //                 onFormatChanged: (format) {
      //                   if (_calendarFormat != format) {
      //                     setState(() {
      //                       _calendarFormat = format;
      //                     });
      //                   }
      //                 },
      //               ),
      //             ),
      //             constants.getDivider(),
      //             getDetail(),
      //             SizedBox(
      //               height: 18,
      //             ),
      //              getChallenges()
      //           ],
      //         ),
      //       ),
    );
  }
}
