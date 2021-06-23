import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/helper/light_dark_mode.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/pages/workout_page/exercise_detail_page.dart';
import 'package:full_workout/pages/workout_page/report_page.dart';
import 'package:full_workout/pages/main/setting_page/sound_settings_page.dart';
import 'package:full_workout/pages/workout_page/pause_page.dart';
import 'package:full_workout/pages/workout_page/rest_page.dart';
import 'package:full_workout/widgets/info_button.dart';
import 'package:full_workout/widgets/youtube_player.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'exercise_list_page.dart';

class WorkoutPage extends StatefulWidget {
  final List<Workout> workOutList;
  final String title;
  final int index;
  final List<int> rapList;
  final String currTime;

  WorkoutPage({
    @required this.workOutList,
    @required this.title,
    @required this.index,
    @required this.rapList,
    @required this.currTime,
  });

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage>
    with SingleTickerProviderStateMixin {
  int currIndex = 0;
  SpKey spKey = SpKey();
  int screenTime = 30;
  AnimationController controller;
  DateTime currentTime;

  FlutterTts flutterTts;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inSeconds}';
  }

  Workout item;

  _speakIntroMessage(int index) async {
    String rapType =
        widget.workOutList[index].showTimer == true ? "seconds" : "";
    String exerciseName = widget.workOutList[index].title;
    String totalRap = 12.toString();
    print("Start $totalRap $rapType $exerciseName ");
    await flutterTts.speak("Start $totalRap $rapType $exerciseName ");
  }

  _onComplete(int currIndex) async {
    await flutterTts
        .speak('next ${30} second ${widget.workOutList[currIndex].title}');
    print("currentIndex :  $currIndex");
    if (currIndex + 1 == widget.workOutList.length) {
      return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ReportScreen(
                    title: widget.title,
                    dateTime: widget.currTime,
                    totalExercise: widget.workOutList.length,
                  )));
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return RestScreen(
        currTime: widget.currTime,
        workOutList: widget.workOutList,
        exerciseNumber: currIndex,
        totalNumberOfExercise: widget.workOutList.length,
        rapList: widget.rapList,
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

  getTime() async {
    await spHelper.loadDouble(spKey.trainingRest).then((value) {
      setState(() {
        print("........................." + value.toString());
        screenTime = (value != null) ? value as int : 30;
      });
    });
  }

  @override
  void initState() {
    item = widget.workOutList[widget.index];
    currIndex = widget.index;
    flutterTts = FlutterTts();
    _speakIntroMessage(currIndex);
    currentTime = DateTime.now();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: screenTime),
    );
    super.initState();
    if (item.showTimer == true) {
      _showTimer();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget getImage(double height, Workout item, int currIndex) {
    return Stack(
      children: [
        Container(
          height: height / 2,
          child: Image.asset(item.imageSrc),
        ),
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
                    print(controller.status);
                    bool value = true;
                    if (controller.isAnimating) {
                      controller.stop(canceled: true);
                      value = await showDialog(
                          context: context,
                          builder: (builder) => ExerciseListScreen(
                              workOutList: widget.workOutList,
                              tag: "continue",
                              stars: 2,
                              title: "title"));
                    }
                    if (value == true) {
                      controller.reverse(
                          from:
                              controller.value == 0.0 ? 1.0 : controller.value);
                    }
                  },
                ),
                InfoButton(
                  icon: Icons.ondemand_video_outlined,
                  tooltip: "Video",
                  onPress: () async {
                    print(controller.status);
                    bool value = true;
                    if (controller.isAnimating) {
                      controller.stop(canceled: true);
                      value = await showDialog(
                          context: context,
                          builder: (builder) => YoutubeTutorial(
                              link: item.videoLink,
                              title: item.title,
                              steps: item.steps));
                    }
                    if (value == true) {
                      controller.reverse(
                          from:
                              controller.value == 0.0 ? 1.0 : controller.value);
                    }
                  },
                ),
                InfoButton(
                  icon: Icons.volume_up_outlined,
                  tooltip: "Sound",
                  onPress: () async {
                    print(controller.status);
                    bool value = true;
                    if (controller.isAnimating) {
                      controller.stop(canceled: true);
                      value = await showDialog(
                          context: context,
                          builder: (builder) => SoundSetting());
                    }
                    if (value == true) {
                      controller.reverse(
                          from:
                              controller.value == 0.0 ? 1.0 : controller.value);
                    }
                  },
                ),
                InfoButton(
                  icon: FontAwesome5.question_circle,
                  tooltip: "Steps",
                  onPress: () async {
                    print(controller.status);
                    bool value = true;
                    if (controller.isAnimating) {
                      controller.stop(canceled: true);
                      value = await showDialog(
                          context: context,
                          builder: (builder) => DetailPage(
                                workout: item,
                                rapCount: widget.rapList[currIndex],
                              ));
                    }
                    if (value == true) {
                      controller.reverse(
                          from:
                              controller.value == 0.0 ? 1.0 : controller.value);
                    }
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
      backgroundColor: Colors.white,
      linearStrokeCap: LinearStrokeCap.round,
      progressColor: Colors.blue,
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
                        String timerValue = timerString.length == 1
                            ? "0" + timerString
                            : timerString;
                        return Text(
                          "00:" + timerValue,
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
                fontSize: 22,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
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
                    print(controller.status);
                    String value = "";
                    if (controller.isAnimating) {
                      controller.stop(canceled: true);
                      value = await showDialog(
                          context: context, builder: (builder) => StopPage());
                    }
                    if (value == "resume") {
                      controller.reverse(
                          from:
                              controller.value == 0.0 ? 1.0 : controller.value);
                    }
                    if (value == "restart") {
                      setState(() {
                        if (currIndex != 0) currIndex--;
                      });
                    }
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
