import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:full_workout/database/workoutlist.dart';
import 'package:full_workout/helper/light_dark_mode.dart';
import 'package:full_workout/helper/text_to_speech.dart';
import 'package:full_workout/pages/training_page/sound_option.dart';
import 'package:full_workout/pages/training_page/workout_screen.dart';
import 'package:full_workout/widgets/timer.dart';
import 'package:full_workout/widgets/youtube_player.dart';

class InstructionScreen extends StatefulWidget {
  final List<WorkoutList> workOutList;
  final int rap;
  final String title;
  final int stars;

  InstructionScreen({
    @required this.workOutList,
    @required this.rap,
    @required this.title,
    @required this.stars,
  });

  @override
  _InstructionScreenState createState() => _InstructionScreenState();
}

Speaker _speaker = new Speaker();

class _InstructionScreenState extends State<InstructionScreen>
    with TickerProviderStateMixin {
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

  // Future<AudioPlayer> playLocalAsset() async {
  //   AudioCache cache = new AudioCache();
  //   return await cache.play("sound/note.mp3");
  // }

  @override
  void initState() {
    print(AnimationStatus.values);
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 35),
    );

    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
    controller.addStatusListener((status) {
      print(status);
      if (status == AnimationStatus.dismissed) {
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => WorkoutScreen(
        //               title: widget.title,
        //               workOutList: widget.workOutList,
        //               rap: widget.rap,
        //               stars: widget.stars,
        //             )));
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
                onPressed: () => Navigator.of(context).pop(),
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

                    },
                  ),
                  InfoButton(
                    icon: Icons.ondemand_video_outlined,
                    tooltip: "Video",
                    onPress: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => YoutubeTutorial(
                                  link: item.videoLink,
                                  title: item.title,
                                  steps: item.steps)));
                    },
                  ),
                  InfoButton(
                    icon: Icons.volume_up_outlined,
                    tooltip: "Sound",
                    onPress: () {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return SoundOption();
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
      return Container(
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
                                        _speaker.speak('Ready to go');
                                      }
                                      if (timerValue <= 3000 &&
                                          timerValue > 2950) {
                                        _speaker.speak('Three');
                                      }
                                      if (timerValue <= 2000 &&
                                          timerValue > 1950) {
                                        _speaker.speak('Two');
                                      }
                                      if (timerValue <= 1000 &&
                                          timerValue > 950) {
                                        _speaker.speak('One');
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WorkoutScreen(
                                    title: widget.title,
                                    workOutList: widget.workOutList,
                                    rap: widget.rap,
                                    stars: widget.stars,
                                  )));
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

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            getImage(),
            getTimer(),
          ],
        ),
      ),
    );
  }
}

class InfoButton extends StatelessWidget {
  final IconData icon;
  final Function onPress;
  final String tooltip;

  InfoButton({this.icon, this.onPress, this.tooltip});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0,right: 8,bottom: 5),
      child: Container(
        height: 35,
        width: 35,
        child: FloatingActionButton(
          backgroundColor: Colors.blue.shade200,
          onPressed: onPress,
          child: Icon(icon),
          tooltip: tooltip,
        ),
      ),
    );
  }
}
