import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/pages/main/setting_page/sound_settings_page.dart';
import 'package:full_workout/pages/workout_page/pause_page.dart';
import 'package:full_workout/pages/workout_page/workout_page.dart';
import 'package:full_workout/widgets/info_button.dart';
import 'package:full_workout/widgets/timer.dart';
import 'package:full_workout/pages/services/youtube_player.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../main.dart';
import 'exercise_list_page.dart';

class InstructionScreen extends StatefulWidget {
  final List<Workout> workOutList;
  final String title;
  final List<int> rapList;
  final String tag;
  final int tagValue;

  InstructionScreen({
    @required this.workOutList,
    @required this.title,
    @required this.rapList,
    @required this.tagValue,
    @required this.tag
  });

  @override
  _InstructionScreenState createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen>
    with TickerProviderStateMixin {

  FlutterTts flutterTts = FlutterTts();
  AnimationController controller;
  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  int get timerValue {
    Duration duration = controller.duration * controller.value;
    return duration.inMilliseconds;

    //duration.inSeconds % 60;
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
              currTime: DateTime.now().toIso8601String(),
                )));

  }

  // Future<AudioPlayer> playLocalAsset() async {
  //   AudioCache cache = new AudioCache();
  //   return await cache.play("sound/note.mp3");
  // }


 Future introMessage() async {
   await
    flutterTts.speak(widget.workOutList[0].steps.toString());
  }


  @override
  void dispose() {
    controller.dispose();
   // flutterTts.stop();
    super.dispose();
  }

  @override
  void initState() {
    print(AnimationStatus.values);
    introMessage();
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 35),
    );

    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
    controller.addStatusListener((status) {
      print(status);
      if (status == AnimationStatus.dismissed) {
       // _onComplete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var item = widget.workOutList[0];
    Widget getImage() {
      return Stack(
        children: [
          Container(
            height: height / 2,
            child: Image.asset(item.imageSrc),
          ),
          Container(
            color: Colors.black.withOpacity(.1),
            height: height/2,
          ),
          Positioned(
              left: 10,
              top: 20,
              child: ElevatedButton(
                onPressed: () => showDialog(
                    context: context, builder: (context) => StopPage()),
                child: Icon(Icons.arrow_back),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue.shade200,
                  shape: CircleBorder(),
                ),
              )),
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
      );
    }

    Widget getTimer() {
      return
        Container(
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
                  .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              item.title,
              style: textTheme.bodyText2.copyWith(
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
                              builder: (BuildContext context, Widget child) {
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
                                        (BuildContext context, Widget child) {
                                      //playLocalAsset();

                                      if (timerValue <= 5000 &&
                                          timerValue > 4950) {
                                        flutterTts.speak('Ready to go');
                                      }
                                      if (timerValue <= 3000 &&
                                          timerValue > 2950) {
                                        flutterTts.speak('Three');
                                      }
                                      if (timerValue <= 2000 &&
                                          timerValue > 1950) {
                                        flutterTts.speak('Two');
                                      }
                                      if (timerValue <= 1000 &&
                                          timerValue > 950) {
                                        flutterTts.speak('One');
                                      }
                                      if (timerValue <= 200 &&
                                          timerValue > 150) {
                                        //playLocalAsset();
                                      }
                                      return Text(
                                        '${timerValue ~/ 1000}',
                                        style: textTheme.headline1.copyWith(
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
          showDialog(context: context, builder: (context) => StopPage()),
      child: Scaffold(
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


