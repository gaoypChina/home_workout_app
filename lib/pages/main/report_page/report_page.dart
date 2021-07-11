import 'package:flutter/material.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/database/recent_workout_db_helper.dart';
import 'package:full_workout/database/weight_db_helper.dart';
import 'package:full_workout/helper/light_dark_mode.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/models/recent_workout.dart';
import 'package:full_workout/models/weight_model.dart';
import 'package:full_workout/pages/main/explore_page/workout_time_line.dat.dart';
import 'package:full_workout/pages/main/report_page/weight_report/detail.dart';
import 'package:full_workout/pages/main/report_page/weight_report/weight_report.dart';
import 'package:full_workout/pages/main/report_page/workout_report.dart';
import 'package:full_workout/pages/services/bmi_service/bmi_card.dart';
import 'package:full_workout/widgets/achivement.dart';
import 'package:full_workout/widgets/timeline.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

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
  DatabaseHelper workoutDb = DatabaseHelper();
  List<WeightModel> weight = [];
  List<RecentWorkout> recentWorkout = [];
  double weightValue;
  double lbsWeight;
  Map<DateTime, List<dynamic>> events = {};
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
    List items = await workoutDb.getAllWorkOut();
    items.forEach((element) {
      setState(() {
        recentWorkout.add(RecentWorkout.map(element));
      });
    });
    print("WorkoutData data = " + recentWorkout.length.toString());
  }

  // List<DataPoint<dynamic>> dateList = [];
  //
  // List<DataPoint<dynamic>> _getChatData() {
  //   for (int i = weight.length - 1; i >= 0; i--) {
  //     print(i);
  //     dateList.add(DataPoint<DateTime>(
  //         value: weight[i].weight, xAxis: DateTime.parse(weight[i].date)));
  //   }
  //   return dateList;
  // }

  Map<DateTime, List<dynamic>> _getWorkout() {
    print(recentWorkout.length);

    for (int i = 0; i < 19; i++) {
      print(i);
    }
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

  // CalendarController _calendarController;

  @override
  void initState() {
    //  _calendarController = CalendarController();
    _readWorkoutData();
    _readWeightData();
    // _getChatData();
    _getWorkout();
    _getWorkoutData();
    _loadData();

    super.initState();
  }

  @override
  void dispose() {
    //_calendarController.dispose();
    super.dispose();
  }

  _loadData() async {
    await spHelper.loadDouble(spKey.weight).then((value) {
      setState(() {
        weightValue = value;
        lbsWeight = value * 2.20462 == null ? 0 : value * 2.20462;
      });
    });
  }

  DateTime initDate = DateTime.now();
  double initWeight = 0.0;

  Widget getAchievement() {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8),
      child: Achievement(
        timeTitle: "Time",
        timeValue: 1200,
        caloriesTitle: "Calories",
        caloriesValue: 1400,
        exerciseTitle: "Exercise",
        exerciseValue: 16000,
      ),
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: new LinearGradient(
              colors: [
                Colors.blue,
                Colors.blue,
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            ),
          ]),
      //   height: MediaQuery.of(context).size.height / 5,
    );
  }

  Widget getAchievementCard() {
    getCard(String title, String subTitle, Color color) {
      return Container(
        width: 100,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                title,
                style: textTheme.bodyText1.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                subTitle,
                style: textTheme.bodyText2.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              )
            ],
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        getCard("Exercise", "1600", Colors.blue.shade400),
        getCard("Time", "129", Colors.red.shade400),
        getCard("Calories", "1300", Colors.green.shade400),
      ],
    );
  }

  getWeightDetail({String title, String value, Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            size: 12.0,
            color: color,
          ),
          SizedBox(
            width: 10,
          ),
          Text(title),
          Spacer(),
          Text(value)
        ],
      ),
    );
  }

  getDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 5,
        width: double.infinity,
        color: Colors.grey.shade300,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<ActiveDay> dateList = [];
    for (int i = 0; i < 7; i++) {
      dateList.add(ActiveDay(
          date: DateTime.now().subtract(Duration(days: i)),
          isActive: DateTime.now().subtract(Duration(days: i)).day % 4 == 0
              ? false
              : true));
    }
    dateList = dateList.reversed.toList();

    getWeeklyUpdate() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: dateList
            .map((activeDay) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                  Text(DateFormat('EEEE').format(activeDay.date)[0],style: TextStyle(fontWeight: FontWeight.w600),),
                      SizedBox(height: 10,),
                      CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor.withOpacity(.8),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 12,
                            child: CircleAvatar(
                              radius: 6,
                              backgroundColor: activeDay.isActive
                                  ? Colors.blue.shade700.withOpacity(.6)
                                  : Colors.white,
                            ),
                          ),
                          radius: 15),
                      SizedBox(height: 5,),
                      Text(activeDay.date.day.toString(),style: TextStyle(fontWeight: FontWeight.w500),),
                    ],
                  ),
                ))
            .toList(),
      );
    }

    setState(() {
      // initDate = DateTime.parse(weight[0].date) == null
      //     ? DateTime.now()
      //     : DateTime.parse(weight[0].date);
      initDate = DateTime.now();
      // initWeight = weight[0].weight == null ? 0.0 : weight[0].weight;
    });

    return Scaffold(
      appBar: AppBar(
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
          SizedBox(
            height: 20,
          ),
          getAchievementCard(),
          SizedBox(
            height: 20,
          ),
          //  getAchievement(),
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
                              builder: (context) =>
                                  MyCustomUI(),
                                  // TableEventsExample(
                                  // dateSet: dateSet,
                                  // events: _getWorkout(),
                                  // eventList: workoutModelList)


                              //   CalenderEvent(
                              // dateSet: dateSet,
                              //   events: _getWorkout(),
                              //   eventList: workoutModelList)
                              ));
                    },
                    child: Text(
                      "More",
                      style: textTheme.button,
                    )),
              ],
            ),
          ),
          getWeeklyUpdate(),
          // Container(
          //   padding: EdgeInsets.only(left: 10, right: 16),
          //   child: InkWell(
          //     onTap: () {},
          //     child: AbsorbPointer(
          //       child: TableCalendar(
          //         firstDay: DateTime(2000, 08, 12),
          //         lastDay: DateTime.now(),
          //         focusedDay: DateTime.now(),
          //         calendarFormat: CalendarFormat.week,
          //         eventLoader: (DateTime event) {
          //           if (events[DateTime(event.year, event.month, event.day)] ==
          //               null)
          //             return [];
          //           else
          //             return events[
          //                 DateTime(event.year, event.month, event.day)];
          //         },
          //         daysOfWeekVisible: true,
          //         headerVisible: false,
          //         shouldFillViewport: false,
          //         rowHeight: 40,
          //         startingDayOfWeek: StartingDayOfWeek.sunday,
          //         calendarStyle: CalendarStyle(
          //           markersOffset: PositionedOffset(top: 12),
          //           markerDecoration: BoxDecoration(color: Colors.amber),
          //           markerSize: 22,
          //           markersMaxCount: 1,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          getDivider(),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Detail()));
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
          Column(
            children: [
              getWeightDetail(
                  title: "Current", value: "68.0", color: Colors.blue),
              getWeightDetail(
                  title: "Heaviest", value: "68.0", color: Colors.red),
              getWeightDetail(
                  title: "Lightest", value: "68.0", color: Colors.green),
            ],
          ),
          getDivider(),
          BmiCard(),
        ],
      ),
    );
  }
}

class ActiveDay {
  DateTime date;

  bool isActive;

  ActiveDay({this.date, this.isActive});
}
