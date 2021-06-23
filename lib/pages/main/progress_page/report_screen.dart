import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/database/recent_workout_db_helper.dart';
import 'package:full_workout/database/weight_db_helper.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/models/BMIModel.dart';
import 'package:full_workout/models/recent_workout.dart';
import 'package:full_workout/models/weight_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:full_workout/pages/main/progress_page/report_calender.dart';
import 'package:full_workout/widgets/achivement.dart';
import 'package:full_workout/widgets/bmi_result.dart';

import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ReportScreen extends StatefulWidget {
  static const routeName = "report-screen";

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  var weightDb = WeightDatabaseHelper();
  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();
  DatabaseHelper workoutDb = DatabaseHelper();
  List<WeightModel> weight = [];
  List<RecentWorkout> recentWorkout = [];
  double weightValue;
  double lbsWeight;
  Map<DateTime, List<dynamic>> events = {};
  List<List<RecentWorkout>> workoutModelList =[];
  Set<String> dateSet = {};



  _readWeightData() async {
    print("\n value                          \n");
    print(weight.length);
    List items = await weightDb.getAllWeight();
    items.forEach((element) {
      setState(() {
        weight.add(WeightModel.map(element));
      });
    });
    print("Weight data = " +weight.length.toString());
  }

  _readWorkoutData() async {
    List items = await workoutDb.getAllWorkOut();
    items.forEach((element) {
      setState(() {
        recentWorkout.add(RecentWorkout.map(element));
      });
    });
    print("WorkoutData data = " +recentWorkout.length.toString());

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

    for(int i=0; i<19; i++){
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
      currDateWorkout=[];
      workoutTitle = [];
      RecentWorkout model ;
      for (int j = 0; j < recentWorkout.length; j++) {
        DateTime date = DateTime.parse(recentWorkout[j].date);
        String formatedDay = DateFormat.yMMMd().format(date);
        dateSet.add(formatedDay);

        print("${dateSet.elementAt(i)}    and     $formatedDay\n");
        if (dateSet.elementAt(i) == formatedDay) {
          model  = RecentWorkout(
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
      events.addAll({DateTime.parse(model.date):workoutTitle});
      workoutModelList.add(currDateWorkout);
    }
    print(events);
    print("/n------------------------------------------------------------/n");
    print(workoutModelList);

    return events;
  }

  Map<DateTime, List<dynamic>> _getWorkoutData() {
    print("akakkakakkkkkkkkkkkkkkkkkkakakka");

    int n = recentWorkout.length - 1;
    int i = 0;
    int j = 1;
    List<dynamic> title = [];
    for (i = 0; i < n; i++) {
      print("akakkakakkkkkkkkkkkkkkkkkkakakka");

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

  @override
  Widget build(BuildContext context) {
    setState(() {
      initDate = DateTime.parse(weight[0].date) == null
          ? DateTime.now()
          : DateTime.parse(weight[0].date);
      initWeight = weight[0].weight == null ? 0.0 : weight[0].weight;
    });

    var size = MediaQuery.of(context).size;
   double height = size.height;
 //  double width = size.width;

    var bmiModel = BMIModel(bmi: 20, isNormal: true, comments: "tottly file");

    return Scaffold(
      appBar: AppBar(
        title: Text("Report Card"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SvgPicture.asset(
                  'assets/background-vector/undraw_fitness_stats_sht6.svg',
                  alignment: Alignment.center,
                  //         color: Colors.blue,
                  fit: BoxFit.scaleDown,
                  width: MediaQuery.of(context).size.width * .1,
                  height: MediaQuery.of(context).size.height * .45,
                ),
                Positioned(
                  top: 100,
                  width: double.infinity,
                  child: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Achievement(
                        exerciseValue: 82,
                        exerciseTitle: 'Exercise',
                        caloriesValue: 802,
                        caloriesTitle: 'Calories',
                        timeValue: 782,
                        timeTitle: 'Minutes',
                      ),
                    ),
                    height: height * .25,
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.blue,
              height: height * .36,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Weekly Update",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        RaisedButton(
                          elevation: 10,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CalenderEvent(
                                      dateSet: dateSet,
                                        events: _getWorkout(),
                                        eventList: workoutModelList)));
                          },
                          child: Text("More"),
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     print('touch detected');
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(
                  //         top: 0.0, left: 8.0, right: 8.0),
                  //     child: TableCalendar(
                  //       calendarFormat: CalendarFormat.month,
                  //
                  //
                  //       focusedDay: DateTime.now(),
                  //       availableGestures: AvailableGestures.all,
                  //       calendarBuilders: CalendarBuilders(
                  //         dowBuilder: (context, day) {
                  //           if (day.weekday == DateTime.sunday) {
                  //             final text = DateFormat.E().format(day);
                  //             return Center(
                  //               child: Text(
                  //                 text,
                  //                 style: TextStyle(color: Colors.red),
                  //               ),
                  //             );
                  //           }return Container();
                  //         },
                  //       ),
                  //       availableCalendarFormats: {CalendarFormat.week: 'Week'},
                  //       lastDay: DateTime.now(),
                  //       firstDay: DateTime.now().subtract(Duration(days: 700)),
                  //       // calendarController: _calendarController,
                  //       // initialCalendarFormat: CalendarFormat.week,
                  //       startingDayOfWeek: StartingDayOfWeek.monday,
                  //       //    formatAnimation: FormatAnimation.slide,
                  //      // events:  _getWorkout(),
                  //
                  //
                  //       daysOfWeekStyle: DaysOfWeekStyle(
                  //           weekendStyle: TextStyle(color: Colors.white),
                  //           weekdayStyle: TextStyle(color: Colors.white)),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              color: Colors.purple,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Weekly Update",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    RaisedButton(
                      elevation: 10,
                      onPressed: () {},
                      child: Text("More"),
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            // Container(
            //   child: ChartWidget(
            //     initWeight: initWeight,
            //     fromDate: initDate,
            //     dateList: dateList,
            //     weight: weight,
            //   ),
            // ),
            Container(
              child: ResultScreen(
                bmiModel: bmiModel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
