import 'package:flutter/material.dart';
import 'package:full_workout/helper/recent_workout_db_helper.dart';
import 'package:full_workout/models/recent_workout.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class WorkoutDetailReport extends StatefulWidget {
  static const routeName = "workout-detail-report";

  final Map<DateTime, List> events;
  final List<List<RecentWorkout>> eventList;
  final Set<String> dateSet;

  WorkoutDetailReport({this.events, this.eventList, this.dateSet});

  @override
  _WorkoutDetailReportState createState() => _WorkoutDetailReportState();
}

class _WorkoutDetailReportState extends State<WorkoutDetailReport> {
  DatabaseHelper workoutDb = DatabaseHelper();
  List<RecentWorkout> recentWorkout = [];
  double weightValue;
  double lbsWeight;
  Map<DateTime, List<dynamic>> events = {};
  List<List<RecentWorkout>> workoutModelList = [];
  Set<String> dateSet = {};

  _readWorkoutData() async {
    List items = await workoutDb.getAllWorkOut();
    items.forEach((element) {
      setState(() {
        recentWorkout.add(RecentWorkout.map(element));
      });
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


  @override
  void initState() {
    print("this is working now");
    _readWorkoutData();
    _getWorkout();
    _getWorkoutData();
    super.initState();
  }



  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.disabled;
  DateTime _focusedDay = DateTime.now();

  getEvent() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: workoutModelList.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          List<RecentWorkout> events = workoutModelList[index];
          return Container(
            child: ListTile(
                title: Text(events[0].date),
                subtitle: ListView.builder(
                    shrinkWrap: true,
                    itemCount: events.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, idx) {
                      return Container(
                        child: Text(events[idx].workoutTitle),
                      );
                    })

                ),
          );
        });

  }

  TextStyle detailStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Report'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: TableCalendar(
                firstDay: DateTime(2019,01,01),
                lastDay: DateTime.now(),
                focusedDay: _focusedDay,
                sixWeekMonthsEnforced: true,
                calendarFormat: _calendarFormat,
                rangeSelectionMode: _rangeSelectionMode,
                availableGestures: AvailableGestures.horizontalSwipe,

                eventLoader: (DateTime event) {
                  if (widget
                      .events[DateTime(event.year, event.month, event.day)] ==
                      null)
                    return [];
                  else
                    return widget
                        .events[DateTime(event.year, event.month, event.day)];
                },
                //      eventLoader: _getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                  canMarkersOverflow: true,
                  isTodayHighlighted: false,
                  markersOffset: PositionedOffset(top: 160, bottom: 190, end: 1),
                  markerDecoration: BoxDecoration(
                    color: Colors.black38,
                    shape: BoxShape.circle,
                  ),
                  markerSize: 40,
                  markersMaxCount: 1,
                ),

                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },

              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.eventList.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  List<RecentWorkout> events = widget.eventList[index];
                  return Container(
                    child: ListTile(
                        title: Text(events[0].date),
                        subtitle: ListView.builder(
                            shrinkWrap: true,
                            itemCount: events.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, idx) {
                              return Container(
                                child: Text(events[idx].workoutTitle),
                              );
                            })
                        // Column(
                        //     children: events.map((event) {
                        //       return Container(
                        //         height: 200,
                        //           child: Text(event.workoutTitle));
                        //     }).toList()
                        //
                        // )
                        ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
