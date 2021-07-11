import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/helper/light_dark_mode.dart';
import 'package:full_workout/pages/main/setting_page/sound_settings_page.dart';
import 'package:full_workout/pages/workout_page/pause_page.dart';
import 'package:full_workout/pages/workout_page/workout_page.dart';
import 'package:full_workout/widgets/info_button.dart';
import 'package:full_workout/pages/services/youtube_player.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'exercise_list_page.dart';

class RestScreen extends StatefulWidget {
  final int exerciseNumber;
  final int totalNumberOfExercise;
  final List<Workout> workOutList;
  final List<int> rapList;
  final String currTime;
  final String title;
  final String tag;
  final int tagValue;

  RestScreen({
    @required this.exerciseNumber,
    @required this.totalNumberOfExercise,
    @required this.workOutList,
    @required this.rapList,
    @required this.currTime,
    @required this.title,
    @required this.tag,
    @required this.tagValue
  });

  @override
  _RestScreenState createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> with TickerProviderStateMixin {
  /// variables
  int screenTime = 55;
  int addTime = 20;
  AnimationController controller;
  FlutterTts _flutterTts;

  int index;
  Workout item;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inSeconds}';
  }

  /// Functions

  _introMessage(Workout workout) async {
    String rapType = workout.showTimer == true ? "seconds" : "";
    String exerciseName = workout.title;
    String totalRap = 12.toString();
    await _flutterTts.setSpeechRate(0.75);
    await _flutterTts.setPitch(.8);
    await _flutterTts
        .speak("Take a rest the next $totalRap $rapType $exerciseName");
  }

  _onPause() async {
    print(controller.status);
    bool value = true;
    if (controller.isAnimating) {
      controller.stop(canceled: true);
      value =
          await showDialog(context: context, builder: (builder) => StopPage());
    }
    if (value == true) {
      controller.reverse(
          from: controller.value == 0.0 ? 1.0 : controller.value);
    }
  }

  _onComplete() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => WorkoutPage(
                tagValue:widget.tagValue,
              tag: widget.tag,
              currTime: widget.currTime,
                rapList: widget.rapList,
                workOutList: widget.workOutList,
                title: widget.title,
                index: index)));
  }

  /// Initstate and dispose methods

  @override
  void initState() {
    _flutterTts = FlutterTts();
    index = widget.exerciseNumber + 1;
    item = widget.workOutList[index];
    _introMessage(item);
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: screenTime),
    );

    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
    super.initState();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _onComplete();
      }
    });
    super.initState();
  }

  /// widget functions

  getProgressBar(double width, int currIndex) {
    return LinearPercentIndicator(
      padding: EdgeInsets.all(0),
      animation: true,
      lineHeight: 5.0,
      percent: index / widget.workOutList.length,
      width: width,
      backgroundColor: Colors.white,
      linearStrokeCap: LinearStrokeCap.round,
      progressColor: Colors.amberAccent,
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var safePadding = MediaQuery.of(context).padding.top;
    height = height - safePadding;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: height * .75,
                  width: width,
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * .1,
                      ),
                      Text(
                        "Rest",
                        style: textTheme.bodyText1.copyWith(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: height * .05,
                      ),
                      Container(
                        height: 50,
                        //  width: double.infinity,
                        child: AnimatedBuilder(
                            animation: controller,
                            builder: (BuildContext context, Widget child) {
                              String timerValue = timerString.length == 1
                                  ? "0" + timerString
                                  : timerString;
                              return Text(
                                "00:" + timerValue,
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white),
                                //    style: themeData.textTheme.display4,
                              );
                            }),
                      ),
                      SizedBox(
                        height: height * .05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _onPause();
                            },
                            child: Text(
                              "Pause",
                              style: textTheme.button.copyWith(
                                  fontSize: 16,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue.shade700,
                              padding: EdgeInsets.only(
                                  left: 40, right: 40, top: 10, bottom: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => _onComplete(),
                            child: Text(
                              "Skip",
                              style: textTheme.button.copyWith(
                                  fontSize: 16,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.only(
                                  left: 40, right: 40, top: 10, bottom: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                    right: 10,
                    top: 20,
                    child: Column(
                      children: [
                        InfoButton(
                          icon: Icons.list_alt_outlined,
                          tooltip: "Exercise Plane",
                          onPress: () {
                            showDialog(
                                context: context,
                                builder: (builder) {
                                  return ExerciseListScreen(
                                      workOutList: widget.workOutList,
                                      tag: "continue",
                                      tagValue: widget.tagValue,
                                      title: "title");
                                });
                          },
                        ),
                        InfoButton(
                          icon: Icons.ondemand_video_outlined,
                          tooltip: "Video",
                          onPress: () {
                            showDialog(
                                context: context,
                                builder: (builder) {
                                  return YoutubeTutorial(
                                      link: item.videoLink,
                                      title: item.title,
                                      steps: item.steps);
                                });
                          },
                        ),
                        InfoButton(
                          icon: Icons.volume_up_outlined,
                          tooltip: "Sound",
                          onPress: () {
                            showDialog(
                                context: context,
                                builder: (builder) {
                                  return SoundSetting();
                                });
                          },
                        ),
                        InfoButton(
                          icon: FontAwesome5.question_circle,
                          tooltip: "Steps",
                          onPress: () {},
                        ),
                      ],
                    )),
              ],
            ),
            getProgressBar(width, 3),
            Container(
              height: height * .25 - 5,
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: height * .04,
                            ),
                            Text(
                              "Next $index / ${widget.workOutList.length}",
                              style: textTheme.bodyText2.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey),
                            ),
                            Text(
                              item.title,
                              style: textTheme.bodyText2.copyWith(
                                  fontSize: item.title.length > 15 ? 20 : 28,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              item.showTimer == true
                                  ? "${widget.rapList[index]} sec"
                                  : "X ${widget.rapList[index]}",
                              style: textTheme.bodyText2.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              height: height * .01,
                            )
                          ],
                        ),
                      )),
                  Expanded(
                      child: Hero(
                          tag: "workout", child: Image.asset(item.imageSrc))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
