import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/helper/recent_workout_db_helper.dart';
import 'package:full_workout/pages/main/report_page/workout_report/workout_detail_report.dart';
import 'package:full_workout/pages/services/bmi_service/bmi_card.dart';
import 'package:full_workout/pages/main/report_page/workout_report/weekly_workout_report.dart';
import 'package:path_provider/path_provider.dart' as pp;

import 'package:flutter_svg/svg.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/models/recent_workout.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:wakelock/wakelock.dart';

import '../../main.dart';

class ReportScreen extends StatefulWidget {
  final String title;
  final String dateTime;
  final int totalExercise;
  final String tag;
  final int tagValue;

  ReportScreen(
      {@required this.title,
      @required this.dateTime,
    @required this.totalExercise,
      @required this.tag,
      @required this.tagValue});

  @override
  _MyAppState createState() => _MyAppState();
}

SpHelper spHelper = SpHelper();
SpKey spKey = SpKey();
RecentDatabaseHelper dbHelper = RecentDatabaseHelper();
bool isLoading = false;
Constants constants = Constants();
final _screenshotController = ScreenshotController();

class _MyAppState extends State<ReportScreen> {
  ConfettiController _controllerTopCenter;

  saveWorkoutData() async {
    try {
      DateTime startTime = DateTime.parse(widget.dateTime);

      int activeTime = DateTime.now().difference(startTime).inSeconds;
      RecentWorkout recentWorkout = RecentWorkout(
        widget.dateTime,
        widget.title,
        activeTime,
        3, //unused value
        activeTime * (18 / 60),
        widget.totalExercise,
      );
      if (widget.tag == spKey.fullBodyChallenge ||
          widget.tag == spKey.absChallenge ||
          widget.tag == spKey.armChallenge ||
          widget.tag == spKey.chestChallenge) {
        print(widget.tag.toString() + " : tag");
        print(widget.tagValue.toString() + " : tagValue");
        int currVal = await spHelper.loadInt(widget.tag);
        spHelper.saveInt(widget.tag, currVal + 1);
      } else {
        spHelper.saveString(widget.tag, widget.dateTime);
      }

      int savedActiveTime = await spHelper.loadInt(spKey.time) == null
          ? 0
          : await spHelper.loadInt(spKey.time);
      int totalActiveTime = savedActiveTime + activeTime;

      int savedExercise = await spHelper.loadInt(spKey.exercise) == null
          ? 0
          : await spHelper.loadInt(spKey.exercise);
      int totalExercise = savedExercise + widget.totalExercise;

      spHelper.saveInt(spKey.time, totalActiveTime);
      spHelper.saveInt(spKey.exercise, totalExercise);

      int a = await dbHelper.saveWorkOut(recentWorkout);
    } catch (error) {
      print(error);
    }
  }


  void _takeScreenshot() async {
    setState(() {
      isLoading = true;
    });
    final screenShort = await _screenshotController.capture();
    final dir = await pp.getExternalStorageDirectory();
    String currDate = DateTime.now().toString();
    final myImagePath = dir.path + "/$currDate.png";
    File imageFile = File(myImagePath);
    if (!await imageFile.exists()) {
      imageFile.create(recursive: true);
    }
    imageFile.writeAsBytes(screenShort);
    Share.shareFiles([myImagePath], subject: "subject", text: "Text");
    setState(() {
      isLoading = false;
    });
  }

  setAwakeScreen()async{
    bool isAwake = await spHelper.loadBool(spKey.awakeScreen) ?? false;
    isAwake ? Wakelock.enable() : Wakelock.disable();
  }

  @override
  void initState() {
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 5));
    _controllerTopCenter.play();
    saveWorkoutData();
    setAwakeScreen();
    super.initState();
  }

  @override
  void dispose() {
    _controllerTopCenter.dispose();

    super.dispose();
  }

  /// Widgets

  getTitle(double height, double width) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: Colors.white,
          height: height +30,
          width: width,
          child: Center(
            child: SvgPicture.asset(
              'assets/other/well_done.svg',
              alignment: Alignment.center,

              width: width -50,
            ),
          ),
        ),
        Container(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              SlideFadeTransition(
                curve: Curves.elasticOut,
                delayStart: Duration(milliseconds: 500),
                animationDuration: Duration(milliseconds: 1200),
                offset: 2.5,
                direction: Direction.horizontal,
                child: Text(
                  "Congratulations !",
                  style: textTheme.bodyText1.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 30),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SlideFadeTransition(
                  curve: Curves.elasticOut,
                  delayStart: Duration(milliseconds: 1000),
                  animationDuration: Duration(milliseconds: 1200),
                  offset: 2.5,
                  direction: Direction.vertical,
                  child: Text(
                    "You did it!",
                    style: textTheme.bodyText2
                        .copyWith(color: Colors.black, fontSize: 22),
                  )),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
        ),
        Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              width: width,
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Do Again")),
                  Spacer(),
                  isLoading
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            backgroundColor: constants.widgetColor,
                            color: Colors.white,
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            _takeScreenshot();
                          },
                          child: Text(
                            "Share",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: constants.widgetColor),
                        ),
                  SizedBox(
                    width: 5,
                  ),
                  Spacer(),
                  TextButton(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          WorkoutDetailReport.routeName,
                          ModalRoute.withName('/')),
                      child: Text("Next")),
                ],
              ),
            )),
      ],
    );
  }

  Widget getPastWeek() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
          child: Text("Past Week", style: constants.titleStyle),
        ),
        WeeklyWorkoutReport(),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  Widget getAchievementCard() {
    getCard(String title, String subTitle, Color color) {
      return Container(
        height: MediaQuery.of(context).size.height * .12,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Container(
            width: MediaQuery.of(context).size.width / 3.5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    subTitle,
                    style: textTheme.bodyText2.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    style: textTheme.bodyText1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),

                ],
              ),
            ),
          ),
        ),
      );
    }

    int timeInSec =DateTime.now().difference( DateTime.parse(widget.dateTime)).inSeconds;
    int exercise = widget.totalExercise;
    int time = DateTime.now().difference( DateTime.parse(widget.dateTime)).inMinutes;
    int calories = (timeInSec * (18/60)).toInt();

    return Container(
      padding: EdgeInsets.only(top: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          getCard("Exercise", exercise.toString(), Colors.green.shade500),
          getCard("Time", (time % 60).toString().padLeft(2, '0'),
              Colors.red.shade400),
          getCard(
              "Calories", calories.toInt().toString(), Colors.orange.shade400),
        ],
      ),
    );
  }

  getRatingBar(double height) {
    TextStyle bodyStyle = textTheme.bodyText2.copyWith(
        fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black);
    return Container(
      color:Colors.white,
      height: height * .2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text("How it feel?", style: constants.titleStyle),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Easy",
                style: bodyStyle,
              ),
              Text(
                "Perfect",
                style: bodyStyle,
              ),
              Text(
                "Hard",
                style: bodyStyle,
              )
            ],
          ),
          Center(
            child:
            RatingBar.builder(
              unratedColor: Colors.blue.shade100,
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 17.0),
              itemBuilder: (context, _) => CircleAvatar(
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue.shade700,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              itemSize: 35,
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ),
        ],
      ),
    );
  }

  getButton() {
    return Container(
      height: 55,
      margin: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.blue.shade700,
            side: BorderSide(
                color: Colors.blue.shade700, style: BorderStyle.solid, width: 0),
          ),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, WorkoutDetailReport.routeName, ModalRoute.withName('/'));
          },
          child: Text(
            "Continue",
            style: Theme.of(context).textTheme.button.merge(TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500)),
          )),
    );
  }

  Widget getConfetti() {
    Widget confetti = ConfettiWidget(
      confettiController: _controllerTopCenter,
      blastDirection: -pi / 2,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        confetti,
        confetti,
        confetti,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double safeHeight = AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Screenshot(
        controller: _screenshotController,
        child: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                getTitle(height * .5 - safeHeight, width),
                Divider(),
                getAchievementCard(),
                getPastWeek(),
                constants.getDivider(),
                BmiCard(
                  showBool: false,
                ),
                constants.getDivider(),
                getRatingBar(height),
                getButton(),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
            getConfetti(),
          ],
        ),
      ),
    );
  }
}

enum Direction { vertical, horizontal }

class SlideFadeTransition extends StatefulWidget {
  final Widget child;

  final double offset;

  final Curve curve;

  final Direction direction;

  final Duration delayStart;

  final Duration animationDuration;

  SlideFadeTransition({
    @required this.child,
    this.offset = 1.0,
    this.curve = Curves.easeIn,
    this.direction = Direction.vertical,
    this.delayStart = const Duration(seconds: 0),
    this.animationDuration = const Duration(milliseconds: 800),
  });

  @override
  _SlideFadeTransitionState createState() => _SlideFadeTransitionState();
}

class _SlideFadeTransitionState extends State<SlideFadeTransition>
    with SingleTickerProviderStateMixin {
  Animation<Offset> _animationSlide;

  AnimationController _animationController;

  Animation<double> _animationFade;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    if (widget.direction == Direction.vertical) {
      _animationSlide =
          Tween<Offset>(begin: Offset(0, widget.offset), end: Offset(0, 0))
              .animate(CurvedAnimation(
        curve: widget.curve,
        parent: _animationController,
      ));
    } else {
      _animationSlide =
          Tween<Offset>(begin: Offset(widget.offset, 0), end: Offset(0, 0))
              .animate(CurvedAnimation(
        curve: widget.curve,
        parent: _animationController,
      ));
    }

    _animationFade =
        Tween<double>(begin: -1.0, end: 1.0).animate(CurvedAnimation(
      curve: widget.curve,
      parent: _animationController,
    ));

    Timer(widget.delayStart, () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationFade,
      child: SlideTransition(
        position: _animationSlide,
        child: widget.child,
      ),
    );
  }
}
