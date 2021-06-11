import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:full_workout/database/recent_workout_db_helper.dart';
import 'package:full_workout/database/workoutlist.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/helper/text_to_speech.dart';
import 'package:full_workout/models/recent_workout.dart';
import 'package:full_workout/pages/training_page/report_screen.dart';
import 'package:full_workout/pages/training_page/timer_screen.dart';
import 'package:full_workout/widgets/timer.dart';
import '../../constants/constants.dart';



class WorkoutScreen extends StatefulWidget {
  final List<WorkoutList> workOutList;
  final int rap;
  final String title;
  final int stars;

  WorkoutScreen({
    @required this.workOutList,
    @required this.rap,
    @required this.title,
    @required this.stars,
  });

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen>
    with TickerProviderStateMixin {
  SpKey spKey = SpKey();


  int screenTime =5;
  AnimationController controller;
  DateTime currentTime;

  Speaker _speaker = Speaker();

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inSeconds}';
  }

  int i;





  @override
  void initState() {
  print("...............................$screenTime");
    getTime();
  print("...............................$screenTime");

  currentTime = DateTime.now();
    i = 0;
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: screenTime),
    );

    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
    super.initState();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {

        _speaker.speak('next ${30} second ${widget.workOutList[i].title}');
        print(widget.workOutList.length);
        print(screenTime.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TimerScreen(
                      workOutList: widget.workOutList,
                      exerciseNumber: i,
                      totalNumberOfExercise: widget.workOutList.length,
                    )));
        i++;
      }
    });
  }

  getTime() async{
    await spHelper.loadDouble(spKey.trainingRest).then((value) {
      setState(() {
        print("........................."+value.toString());
        screenTime =  (value !=null)?
        value as int:30;
      });
    });
  }

  DatabaseHelper dbHelper = DatabaseHelper();
  SpHelper spHelper = SpHelper();

  @override
  Widget build(BuildContext context) {
    bool isStop =false;
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  if (i < widget.workOutList.length)
                    Container(
                      height: 15,
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.workOutList.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)),
                                  child: Container(
                                    height: 15,
                                    width:
                                        size.width / widget.workOutList.length,
                                    color: (i - 1 < index)
                                        ? Colors.white.withOpacity(.5)
                                        : Colors.green,
                                  ),
                                )
                              ],
                            );
                          }),
                    ),
                  SizedBox(
                    height: 15,
                  ),
                  if (i < widget.workOutList.length)
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      child: Container(
                        color: Colors.white,
                        height: size.height * 0.5,
                        width: size.width * 0.95,
                        child: Stack(
                          fit: StackFit.expand,
                          textDirection: TextDirection.ltr,
                          children: [

                            Container(
                              height: 300,
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Hero(
                                  tag: "workout",
                                  child: Image.asset(
                                    widget.workOutList[i].imageSrc,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: size.height * .05,
                              left: size.width * .36,
                              child: Text(
                                "${i + 1} of ${widget.workOutList.length}",
                                style:
                                    TextStyle(fontSize: 30, color: Constants.kTextColor),
                              ),
                            ),
                            // Positioned(
                            //   left: size.width * .25,
                            //   top: 25,
                            //   child: Text(widget.workOutList[i].title,
                            //       style: TextStyle(
                            //           fontSize: 40, color: kTextColor)),
                            // ),
                   if(isStop) Container(
                              color: Colors.transparent.withOpacity(.1),
                              height: 300,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              if (i <= widget.workOutList.length - 1)
                Container(
                  child: Column(
                    children: [
                      Text(
                        widget.workOutList[i].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      ),
                      // if (widget.workOutList[i].showTimer == false)
                      Text(
                        widget.rap.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
              if (i <= widget.workOutList.length - 1)
                if (widget.workOutList[i].showTimer == true)
                  Container(
                    height: 100,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          height: 100,
                          width: 100,
                          child: Align(
                            alignment: FractionalOffset.bottomLeft,
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                    child: AnimatedBuilder(
                                      animation: controller,
                                      builder:
                                          (BuildContext context, Widget child) {
                                        return CustomPaint(
                                            painter: TimerPainter(
                                          animation: controller,
                                          backgroundColor: Constants.kActiveIconColor,
                                          color: Constants.kTextColor,
                                        ));
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: FractionalOffset.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        AnimatedBuilder(
                                            animation: controller,
                                            builder: (BuildContext context,
                                                Widget child) {
                                              return Text(
                                                timerString,
                                                style: TextStyle(fontSize: 40),
                                                //    style: themeData.textTheme.display4,
                                              );
                                            }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              BottomButtons(
                function: () {
                  print(i);
                  setState(() {
                    if (i != 0) i--;
                  });
                  if (i == 0) return;
                  print(i);
                },
                icon: Icons.navigate_before,
              ),
              // DoneButton

              //PlayPause
              BottomButtons(
                icon: controller.isAnimating ? Icons.pause : Icons.play_arrow,
                function: () {
                  setState(() {
                    isStop = true;
                    Icon(controller.isAnimating
                        ? Icons.pause
                        : Icons.play_arrow);
                  });
                  if (controller.isAnimating) {
                    controller.stop(canceled: true);
                  } else {
                    controller.reverse(
                        from: controller.value == 0.0 ? 1.0 : controller.value);
                  }
                },
              ),

              RawMaterialButton(
                onPressed: () async {
                  if (i < widget.workOutList.length - 1) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TimerScreen(
                                  totalNumberOfExercise:
                                      widget.workOutList.length,
                                  exerciseNumber: i,
                                  workOutList: widget.workOutList,
                                )));
                    //    setState(() {
                    i++;
                    if (i == widget.workOutList.length) {
                      i = 0;
                    }
                    // });
                  } else {
                    DateTime timeAfterWorkOut = DateTime.now();
                    int totalTime =
                        timeAfterWorkOut.difference(currentTime).inSeconds;
                    RecentWorkout recentWorkout = RecentWorkout(
                      timeAfterWorkOut.toIso8601String(),
                      widget.title,
                      totalTime,
                      widget.stars,
                      12.0,
                        widget.workOutList.length,
                    );
                  int a=  await dbHelper.saveWorkOut(recentWorkout);
                  print(a);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReportScreen(
                               recentWorkout: recentWorkout,
                                )));
                  }
                },
                elevation: 5.0,
                fillColor: Colors.blue,
                child: Container(
                  height: 35,
                  width: 35,
                  child: Text(
                    'Done',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
              // NextButton
              BottomButtons(
                icon: Icons.navigate_next,
                function: () {
                  if (i < widget.workOutList.length) {
                    // controller.reverse(
                    //     from: controller.value == 0.0 ? 1.0 : controller.value);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TimerScreen(
                                  totalNumberOfExercise:
                                      widget.workOutList.length,
                                  exerciseNumber: i,
                                  workOutList: widget.workOutList,
                                )));

                    setState(() {
                      controller.forward(from: 0);
                      i++;
                      if (i == widget.workOutList.length) {
                        return;
                      }
                    });
                  }
                },
              ),
            ],
          ),
        ));
  }
}

class BottomButtons extends StatelessWidget {
  final IconData icon;
  final Function function;

  BottomButtons({this.function, this.icon});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: function,
      elevation: 5.0,
      fillColor: Colors.white,
      child: Icon(
        icon,
        size: 30.0,
        color:Constants.kTextColor,
      ),
      padding: EdgeInsets.all(15.0),
      shape: CircleBorder(),
    );
  }
}
