
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/database/workoutlist.dart';
import 'package:full_workout/pages/training_page/workout_screen.dart';
import 'package:full_workout/widgets/timer.dart';

class TimerScreen extends StatefulWidget {
  final int exerciseNumber;
  final int totalNumberOfExercise;
  final List<WorkoutList> workOutList;

  TimerScreen({
    @required this.exerciseNumber,
    @required this.totalNumberOfExercise,
    this.workOutList,
  });

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with TickerProviderStateMixin {
  int screenTime = 55;
  int addTime = 20;
  AnimationController controller;

  int get timerString {
    Duration duration = controller.duration * controller.value;
    return duration.inSeconds;
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: screenTime),
    );

    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
    super.initState();


    controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        Navigator.pop(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * .81,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REST',
                          style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              letterSpacing: 10),
                        ),
                        FlatButton(
                          child: Icon(Icons.info_outline), onPressed: () {},),

                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                          color: Colors.white,
                          height: height * .15,
                          width: width * 0.45,
                          child: Hero(
                              tag: "workout",
                              child: Image.asset(widget
                                  .workOutList[widget.exerciseNumber]
                                  .imageSrc))),
                      Container(
                        height: height * .15,
                        width: width * 0.55,
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Text(
                                "next exercise : ${widget
                                    .exerciseNumber}/${widget.workOutList
                                    .length}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red),
                              ),
                              Text(widget
                                  .workOutList[widget.exerciseNumber].title),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            Container(
              color: Theme
                  .of(context)
                  .primaryColor,
              height: height * .15,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    BottomButtons(
                      icon: controller.isAnimating
                          ? Icons.pause
                          : Icons.play_arrow,
                      function: () {
                        print(controller.status);
                        setState(() {
                          Icon(controller.isAnimating
                              ? Icons.pause
                              : Icons.play_arrow);
                        });
                        if (controller.isAnimating) {
                          controller.stop(canceled: true);
                        } else {
                          controller.reverse(
                              from: controller.value == 0.0
                                  ? 1.0
                                  : controller.value);
                        }
                      },
                    ),
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
                                        backgroundColor: Colors.white,
                                        color: Colors.blue,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Align(
                                alignment: FractionalOffset.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    AnimatedBuilder(
                                        animation: controller,
                                        builder: (BuildContext context,
                                            Widget child) {
                                          return Text(
                                            timerString.toString(),
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
                    BottomButtons(
                      icon: Icons.navigate_next,
                      function: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
