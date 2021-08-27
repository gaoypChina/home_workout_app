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
import 'package:full_workout/pages/services/youtube_service/youtube_player.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../main.dart';
import 'check_list.dart';

class WorkoutPage extends StatefulWidget {
  final List<Workout> workOutList;
  final String title;
  final int index;
  final List<int> rapList;
  final String currTime;
  final int tagValue;
  final String tag;
  final int restTime;
  WorkoutPage({
    @required this.workOutList,
    @required this.title,
    @required this.index,
    @required this.rapList,
    @required this.currTime,
    @required this.tagValue,
    @required this.tag,
    @required this.restTime,
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
    return '${duration.inSeconds}';
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
           ));
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
      duration: Duration(seconds: item.showTimer?item.duration+1:30+1),
    );

    if (item.showTimer == true) {
      _showTimer();
    }

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget getImage(double height, Workout item, int currIndex) {
    return Stack(
      children: [
        Container(height: height / 2, child: Padding(
          padding: const EdgeInsets.only(top: 18.0,left: 18,right: 18),
          child: Image.asset(item.imageSrc),
        ),color: Colors.white,),

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
                              progress:
                                  (currIndex + 1) / widget.workOutList.length,
                              workOutList: widget.workOutList,
                              tag: widget.tag,
                              title: widget.title)),
                    );

                    controller.reverse(
                        from: controller.value == 0.0 ? 1.0 : controller.value);
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
                                workout: item,
                                rapCount: widget.rapList[currIndex],
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
                        from: controller.value == 0.0 ? 1.0 : controller.value);
                  },
                ),
                InfoButton(
                  icon: FontAwesome5.question_circle,
                  tooltip: "Steps",
                  onPress: () async {
                    print(controller.status);

                    if (controller.isAnimating) {
                      controller.stop(canceled: true);
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailPage(
                                workout: item,
                                rapCount: widget.rapList[currIndex],
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

  getProgressBar(double width, int currIndex,bool isDark) {
    return LinearPercentIndicator(
      padding: EdgeInsets.all(0),
      animation: true,
      lineHeight: 5.0,
      percent: (currIndex + 1) / widget.workOutList.length,
      width: width,
      backgroundColor:isDark?Colors.grey.shade800: Colors.blue.shade50,
      linearStrokeCap: LinearStrokeCap.round,
      progressColor: Colors.blue.shade700,
    );
  }


  getTitleCard(Workout item, int currIndex,bool isDark) {
    return Expanded(
      child: Container(
          color:isDark? Colors.black:Colors.white,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Flexible(
                        child: Text(
                          item.title,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.headline1.copyWith(
                              fontSize: item.title.length > 15 ? 25 : 30,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              ),
                        ),
                      ),
                    ],
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
                        // if (timerValue <= 4000 && timerValue > 3950){
                        //   mediaHelper
                        //       .playSoundOnce("assets/sound/countdown.wav");
                        // }

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
                  style: TextStyle(fontSize: 44, fontWeight: FontWeight.w500),
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
                        onPressed:()=> _onPopBack(),
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
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return WillPopScope(
      onWillPop: ()=>_onPopBack(),
      child: Scaffold(
        backgroundColor:isDark?Colors.black: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              getImage(height, item, currIndex),
              getProgressBar(width, currIndex,isDark),
              getTitleCard(item, currIndex,isDark)
            ],
          ),
        ),
      ),
    );
  }
}
