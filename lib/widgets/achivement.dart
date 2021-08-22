import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';

import '../main.dart';

class Achievement extends StatefulWidget {
  final Function onTap;

  Achievement({@required this.onTap});

  @override
  _AchievementState createState() => _AchievementState();
}

class _AchievementState extends State<Achievement> {
  bool isLoading = true;
  SpHelper _spHelper = SpHelper();
  SpKey _spKey = SpKey();
  int time = 0;
  int exercise = 0;
  double calories = 0;

  getData() async {
    setState(() {
      isLoading = true;
    });

    int loadedTime = await _spHelper.loadInt(_spKey.time) == null
        ? 0
        : await _spHelper.loadInt(_spKey.time);
    int loadedExercise = await _spHelper.loadInt(_spKey.exercise) == null
        ? 0
        : await _spHelper.loadInt(_spKey.exercise);
    calories = loadedTime * (18 / 60);
    time = loadedTime;
    exercise = loadedExercise;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    Widget getAchievementCard(
        int time, int exercise, double calories, bool isLoading) {
      getCard(String title, String subTitle, List<Color> color) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            onTap: () => widget.onTap(),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 12,),
                  Text(
                    isLoading ? "" : subTitle,
                    style: textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w500,
                        color: isDark?Colors.white:Colors.blue.shade700,
                        fontSize: 28),
                  ),

                  Text(
                    title,
                    style: textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      return Container(

        padding: EdgeInsets.symmetric(horizontal: 8),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getCard("Exercise", exercise.toString(),
                [Colors.green.shade700, Colors.green]),
            getCard("Minute", (time~/60).toString(),
                [Colors.red.shade700, Colors.red.shade300]),
            getCard("Calories", calories.toInt().toString(),
                [Colors.orange.shade700, Colors.orange]),
          ],
        ),
      );
    }
    return getAchievementCard(time, exercise, calories, isLoading);
  }
}
