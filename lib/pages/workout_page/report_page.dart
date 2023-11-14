import 'dart:io';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:full_workout/pages/main_page.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../../constants/constant.dart';
import '../../helper/recent_workout_db_helper.dart';
import '../../helper/sp_helper.dart';
import '../../helper/sp_key_helper.dart';
import '../../models/recent_workout.dart';
import '../../pages/main/report_page/workout_report/weekly_workout_report.dart';
import '../../pages/main/report_page/workout_report/workout_detail_report.dart';
import '../../pages/services/bmi_service/bmi_card.dart';
import '../../pages/workout_page/report_share_page.dart';
import '../../provider/ads_provider.dart';
import '../../widgets/slide_fade_transition.dart';
import 'package:path_provider/path_provider.dart' as pp;
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../widgets/banner_medium_ad.dart';

class ReportScreen extends StatefulWidget {
  final String title;
  final String dateTime;
  final int totalExercise;
  final String tag;

  ReportScreen({
    required this.title,
    required this.dateTime,
    required this.totalExercise,
    required this.tag,
  });

  @override
  _MyAppState createState() => _MyAppState();
}

SpHelper spHelper = SpHelper();
SpKey spKey = SpKey();
RecentDatabaseHelper dbHelper = RecentDatabaseHelper();
bool isLoading = false;
Constants constants = Constants();
int activeTime = 0;
final _screenshotController = ScreenshotController();

class _MyAppState extends State<ReportScreen> {
  late ConfettiController _controllerTopCenter;

  saveWorkoutData() async {
    try {
      DateTime startTime = DateTime.parse(widget.dateTime);
      activeTime = DateTime.now().difference(startTime).inSeconds;
      RecentWorkout recentWorkout = RecentWorkout(
        widget.dateTime,
        widget.title,
        activeTime,
        3, //unused value
        DateTime.now().millisecondsSinceEpoch,
        activeTime * (18 / 60),
        widget.totalExercise,
      );
      if (widget.tag == spKey.fullBodyChallenge ||
          widget.tag == spKey.absChallenge ||
          widget.tag == spKey.armChallenge ||
          widget.tag == spKey.chestChallenge) {
        int currVal = await spHelper.loadInt(widget.tag) ?? 0;
        List<String> titleList = widget.title.split(" ");
        int currWorkoutDay = int.tryParse(titleList[4])!;
        if (currWorkoutDay > currVal) {
          spHelper.saveInt(widget.tag, currVal + 1);
        }
      } else {
        spHelper.saveString(widget.tag, widget.dateTime);
      }

      int savedActiveTime = await spHelper.loadInt(spKey.time) ?? 0;
      int totalActiveTime = savedActiveTime + activeTime;

      int savedExercise = await spHelper.loadInt(spKey.exercise) ?? 0;
      int totalExercise = savedExercise + widget.totalExercise;

      spHelper.saveInt(spKey.time, totalActiveTime);
      spHelper.saveInt(spKey.exercise, totalExercise);

      await dbHelper.saveWorkOut(recentWorkout);
    } catch (error) {
      print("error");
      print(error);
    }
  }

  void _takeScreenshot() async {
    setState(() {
      isLoading = true;
    });
    final screenShort = await _screenshotController.captureFromWidget(
      ReportShare(
        title: widget.title,
        date: widget.dateTime,
        time: activeTime ~/ 60,
        calories: (activeTime * (18 / 60)).toInt(),
        exercise: widget.totalExercise,
      ),
    );
    final dir = await pp.getExternalStorageDirectory();
    String currDate = DateTime.now().toString();
    final myImagePath = dir!.path + "/$currDate.png";
    File imageFile = File(myImagePath);
    if (!await imageFile.exists()) {
      imageFile.create(recursive: true);
    }
    imageFile.writeAsBytes(screenShort);
    Share.shareFiles(
      [myImagePath],
      subject: "Install app",
      text:
          "I have completed ${activeTime ~/ 60} minutes of home workout \nYou can start working out at home too with Home workout app: \n ${constants.playStoreLink}",
    );
    setState(() {
      isLoading = false;
    });
  }

  setAwakeScreen() async {
    bool isAwake = await spHelper.loadBool(spKey.awakeScreen) ?? false;
    isAwake ? WakelockPlus.enable() : WakelockPlus.disable();
  }

  _onNext() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context)=>
      MainPage(index: 0),)
    );
    Navigator.of(context).pushNamed(
      WorkoutDetailReport.routeName,
    );
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
          height: height + 30,
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
                  style: TextStyle(
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
                    style: TextStyle(color: Colors.black, fontSize: 22),
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
                            color: Colors.blue,
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
                              backgroundColor: Theme.of(context).primaryColor),
                        ),
                  SizedBox(
                    width: 5,
                  ),
                  Spacer(),
                  TextButton(onPressed: () => _onNext(), child: Text("Next")),
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
          padding: const EdgeInsets.only(top: 24.0, left: 18, bottom: 12),
          child: Text("Past Week", style: constants.titleStyle),
        ),
        IgnorePointer(
          child: WeeklyWorkoutReport(
            showToday: true,
            onTap: () {},
          ),
        ),
        SizedBox(
          height: 18,
        )
      ],
    );
  }

  Widget getAchievementCard() {
    getCard(String title, String subTitle, Color color) {
      return Container(
        height: MediaQuery.of(context).size.height * .14,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Container(
            width: MediaQuery.of(context).size.width / 3.5,
            decoration: BoxDecoration(
              color: color.withOpacity(.9),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    subTitle,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    int exercise = widget.totalExercise;
    int calories = (activeTime * (18 / 60)).toInt();
    int inMinute = activeTime ~/ 60;

    return Container(
      padding: EdgeInsets.only(top: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          getCard("Exercise", exercise.toString(), Colors.green.shade500),
          getCard("Minute", inMinute.toString(), Colors.red.shade400),
          getCard(
              "Calories", calories.toInt().toString(), Colors.orange.shade400),
        ],
      ),
    );
  }

  getRatingBar(double height) {
    TextStyle bodyStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
    return Container(
      //  color:Colors.white,
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
            child: RatingBar.builder(
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
          ),
          onPressed: () {
            _onNext();
          },
          child: Text(
            "Continue",
            style: Theme.of(context).textTheme.bodyLarge!.merge(TextStyle(
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
    var adsProvider = Provider.of<AdsProvider>(context, listen: false);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double safeHeight = AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    return WillPopScope(
      onWillPop: () {
        return _onNext();
      },
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              children: <Widget>[
                getTitle(height * .5 - safeHeight, width),
                Divider(),
                getAchievementCard(),
                getPastWeek(),
                constants.getDivider(context: context),
                BmiCard(
                  showBool: false,
                ),
                SizedBox(
                  height: 10,
                ),
                constants.getDivider(context: context),
                if (adsProvider.showBannerAd)
                  SizedBox(
                    height: 10,
                  ),
                MediumBannerAd(),
                if (adsProvider.showBannerAd)
                  SizedBox(
                    height: 10,
                  ),
                if (adsProvider.showBannerAd)
                  constants.getDivider(context: context),
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
