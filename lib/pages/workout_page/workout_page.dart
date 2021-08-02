import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/helper/mediaHelper.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/pages/workout_page/exercise_detail_page.dart';
import 'package:full_workout/pages/workout_page/report_page.dart';
import 'package:full_workout/pages/main/setting_page/sound_settings_page.dart';
import 'package:full_workout/pages/workout_page/pause_page.dart';
import 'package:full_workout/pages/workout_page/rest_page.dart';
import 'package:full_workout/components/info_button.dart';
import 'package:full_workout/pages/services/youtube_player.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../main.dart';
import 'check_list.dart';
import 'exercise_list_page.dart';

class WorkoutPage extends StatefulWidget {
  final List<Workout> workOutList;
  final String title;
  final int index;
  final List<int> rapList;
  final String currTime;
  final int tagValue;
  final String tag;
  final int restTime;
  final int countDownTime;
  WorkoutPage({
    @required this.workOutList,
    @required this.title,
    @required this.index,
    @required this.rapList,
    @required this.currTime,
    @required this.tagValue,
    @required this.tag,
    @required this.restTime,
    @required this.countDownTime
  });

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage>
    with SingleTickerProviderStateMixin {
  int currIndex = 0;
  SpKey spKey = SpKey();
  SpHelper spHelper = SpHelper();
  MediaHelper mediaHelper = MediaHelper();
  int screenTime = 30;
  AnimationController controller;
  DateTime currentTime;

  FlutterTts flutterTts;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inSeconds} ';
  }

  int get timerValue {
    Duration duration = controller.duration * controller.value;
    return duration.inMilliseconds;
  }

  Workout item;

  introMessage() async {
    String audioPath = 'assets/sound/whistle-sound.mp3';
    var workout = widget.workOutList[currIndex];
    String rapType = workout.showTimer == true ? "Seconds " : "";
    String exerciseName = workout.title;
    String totalRap = widget.rapList[currIndex].toString();
    String message = "Start $totalRap $rapType $exerciseName";
    mediaHelper.playSoundOnce(audioPath).then((value) => Future.delayed(
            Duration(seconds: 1))
        .then((value) => mediaHelper.speak(message))
        .then((value) => Future.delayed(Duration(seconds: 2))
            .then((value) => mediaHelper.speak(workout.steps[0]))
            .then((value) => Future.delayed(Duration(seconds: 4)).then((value) {
                  if (workout.steps.length >= 2)
                    mediaHelper.speak(workout.steps[1]);
                }))));
  }

  _onComplete(int currIndex) async {
    if (currIndex + 1 == widget.workOutList.length) {
      return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ReportScreen(
                    tag: widget.tag,
                    tagValue: widget.tagValue,
                    title: widget.title,
                    dateTime: widget.currTime,
                    totalExercise: widget.workOutList.length,
                  )));
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return RestScreen(
        tagValue:widget.tagValue,
        tag: widget.tag,
        currTime: widget.currTime,
        workOutList: widget.workOutList,
        exerciseNumber: currIndex,
        totalNumberOfExercise: widget.workOutList.length,
        rapList: widget.rapList,
        title: widget.title,
        countDownTime: widget.countDownTime,
        restTime:  widget.restTime,
      );
    }));
  }

  _showTimer() {
    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _onComplete(currIndex);
      }
    });
  }

  @override
  void initState() {
    item = widget.workOutList[widget.index];
    currIndex = widget.index;
    flutterTts = FlutterTts();
    currentTime = DateTime.now();
    if (currIndex != widget.workOutList.length) {
      introMessage();
    }
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: screenTime),
    );

    if (item.showTimer == true) {
      _showTimer();
    }

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    mediaHelper.dispose();
    super.dispose();
  }

  Widget getImage(double height, Workout item, int currIndex) {
    return Stack(
      children: [
        Container(height: height / 2, child: Image.asset(item.imageSrc)),
        Container(
          color: Colors.black.withOpacity(.1),
          height: height / 2,
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
                    if (controller.isAnimating) {
                      controller.stop(canceled: true);
                    }
                    await showDialog(
                        context: context,
                        builder: (builder) => CheckListScreen(
                          progress: (currIndex + 1) / widget.workOutList.length,
                            workOutList: widget.workOutList,
                            tag: widget.tag,
                            title: widget.title));

                    controller.reverse(
                        from: controller.value == 0.0 ? 1.0 : controller.value);
                  },
                ),
                InfoButton(
                  icon: Icons.ondemand_video_outlined,
                  tooltip: "Video",
                  onPress: () async {
                    if (controller.isAnimating) {
                      controller.stop(canceled: true);
                    }
                    await showDialog(
                        context: context,
                        builder: (builder) => YoutubeTutorial(
                          workout: item,
                          rapCount: widget.rapList[currIndex],));

                    controller.reverse(
                        from: controller.value == 0.0 ? 1.0 : controller.value);
                  },
                ),
                InfoButton(
                  icon: Icons.volume_up_outlined,
                  tooltip: "Sound",
                  onPress: () async {
                    if (controller.isAnimating) {
                      controller.stop(canceled: true);
                    }

                    await showDialog(
                        context: context, builder: (builder) => SoundSetting());

                    controller.reverse(
                        from: controller.value == 0.0 ? 1.0 : controller.value);
                  },
                ),
                InfoButton(
                  icon: FontAwesome5.question_circle,
                  tooltip: "Steps",
                  onPress: () async {
                    if (controller.isAnimating) {
                      controller.stop(canceled: true);
                    }
                    await showDialog(
                        context: context,
                        builder: (builder) => DetailPage(
                              workout: item,
                              rapCount: widget.rapList[currIndex],
                            ));
                    controller.reverse(
                        from: controller.value == 0.0 ? 1.0 : controller.value);
                  },
                ),
              ],
            )),
      ],
    );
  }

  getProgressBar(double width, int currIndex) {
    return LinearPercentIndicator(
      padding: EdgeInsets.all(0),
      animation: true,
      lineHeight: 5.0,
      percent: (currIndex + 1) / widget.workOutList.length,
      width: width,
      backgroundColor: Colors.white70,
      linearStrokeCap: LinearStrokeCap.round,
      progressColor: Colors.blue.shade700,
    );
  }

  getTitleCard(Workout item, int currIndex) {
    return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "${currIndex + 1} of ${widget.workOutList.length}",
                  style:
                  textTheme.caption.copyWith(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: textTheme.headline1.copyWith(
                      fontSize: item.title.length > 15 ? 25 : 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Colors.black87),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: item.showTimer == true
                  ? Container(
                height: 50,
                //  width: double.infinity,
                child: AnimatedBuilder(
                    animation: controller,
                    builder: (BuildContext context, Widget child) {
                        if (timerValue <= 15000 && timerValue > 14950) {}
                        if (timerValue <= 3000 && timerValue > 2950) {
                          mediaHelper
                              .playSoundOnce("assets/sound/countdown.wav");
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

                        String parsedTime = timerString.length == 1
                            ? "0" + timerString
                            : timerString;
                        return Text(
                          "00:" + parsedTime,
                          style: TextStyle(fontSize: 40),
                          //    style: themeData.textTheme.display4,
                        );
                      }),
              )
                  : Text(
                "X ${widget.rapList[currIndex]}",
                style: TextStyle(fontSize: 44, fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _onComplete(currIndex);
              },
              child: Text(
                "Done",
            style: textTheme.button.copyWith(
                fontSize: 20,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
            padding: EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () async {

                    if (controller.isAnimating) {
                      controller.stop(canceled: true);
                    }
             await showDialog(
                        context: context, builder: (builder) => StopPage());

                    controller.reverse(
                        from: controller.value == 0.0 ? 1.0 : controller.value);
                  },
                      child: Row(
                        children: [
                          Icon(
                            Icons.pause,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Pause",
                            style: textTheme.button.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.grey),
                          ),
                        ],
                      )),
                  Container(
                    height: 20,
                    color: Colors.grey,
                    width: 2.5,
                  ),
                  TextButton(
                      onPressed: () {
                        _onComplete(currIndex);
                      },
                      child: Row(
                        children: [
                          Text("Skip",
                              style: textTheme.button.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Colors.grey)),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.skip_next_rounded,
                            color: Colors.grey,
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            getImage(height, item, currIndex),
            getProgressBar(width, currIndex),
            getTitleCard(item, currIndex)
          ],
        ),
      ),
    );
  }
}
