import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/helper/mediaHelper.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/pages/main/setting_page/sound_settings_page.dart';
import 'package:full_workout/pages/workout_page/check_list.dart';
import 'package:full_workout/pages/workout_page/pause_page.dart';
import 'package:full_workout/pages/workout_page/workout_page.dart';
import 'package:full_workout/components/info_button.dart';
import 'package:full_workout/pages/services/youtube_player.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../main.dart';
import 'exercise_detail_page.dart';

class RestScreen extends StatefulWidget {
  final int exerciseNumber;
  final int totalNumberOfExercise;
  final List<Workout> workOutList;
  final List<int> rapList;
  final String currTime;
  final String title;
  final String tag;
  final int tagValue;
  final int restTime;

  RestScreen(
      {@required this.exerciseNumber,
      @required this.totalNumberOfExercise,
      @required this.workOutList,
      @required this.rapList,
      @required this.currTime,
      @required this.title,
      @required this.tag,
      @required this.tagValue,
      @required this.restTime});

  @override
  _RestScreenState createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> with TickerProviderStateMixin {
  /// variables

  AnimationController controller;
  MediaHelper mediaHelper =MediaHelper();
  bool coachVoice;
  bool soundEffect;
  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();

  int index;
  Workout item;

  int get secValue {
    Duration duration = controller.duration * controller.value;
    return duration.inSeconds;
  }

  int get timerValue {
    Duration duration = controller.duration * controller.value;
    return duration.inMilliseconds;
  }

  /// Functions

  _introMessage(Workout workout) async {
    String rapType = workout.showTimer == true ? "seconds" : "";
    String exerciseName = workout.title;
    String totalRap = widget.rapList[widget.exerciseNumber + 1].toString();


    mediaHelper
        .playSoundOnce("assets/sound/achievement.wav")
        .then((value) => Future.delayed(Duration(seconds: 1)).then((value) =>
            mediaHelper.speak(
                "Take a rest the next $totalRap $rapType $exerciseName")));
  }

  _onPause() async {
    String value = "";
    if (controller.isAnimating) {
      controller.stop(canceled: true);
    }
    value =
        await showDialog(context: context, builder: (builder) => StopPage());
    if (value == "resume") {
      controller.reverse(
          from: controller.value == 0.0 ? 1.0 : controller.value);
    }
    if (value == "restart") {
      Navigator.of(context).pop();
    }
    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
    print(value);
  }

  _onComplete() async{
    await mediaHelper.flutterTts.stop();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => WorkoutPage(
                tagValue: widget.tagValue,
                tag: widget.tag,
                currTime: widget.currTime,
                rapList: widget.rapList,
                workOutList: widget.workOutList,
                title: widget.title,
                restTime: widget.restTime,
                index: index)));
  }

  String formatedTime(int secTime) {
    String getParsedTime(String time) {
      if (time.length <= 1) return "0$time";
      return time;
    }

    int min = secTime ~/ 60;
    int sec = secTime % 60;

    String parsedTime =
        getParsedTime(min.toString()) + " : " + getParsedTime(sec.toString());

    return parsedTime;
  }

  /// Initstate and dispose methods

  @override
  void initState() {
    index = widget.exerciseNumber + 1;
    item = widget.workOutList[index];
    _introMessage(item);
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.restTime+1),
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

  getProgressBar(double width, int currIndex,bool isDark) {
    return LinearPercentIndicator(
      padding: EdgeInsets.all(0),
      animation: true,
      lineHeight: 5.0,
      percent: index / widget.workOutList.length,
      width: width,
      backgroundColor:isDark?Colors.grey.shade800: Colors.grey.shade200,
      linearStrokeCap: LinearStrokeCap.round,
      progressColor: Colors.blue.shade700,
    );
  }
@override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var safePadding = MediaQuery.of(context).padding.top;
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    height = height - safePadding;
    return WillPopScope(
      onWillPop: ()=>_onPause(),
      child: Scaffold(
        backgroundColor:isDark? Colors.black:Colors.blue.shade700,

        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: height * .75,
                    width: width,
                    color:isDark? Colors.black:Colors.blue.shade700,
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
                                //playLocalAsset();

                                if (timerValue <= 5000 && timerValue > 4950) {
                                  // flutterTts.speak('Ready to go');
                                }
                                if (timerValue <= 3000 && timerValue > 2950) {
                                  mediaHelper.playSoundOnce(
                                      'assets/sound/countdown.wav');
                                  mediaHelper.speak('Three');
                                }
                                if (timerValue <= 2000 && timerValue > 1950) {
                                  mediaHelper.speak('Two');
                                }
                                if (timerValue <= 1000 && timerValue > 950) {
                                  mediaHelper.speak('One');
                                }
                                if (timerValue <= 200 && timerValue > 150) {
                                  //playLocalAsset();
                                }

                                return Text(
                                  formatedTime(secValue),
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
                            OutlinedButton(
                              onPressed: () {
                                _onPause();
                              },
                              child: Text(
                                "Pause",
                                style: textTheme.button.copyWith(
                                    fontSize: 16,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white70),
                              ),
                              style: OutlinedButton.styleFrom(
                                elevation: 1,
                                backgroundColor:isDark?Colors.black: Colors.blue.shade700,
                                side: BorderSide(
                                    style: BorderStyle.solid,
                                    color: isDark?Colors.white60:Colors.white70,
                                    width: 2),
                                padding: EdgeInsets.only(
                                    left: 35, right: 35, top: 10, bottom: 10),
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
                            onPress: () async {

                              controller.stop(canceled: true);
                              await
                              showDialog(
                                  context: context,
                                  builder: (builder) => CheckListScreen(
                                      workOutList: widget.workOutList,
                                      tag: widget.tag,
                                     progress: index / widget.workOutList.length,
                                      title: widget.title));
                              controller.reverse(
                                  from: controller.value == 0.0
                                      ? 1.0
                                      : controller.value);
                            },
                          ),
                          InfoButton(
                            icon: Icons.ondemand_video_outlined,
                            tooltip: "Video",
                            onPress: () async {
                              print(controller.status);
                              if (controller.isAnimating) {
                                controller.stop(canceled: true);
                                await showDialog(
                                    context: context,
                                    builder: (builder) => YoutubeTutorial(
                                      rapCount: widget.rapList[index],
                                        workout: widget.workOutList[index],
                                        ));
                              }

                              controller.reverse(
                                  from: controller.value == 0.0
                                      ? 1.0
                                      : controller.value);
                            },
                          ),
                          InfoButton(
                            icon: Icons.volume_up_outlined,
                            tooltip: "Sound",
                            onPress: () async {
                              print(controller.status);

                              if (controller.isAnimating) {
                                controller.stop(canceled: true);
                                await showDialog(
                                    context: context,
                                    builder: (builder) => SoundSetting());
                              }

                              controller.reverse(
                                  from: controller.value == 0.0
                                      ? 1.0
                                      : controller.value);
                            },
                          ),
                          InfoButton(
                            icon: FontAwesome5.question_circle,
                            tooltip: "Steps",
                            onPress: () async {
                              print(controller.status);

                              if (controller.isAnimating) {
                                controller.stop(canceled: true);
                                 await showDialog(
                                    context: context,
                                    builder: (builder) => DetailPage(
                                          workout: item,
                                          rapCount: widget.rapList[index],
                                        ));
                              }
                              controller.reverse(
                                  from: controller.value == 0.0
                                      ? 1.0
                                      : controller.value);
                            },
                          ),
                        ],
                      )),
                ],
              ),
              getProgressBar(width, 3,isDark),
              Container(
                height: height * .25 - 5,
                color:isDark? Colors.grey.shade800:Colors.white,
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

                           child: Image.asset(item.imageSrc)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
