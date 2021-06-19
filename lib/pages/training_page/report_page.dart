import 'dart:io';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:full_workout/database/recent_workout_db_helper.dart';
import 'package:full_workout/helper/light_dark_mode.dart';
import 'package:path_provider/path_provider.dart' as pp;

import 'package:flutter_svg/svg.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/models/BMIModel.dart';
import 'package:full_workout/models/recent_workout.dart';
import 'package:full_workout/widgets/achivement.dart';
import 'package:full_workout/widgets/bmi_result.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class ReportScreen extends StatefulWidget {
  final String title;
  final String dateTime;
  final int totalExercise;

  ReportScreen(
      {@required this.title,
      @required this.dateTime,
      @required this.totalExercise});

  @override
  _MyAppState createState() => _MyAppState();
}

SpHelper spHelper = SpHelper();
SpKey spKey = SpKey();
BMIModel _bmiModel = BMIModel(comments: "hello", isNormal: false, bmi: 22);
DatabaseHelper dbHelper = DatabaseHelper();

class _MyAppState extends State<ReportScreen> {
  ConfettiController _controllerCenter;
  ConfettiController _controllerCenterRight;
  ConfettiController _controllerCenterLeft;
  ConfettiController _controllerTopCenter;
  ConfettiController _controllerBottomCenter;

  double _bmi;
  double _heightOfUser = 121;
  double _weightOfUser;

  void getBmiValue() async {
    await spHelper.loadDouble(spKey.height).then((value) {
      if (value == null) {
        _bmi = 0.0;
        return _bmi;
      } else {
        setState(() {
          _heightOfUser = value;
        });
      }
    });

    await spHelper.loadDouble(spKey.weight).then((value) {
      if (value == null) {
        _bmi = 0.0;
        return _bmi;
      } else {
        setState(() {
          _weightOfUser = value;
        });
      }
    });

    print(_heightOfUser);
    print(_weightOfUser);
    _bmi = _weightOfUser / ((_heightOfUser / 100) * (_heightOfUser / 100));
    setState(() {
      if (_bmi >= 18.5 && _bmi <= 25) {
        _bmiModel =
            BMIModel(bmi: _bmi, isNormal: true, comments: "You are Totaly Fit");
      } else if (_bmi < 18.5) {
        _bmiModel = BMIModel(
            bmi: _bmi, isNormal: false, comments: "You are Underweighted");
      } else if (_bmi > 25 && _bmi <= 30) {
        _bmiModel = BMIModel(
            bmi: _bmi, isNormal: false, comments: "You are Overweighted");
      } else {
        _bmiModel =
            BMIModel(bmi: _bmi, isNormal: false, comments: "You are Obesed");
      }
    });
  }

  saveWorkoutData() async {
    DateTime startTime = DateTime.parse(widget.dateTime);
    DateTime timeAfterWorkOut = DateTime.now();
    int activeTime = timeAfterWorkOut.difference(startTime).inSeconds;
    RecentWorkout recentWorkout = RecentWorkout(
      timeAfterWorkOut.toIso8601String(),
      widget.title,
      activeTime,
      3,
      12.0,
      widget.totalExercise,
    );
    int a = await dbHelper.saveWorkOut(recentWorkout);
    print(a);
  }

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerTopCenter.play();
    _controllerCenterLeft.play();
    _controllerCenterRight.play();
    //_controllerBottomCenter.play();
    getBmiValue();
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    _controllerTopCenter.dispose();
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  final _screenshotController = ScreenshotController();

  getTitle(double height, double width) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          height: height + 100,
          width: width,
          child: Center(
            child: SvgPicture.asset(
              'assets/other/well_done.svg',
              alignment: Alignment.center,
              width: width - 50,
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
                height: 30,
              ),
              Text(
                "Congratulations !",
                style: textTheme.bodyText1.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "You did it!",
                style: textTheme.bodyText2
                    .copyWith(color: Colors.black, fontSize: 22),
              )
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }

  getAchievement() {
    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Achievement(
          exerciseValue: 82,
          exerciseTitle: 'Exercise',
          caloriesValue: 802,
          caloriesTitle: 'Calories',
          timeValue: 782,
          timeTitle: 'Minutes',
        ),
      ),
    );
  }

  //Congratulations! You did it!
  //Congratulations! You totally nailed it!

  getRatingBar(double height) {
    TextStyle bodyStyle =
        textTheme.bodyText2.copyWith(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.white);
    return Container(
      color: Colors.blue,
      height: height * .2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "How it feel?",
            style: textTheme.bodyText1
                .copyWith(fontSize: 22, fontWeight: FontWeight.w700,color: Colors.white),
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
            child: RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 12.0),
              itemBuilder: (context, _) => Icon(
                Icons.circle,
                color: Colors.white,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ),
        ],
      ),
    );
  }

  getButton(
      {Function onPress,
      String title,
      Color textColor,
      Color backgroundColor}) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: backgroundColor,
            side: BorderSide(
                color: Colors.blue, style: BorderStyle.solid, width: 0),
          ),
          onPressed: onPress,
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .button
                .merge(TextStyle(color: textColor,fontSize: 20,fontWeight: FontWeight.w500)),
          )),
    );
  }

  getBmiCard(double height, double width, double bmiPadding) {
    getText(String title) {
      return Text(
        title,
        style: textTheme.bodyText2
            .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
      );
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 12.0, right: 12),
      height: height * .4,
      child: Column(children: [
        Container(
          height: height * .07,
          color: Colors.white,
          child: Row(
            children: [
              Container(
                color: Colors.blueGrey,
                width: bmiPadding * .1,
              ),
              SizedBox(
                width: 3,
              ),
              Container(
                color: Colors.green,
                width: bmiPadding * .12,
              ),
              SizedBox(
                width: 3,
              ),
              Container(color: Colors.orangeAccent, width: bmiPadding * .33),
              SizedBox(
                width: 3,
              ),
              Container(
                color: Colors.deepOrange,
                width: bmiPadding * .15,
              ),
              SizedBox(
                width: 3,
              ),
              Container(color: Colors.redAccent, width: bmiPadding * .15),
              SizedBox(
                width: 3,
              ),
              Container(
                color: Colors.red,
                width: bmiPadding * .15,
              ),
            ],
          ),
        ),
        Container(
          height: height * .03,
          color: Colors.white,
          child: Row(
            children: [
              Container(
                width: 20,
                child: getText("15"),
              ),
              SizedBox(
                width: bmiPadding * .1 - 22,
              ),
              Container(
                width: 20,
                child: getText("16"),
              ),
              SizedBox(
                width: bmiPadding * .12 - 22,
              ),
              Container(width: 30, child: getText("18.5")),
              SizedBox(
                width: bmiPadding * .33 - 35,
              ),
              Container(width: 15, child: getText("25")),
              SizedBox(width: bmiPadding * .18),
              Container(
                width: 20,
                child: getText("30"),
              ),
              SizedBox(width: bmiPadding * .15 - 22),
              Container(
                width: 20,
                child: getText("35"),
              ),
              SizedBox(width: bmiPadding * .15 - 50),
              Container(
                width: 30,
                child: getText("40"),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double safeHeight = AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double bmiPadding = width - 24 - 15;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Screenshot(
        controller: _screenshotController,
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                Container(
                  height: safeHeight,
                  color: Colors.white,
                ),
                Container(
                  height: height * .5 - safeHeight,
                  width: width,
                  color: Colors.white,
                  child: getTitle(height * .5 - safeHeight, width),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     SizedBox(height: 20,),
                  //
                  //     getRatingBar(),
                  //     RaisedButton(
                  //       onPressed: () {
                  //         _takeScreenshot();
                  //       },
                  //       child: Text("Share"),
                  //       elevation: 10,
                  //       color: Colors.purple.shade300,
                  //     ),
                  //
                  //     if(_bmi != null && _bmi != 0.0)
                  //       Card(
                  //         elevation: 20,
                  //         color: Colors.white,
                  //         child: ResultScreen(
                  //             bmiModel: _bmiModel
                  //         ),
                  //       ),
                  //   ],
                  // ),
                ),

                //  if(_bmi != null && _bmi != 0.0)
                Expanded(child: getAchievement()),
                // Container(
                //   color: Colors.white,
                //   child: ResultScreen(bmiModel: _bmiModel),
                // ),
                getRatingBar(height),
                Container(
                  color: Colors.blue,
                  width: width,
                  child:   getButton(
                      backgroundColor: Colors.white,
                      textColor: Colors.blue,
                      onPress: () {},
                      title: "Continue")
                ),

                Align(
                  alignment: Alignment.center,
                  child: ConfettiWidget(
                    confettiController: _controllerCenterLeft,
                    blastDirection: -pi / 2,
                    emissionFrequency: 0.01,
                    numberOfParticles: 20,
                    maxBlastForce: 100,
                    minBlastForce: 80,
                    gravity: 0.3,
                  ),
                ),

              ],
            ),
            Positioned(
                top: height * .45,
                left: width * .4,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Share",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                ))
          ],
        ),
      ),
    );
  }
  void _takeScreenshot() async {
    final screenShort = await _screenshotController.capture();
    final dir = await pp.getExternalStorageDirectory();
    String currDate = DateTime.now().toString();
    final myImagePath = dir.path + "/$currDate.png";
    File imageFile = File(myImagePath);
    if(! await imageFile.exists()){
      imageFile.create(recursive: true);
    }
    imageFile.writeAsBytes(screenShort);

    Share.shareFiles([myImagePath],subject:"subject",text: "Text" );
  }
  // void _takeScreenshot() async{
  //   final imageFile = await _screenshotController.capture();
  //   Share.shareFiles([imageFile.path.toString()]);
  // }

}
