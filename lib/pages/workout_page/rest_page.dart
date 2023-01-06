import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../components/info_button.dart';
import '../../constants/app_theme.dart';
import '../../database/workout_list.dart';

import '../../helper/mediaHelper.dart';
import '../../helper/sp_helper.dart';
import '../../helper/sp_key_helper.dart';
import '../../pages/services/youtube_service/youtube_player.dart';
import '../../pages/workout_page/check_list.dart';
import '../../pages/workout_page/pause_page.dart';
import '../../pages/workout_page/workout_page.dart';
import '../../provider/subscription_provider.dart';
import '../../widgets/banner_regular_ad.dart';
import '../main/setting_page/sound_settings_page.dart';
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

  const RestScreen(
      {super.key, required this.exerciseNumber,
        required this.totalNumberOfExercise,
        required this.workOutList,
        required this.rapList,
        required this.currTime,
        required this.title,
        required this.tag,
        required this.restTime});

  @override
  RestScreenState createState() => RestScreenState();
}

class RestScreenState extends State<RestScreen> with TickerProviderStateMixin {
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
            .readText("Take a rest the next $totalRap $rapType $exerciseName")));
  }

  _onPause() async {

    if (controller.isAnimating) {
      controller.stop(canceled: true);
    }
    String?   value = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (builder) => StopPage()));
    if (value == null || value == "resume") {
      controller.reverse(
          from: controller.value == 0.0 ? 1.0 : controller.value);
    }
    if (value == "restart") {
      Navigator.of(context).pop();
    }
    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
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
        "${getParsedTime(min.toString())} : ${getParsedTime(sec.toString())}";

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
          : Colors.grey.withOpacity(.8),
      progressColor: Theme.of(context).primaryColor,
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
            : Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: height * .78,
                  width: width,
                  color: isDark
                      ? Theme.of(context).scaffoldBackgroundColor
                      : darkAppBarColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(
                        flex: 2,
                      ),
                      Text(
                        "Rest",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      SizedBox(
                        height: 50,
                        //  width: double.infinity,
                        child: AnimatedBuilder(
                            animation: controller,
                            builder: (BuildContext context, Widget? child) {
                              if (timerValue <= 6000 && timerValue > 5950) {
                                mediaHelper.readText('Ready to go');
                              }
                              if (timerValue <= 3000 && timerValue > 2950) {
                                mediaHelper.readText('Three');
                              }
                              if (timerValue <= 1600 && timerValue > 1550) {
                                mediaHelper.readText('Two');
                              }
                              if (timerValue <= 200 && timerValue > 150) {
                                mediaHelper.readText('One');
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
                        height: height * .02,
                      ),
                      OutlinedButton(
                          style: TextButton.styleFrom(
                            side: BorderSide(
                                style: BorderStyle.solid,
                                color: isDark ? Colors.white70 : Colors.white,
                                width: 1),
                            backgroundColor: Colors.transparent,
                            padding: EdgeInsets.only(
                                left: 25, right: 25, top: 10, bottom: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            controller.duration =
                                Duration(seconds: secValue + 20);
                            controller.reverse(from: 20);
                            setState(() {});
                          },
                          child: Text(
                            "20 + sec",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                      Spacer(
                        flex: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  _onPause();
                                },
                                style: OutlinedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: isDark
                                      ? Theme.of(context)
                                      .scaffoldBackgroundColor
                                      : Colors.transparent,
                                  side: BorderSide(
                                      style: BorderStyle.solid,
                                      color: isDark
                                          ? Colors.white70
                                          : Colors.white,
                                      width: 1),
                                  padding: EdgeInsets.only(
                                      left: 35, right: 35, top: 10, bottom: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  "Pause",
                                  style: TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Spacer(
                            flex: 2,
                          ),
                          ElevatedButton(
                            onPressed: () => _onComplete(),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.only(
                                  left: 40, right: 40, top: 10, bottom: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              "Skip",
                              style: TextStyle(
                                  fontSize: 16,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      Spacer(),
                      RegularBannerAd(),
                      Provider.of<SubscriptionProvider>(context, listen: false)
                          .isProUser
                          ? Spacer()
                          : SizedBox(height: 10)
                    ],
                  ),
                ),
                Positioned(
                    right: 6,
                    top: 50,
                    child: Column(
                      children: [
                        InfoButton(
                          bgColor: Colors.grey.shade800,
                          fgColor: Colors.white,
                          icon: FontAwesomeIcons.circleQuestion,
                          tooltip: "Steps",
                          onPress: () async {
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
                          bgColor: Colors.grey.shade800,
                          fgColor: Colors.white,
                          icon: Icons.ondemand_video_outlined,
                          tooltip: "Video",
                          onPress: () async {
                            if (controller.isAnimating) {
                              controller.stop(canceled: true);
                              await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                  builder: (context) => YoutubeTutorial(
                                    workout: widget.workOutList[index],
                                  )));
                            }

                            controller.reverse(
                                from: controller.value == 0.0
                                    ? 1.0
                                    : controller.value);
                          },
                        ),
                        InfoButton(
                          bgColor: Colors.grey.shade800,
                          fgColor: Colors.white,
                          icon: Icons.volume_up_outlined,
                          tooltip: "Sound",
                          onPress: () async {
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
                          bgColor: Colors.grey.shade800,
                          fgColor: Colors.white,
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
            Expanded(
              child: Container(
                color: Theme.of(context).cardColor,
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text(
                                "Next $index / ${widget.workOutList.length}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color!
                                        .withOpacity(.7)),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                item.title,
                                style: TextStyle(
                                    fontSize: item.title.length > 15 ? 20 : 28,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                item.showTimer == true
                                    ? "${widget.rapList[index]} sec"
                                    : "X ${widget.rapList[index]}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color!
                                        .withOpacity(.7)),
                              ),
                              SizedBox(
                                height: height * .01,
                              )
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Image.asset(item.imageSrc,
                          height: height*.2,fit: BoxFit.scaleDown,)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
