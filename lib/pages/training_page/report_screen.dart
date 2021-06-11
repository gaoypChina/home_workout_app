

import 'dart:io';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'as pp;

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

  final RecentWorkout recentWorkout;

  ReportScreen({@required this.recentWorkout});

  @override
  _MyAppState createState() => _MyAppState();
}
SpHelper spHelper = SpHelper();
SpKey spKey = SpKey();
BMIModel _bmiModel = BMIModel();

class _MyAppState extends State<ReportScreen> {
  ConfettiController _controllerCenter;
  ConfettiController _controllerCenterRight;
  ConfettiController _controllerCenterLeft;
  ConfettiController _controllerTopCenter;
  ConfettiController _controllerBottomCenter;

  double _bmi;
  double _heightOfUser=121;
  double _weightOfUser;

 void getBmiValue()async{

   await spHelper.loadDouble(spKey.height).then((value){
     if(value == null){
       _bmi = 0.0;
       return _bmi;
     }else{
       setState(() {
         _heightOfUser = value;
       });
     }
   });

   await spHelper.loadDouble(spKey.weight).then((value){
     if(value == null){
       _bmi = 0.0;
       return _bmi;
     }else{
       setState(() {
         _weightOfUser = value;
       });
     }
   });

   print(_heightOfUser);
   print(_weightOfUser);
      _bmi = _weightOfUser /
          ((_heightOfUser / 100) * (_heightOfUser / 100));
setState(() {
  if (_bmi >= 18.5 && _bmi <= 25) {
    _bmiModel = BMIModel(
        bmi: _bmi,
        isNormal: true,
        comments: "You are Totaly Fit");
  } else if (_bmi < 18.5) {
    _bmiModel = BMIModel(
        bmi: _bmi,
        isNormal: false,
        comments: "You are Underweighted");
  } else if (_bmi > 25 && _bmi <= 30) {
    _bmiModel = BMIModel(
        bmi: _bmi,
        isNormal: false,
        comments: "You are Overweighted");
  } else {
    _bmiModel = BMIModel(
        bmi: _bmi,
        isNormal: false,
        comments: "You are Obesed");
  }
});

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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Screenshot(
        controller: _screenshotController,
        child: ListView(
          children: [
            Stack(
              children: [

                Container(
                  height: 700,
                  child: Scaffold(
                    body: Stack(
                      children: <Widget>[
                        Container(
                          height: double.infinity,
                         color: Colors.blue,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/background-vector/undraw_winners_ao2o.svg',
                                alignment: Alignment.center,
                       //         color: Colors.blue,
                                fit: BoxFit.scaleDown,
                                width: MediaQuery.of(context).size.width*.1,
                                height: MediaQuery.of(context).size.height*.45,
                              ),
                              // Container(
                              //   // height: 100,
                              //   child: Image.asset("assets/congo/congratulations1.png"),
                              // ),
                              RaisedButton(
                                onPressed: () {
                                  _takeScreenshot();
                                },
                                child: Text("Share"),
                                elevation: 10,
                                color: Colors.purple.shade300,
                              ),
                              Container(
                                height: 120,
                                child:  Achievement(
                                  exerciseValue: 82,
                                  exerciseTitle: 'Exercise',
                                  caloriesValue: 802,
                                  caloriesTitle: 'Calories',
                                  timeValue: 782,
                                  timeTitle: 'Minutes',
                                ),
                                  ),
                            if(_bmi != null && _bmi != 0.0)
                            Card(
                                elevation: 20,
                                color: Colors.white,
                                child: ResultScreen(
                                  bmiModel: _bmiModel
                                ),
                              ),
                            ],
                          ),
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
                  ),
                ),
              ],
            ),
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
