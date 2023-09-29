import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../database/workout_list.dart';
import '../../helper/mediaHelper.dart';
import '../../pages/workout_page/check_list.dart';
import '../../pages/workout_page/pause_page.dart';
import '../../pages/workout_page/workout_page.dart';
import '../../components/info_button.dart';
import '../../components/timer_painter.dart';
import '../../pages/services/youtube_service/youtube_player.dart';
import 'package:wakelock/wakelock.dart';
import '../main/setting_page/sound_settings_page.dart';
import 'exercise_detail_page.dart';

class InstructionScreen extends StatefulWidget {
  final List<Workout> workOutList;
  final String title;
  final List<int> rapList;
  final String tag;
  final int countDownTime;
  final int restTime;

  const InstructionScreen(
      {super.key, required this.workOutList,
        required this.title,
        required this.rapList,
        required this.tag,
        required this.countDownTime,
        required this.restTime});

  @override
  InstructionScreenState createState() => InstructionScreenState();
}

class InstructionScreenState extends State<InstructionScreen>
    with TickerProviderStateMixin {
  MediaHelper mediaHelper = MediaHelper();
  late AnimationController controller;

  String get timerString {
    Duration duration = controller.duration! * controller.value;
    return (duration.inSeconds % 60).toString().padLeft(2, '0');
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

    if (controller.isAnimating) {
      controller.stop(canceled: true);
    }
    String? value = await Navigator.of(context)
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

  Future introMessage() async {
    var workout = widget.workOutList[0];
    String intro = "Ready to go! ";
    String isSec = workout.showTimer ? "Seconds " : "";
    String message = "The next ${workout.duration} $isSec${workout.title}";
    await mediaHelper.readText(intro).then((value) =>
        Future.delayed(Duration(seconds: 1))
            .then((value) => mediaHelper.readText(message)));
  }

  awakeScreen() {
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
      if (status == AnimationStatus.dismissed) {
        _onComplete();
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
            color: Colors.white,
            child: Image.asset(item.imageSrc),
          ),
          Positioned(
              left: 2,
              top: 20,
              child: ElevatedButton(
                onPressed: () => _onPopBack(),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                ),
                child: Icon(Icons.arrow_back),
              )),
          Positioned(
              right: 2,
              top: 20,
              child: Column(
                children: [
                  InfoButton(
                    bgColor: Theme.of(context).primaryColor,
                    fgColor: Colors.white,
                    icon: Icons.list_alt_outlined,
                    tooltip: "Exercise Plane",
                    onPress: () async {
                      controller.stop(canceled: true);
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => CheckListScreen(
                                workOutList: widget.workOutList,
                                tag: "continue",
                                currentWorkout: 0,
                                title: widget.title)),
                      );

                      controller.reverse(
                          from:
                          controller.value == 0.0 ? 1.0 : controller.value);
                    },
                  ),
                  InfoButton(
                    bgColor: Theme.of(context).primaryColor,
                    fgColor: Colors.white,
                    icon: Icons.ondemand_video_outlined,
                    tooltip: "Video",
                    onPress: () async {
                      if (controller.isAnimating) {
                        controller.stop(canceled: true);
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => YoutubeTutorial(
                              workout: widget.workOutList[0],
                            )));
                      }
                      controller.reverse(
                          from:
                          controller.value == 0.0 ? 1.0 : controller.value);
                    },
                  ),
                  InfoButton(
                    bgColor: Theme.of(context).primaryColor,
                    fgColor: Colors.white,
                    icon: Icons.volume_up_outlined,
                    tooltip: "Sound",
                    onPress: () async {
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
                    bgColor: Theme.of(context).primaryColor,
                    fgColor: Colors.white,
                    icon: FontAwesomeIcons.circleQuestion,
                    tooltip: "Steps",
                    onPress: () async {
                      if (controller.isAnimating) {
                        controller.stop(canceled: true);
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailPage(
                              workout: item,
                              rapCount: widget.rapList[0],
                            )));
                      }
                      controller.reverse(
                          from:
                          controller.value == 0.0 ? 1.0 : controller.value);
                    },
                  ),
                ],
              )),
        ],
      );
    }

    Widget getTimer() {
      return SizedBox(
        height: height * .45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              //  "Ready to go!",
              widget.title,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              item.title,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.8)),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width / 3.1,
                  ),
                  SizedBox(
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
                                      backgroundColor: Theme.of(context).primaryColor,
                                      color: Colors.grey.shade200.withOpacity(.8),
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
                                        mediaHelper.readText('Three');
                                      }
                                      if (timerValue <= 1600 &&
                                          timerValue > 1550) {
                                        mediaHelper.readText('Two');
                                      }
                                      if (timerValue <= 200 &&
                                          timerValue > 150) {
                                        mediaHelper.readText('One');
                                      }

                                      return Text(
                                        '${timerValue ~/ 1000}',
                                        style: TextStyle(
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
                    style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                    child: Text('Skip'),
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
      onWillPop: () async => _onPopBack(),
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
