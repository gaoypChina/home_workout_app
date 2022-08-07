import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../components/info_button.dart';
import '../../database/workout_list.dart';
import '../../helper/mediaHelper.dart';
import '../../helper/sp_helper.dart';
import '../../helper/sp_key_helper.dart';
import '../../pages/main/setting_page/sound_settings_page.dart';
import '../../pages/services/youtube_service/youtube_player.dart';
import '../../pages/workout_page/check_list.dart';
import '../../pages/workout_page/pause_page.dart';
import '../../pages/workout_page/workout_page.dart';
import '../../widgets/banner_regular_ad.dart';
import 'exercise_detail_page.dart';

class RestScreen extends StatefulWidget {
  final int exerciseNumber;
  final int totalNumberOfExercise;
  final List<Workout> workOutList;
  final List<int> rapList;
  final String currTime;
  final String title;
  final String tag;
  final int restTime;

  RestScreen(
      {required this.exerciseNumber,
      required this.totalNumberOfExercise,
      required this.workOutList,
      required this.rapList,
      required this.currTime,
      required this.title,
      required this.tag,
      required this.restTime});

  @override
  _RestScreenState createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> with TickerProviderStateMixin {
  /// variables

  late AnimationController controller;
  MediaHelper mediaHelper = MediaHelper();
  late bool coachVoice;
  late bool soundEffect;
  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();

  late int index;
  late Workout item;

  int get secValue {
    Duration duration = controller.duration! * controller.value;
    return duration.inSeconds;
  }

  int get timerValue {
    Duration duration = controller.duration! * controller.value;
    return duration.inMilliseconds;
  }

  /// Functions

  _introMessage(Workout workout) async {
    String rapType = workout.showTimer == true ? "seconds" : "";
    String exerciseName = workout.title;
    String totalRap = widget.rapList[widget.exerciseNumber + 1].toString();

    mediaHelper.playSoundOnce("assets/sound/achievement.wav").then((value) =>
        Future.delayed(Duration(seconds: 1)).then((value) => mediaHelper
            .speak("Take a rest the next $totalRap $rapType $exerciseName")));
  }

  _onPause() async {
    String value = "";
    if (controller.isAnimating) {
      controller.stop(canceled: true);
    }
    value = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (builder) => StopPage()));
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

  _onComplete() async {
    await mediaHelper.flutterTts.stop();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => WorkoutPage(
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
      duration: Duration(seconds: widget.restTime + 1),
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

  getProgressBar(double width, int currIndex, bool isDark) {
    return LinearPercentIndicator(
      padding: EdgeInsets.all(0),
      animation: true,
      lineHeight: 5.0,
      percent: index / widget.workOutList.length,
      width: width,
      backgroundColor: isDark
          ? Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.8)
          : Colors.blue.shade200,
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
    bool isDark = Theme.of(context).textTheme.bodyText1!.color == Colors.white;

    height = height - safePadding;
    return WillPopScope(
      onWillPop: () => _onPause(),
      child: Scaffold(
        backgroundColor: isDark
            ? Theme.of(context).scaffoldBackgroundColor
            : Colors.blue.shade700,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: height * .75,
                    width: width,
                    color: isDark
                        ? Theme.of(context).scaffoldBackgroundColor
                        : Colors.blue.shade700,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height * .1,
                        ),
                        Text(
                          "Rest",
                          style: TextStyle(
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
                              builder: (BuildContext context, Widget? child) {
                                if (timerValue <= 6000 && timerValue > 5950) {
                                  mediaHelper.speak('Ready to go');
                                }
                                if (timerValue <= 3000 && timerValue > 2950) {
                                  mediaHelper.speak('Three');
                                }
                                if (timerValue <= 1600 && timerValue > 1550) {
                                  mediaHelper.speak('Two');
                                }
                                if (timerValue <= 200 && timerValue > 150) {
                                  mediaHelper.speak('One');
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
                                style: TextStyle(
                                    fontSize: 16,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white70),
                              ),
                              style: OutlinedButton.styleFrom(
                                elevation: 1,
                                backgroundColor: isDark
                                    ? Theme.of(context).scaffoldBackgroundColor
                                    : Colors.blue.shade700,
                                side: BorderSide(
                                    style: BorderStyle.solid,
                                    color: isDark
                                        ? Colors.white60
                                        : Colors.white70,
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
                                style: TextStyle(
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
                  RegularBannerAd(),
                  Positioned(
                      right: 10,
                      top: 20,
                      child: Column(
                        children: [
                          InfoButton(
                            icon: FontAwesomeIcons.questionCircle,
                            tooltip: "Steps",
                            onPress: () async {
                              print(controller.status);

                              if (controller.isAnimating) {
                                controller.stop(canceled: true);
                                await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                              workout: item,
                                              rapCount: widget.rapList[index],
                                            )));
                              }
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
                                await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => YoutubeTutorial(
                                              rapCount: widget.rapList[index],
                                              workout:
                                                  widget.workOutList[index],
                                            )));
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
                                await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (builder) => SoundSetting()));
                              }

                              controller.reverse(
                                  from: controller.value == 0.0
                                      ? 1.0
                                      : controller.value);
                            },
                          ),
                          InfoButton(
                            icon: Icons.list_alt_outlined,
                            tooltip: "Exercise Plane",
                            onPress: () async {
                              controller.stop(canceled: true);
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      CheckListScreen(
                                          workOutList: widget.workOutList,
                                          tag: widget.tag,
                                          currentWorkout: index,
                                          title: widget.title),
                                ),
                              );

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
              getProgressBar(width, 3, isDark),
              Container(
                height: height * .25 - 5,
                color: Theme.of(context).cardColor,
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
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                              Text(
                                item.title,
                                style: TextStyle(
                                    fontSize: item.title.length > 15 ? 20 : 28,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                item.showTimer == true
                                    ? "${widget.rapList[index]} sec"
                                    : "X ${widget.rapList[index]}",
                                style: TextStyle(
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
                            tag: widget.title,
                            child: Image.asset(item.imageSrc))),
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
