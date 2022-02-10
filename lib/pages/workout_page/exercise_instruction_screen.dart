import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/helper/mediaHelper.dart';
import 'package:full_workout/pages/main/setting_page/sound_settings_page.dart';
import 'package:full_workout/pages/workout_page/check_list.dart';
import 'package:full_workout/pages/workout_page/pause_page.dart';
import 'package:full_workout/pages/workout_page/workout_page.dart';
import 'package:full_workout/components/info_button.dart';
import 'package:full_workout/components/timer_painter.dart';
import 'package:full_workout/pages/services/youtube_service/youtube_player.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:wakelock/wakelock.dart';

import '../../main.dart';
import 'exercise_detail_page.dart';

class InstructionScreen extends StatefulWidget {

  final List<Workout> workOutList;
  final String title;
  final List<int> rapList;
  final String tag;
  final int tagValue;
  final int countDownTime;
  final int restTime;

  InstructionScreen({
    required this.workOutList,
    required this.title,
    required this.rapList,
    required this.tagValue,
    required this.tag,
    required this.countDownTime,
    required this.restTime
  });

  @override
  _InstructionScreenState createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen>
    with TickerProviderStateMixin {


  MediaHelper mediaHelper = MediaHelper();
 late AnimationController controller;

  String get timerString {
    Duration duration = controller.duration! * controller.value;
    return '${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  int get timerValue {
    Duration duration = controller.duration! * controller.value;
    return duration.inMilliseconds;
  }

  _onComplete() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => WorkoutPage(
              tagValue: widget.tagValue,
              tag: widget.tag,
              rapList: widget.rapList,
                  title: widget.title,
                  workOutList: widget.workOutList,
                  index: 0,
              restTime: widget.restTime,
              currTime: DateTime.now().toIso8601String(),
                )));
  }

  _onPopBack() async {
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



 Future introMessage() async {
   var workout = widget.workOutList[0];
    String intro = "Ready to go! ";
    String isSec = workout.showTimer ? "Seconds " : "";
    String message = "The next ${workout.duration} " + isSec + workout.title;
    print(message);
    await mediaHelper.speak(intro).then((value) =>
        Future.delayed(Duration(seconds: 1))
            .then((value) => mediaHelper.speak(message)));
  }

  awakeScreen(){
    Wakelock.enable();
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    introMessage();
    awakeScreen();
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.countDownTime),
    );

    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
    controller.addStatusListener((status) {
      print(status);
      if (status == AnimationStatus.dismissed) {
        _onComplete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    var item = widget.workOutList[0];
    Widget getImage() {
      return Stack(
        children: [
          Container(
            height: height / 2,
            color: Colors.white,
            child: Image.asset(item.imageSrc),
          ),
          Positioned(
              left: 2,
              top: 20,
              child: ElevatedButton(
                onPressed: () => _onPopBack(),
                child: Icon(Icons.arrow_back),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: CircleBorder(),
                ),
              )),
          Positioned(
              right: 2,
              top: 20,
              child: Column(
                children: [
                  InfoButton(
                    icon: Icons.list_alt_outlined,
                    tooltip: "Exercise Plane",
                    onPress: () async {
                      controller.stop(canceled: true);
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => CheckListScreen(
                                workOutList: widget.workOutList,
                                tag: "continue",
                                progress: 0 / widget.workOutList.length,

                                //  progress: 0,
                                title: widget.title)),
                      );

                      controller.reverse(
                          from:
                              controller.value == 0.0 ? 1.0 : controller.value);
                    },
                  ),
                  InfoButton(
                    icon: Icons.ondemand_video_outlined,
                    tooltip: "Video",
                    onPress: () async {
                      print(controller.status);
                      if (controller.isAnimating) {
                        controller.stop(canceled: true);
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => YoutubeTutorial(
                                  rapCount: widget.rapList[0],
                                  workout: widget.workOutList[0],
                                )));
                      }

                      controller.reverse(
                          from: controller.value == 0.0 ? 1.0 : controller.value);
                    },
                  ),
                  InfoButton(
                    icon: Icons.volume_up_outlined,
                    tooltip: "Sound",
                    onPress: () async {
                      print(controller.status);

                      if (controller.isAnimating) {
                        controller.stop(canceled: true);
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => SoundSetting()));
                      }

                      controller.reverse(
                          from:
                              controller.value == 0.0 ? 1.0 : controller.value);
                    },
                  ),
                  InfoButton(
                    icon: FontAwesomeIcons.questionCircle,
                    tooltip: "Steps",
                    onPress: () async {
                      print(controller.status);

                      if (controller.isAnimating) {
                        controller.stop(canceled: true);
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailPage(
                                  workout: item,
                                  rapCount: widget.rapList[0],
                                )));
                      }
                      controller.reverse(
                          from: controller.value == 0.0 ? 1.0 : controller.value);
                    },
                  ),
                ],
              )),
        ],
      );
    }

    Widget getTimer() {
      return
        Container(
          color: isDark ? Colors.black : Colors.white,
        height: height * .45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "Ready to go!",
              style: textTheme.bodyText1
                  !.copyWith(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              item.title,
              style: textTheme.bodyText2!.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width / 3.1,
                  ),
                  Container(
                    height: height / 6,
                    width: height / 6,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: AnimatedBuilder(
                              animation: controller,
                              builder: (BuildContext context, Widget? child) {
                                return CustomPaint(
                                    painter: TimerPainter(
                                  animation: controller,
                                  backgroundColor: Colors.blue,
                                  color: Colors.blue.shade100,
                                ));
                              },
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                AnimatedBuilder(
                                    animation: controller,
                                    builder:
                                        (BuildContext context, Widget? child) {


                                      if (timerValue <= 3000 &&
                                          timerValue > 2950) {
                                        mediaHelper.speak('Three');
                                      }
                                      if (timerValue <= 1600 &&
                                          timerValue > 1550) {
                                        mediaHelper.speak('Two');
                                      }
                                      if (timerValue <= 200 &&
                                          timerValue > 150) {
                                        mediaHelper.speak('One');
                                      }

                                      return Text(
                                        '${timerValue ~/ 1000}',
                                        style: textTheme.headline1!.copyWith(
                                            fontSize: 40,
                                            fontWeight: FontWeight.w700),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      _onComplete();
                    },
                    child: Text('Skip'),
                    style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async =>
          _onPopBack(),
      child: Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              getImage(),
              getTimer(),
            ],
          ),
        ),
      ),
    );
  }
}




