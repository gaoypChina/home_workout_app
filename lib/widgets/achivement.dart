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
    Widget getAchievementCard(
        int time, int exercise, double calories, bool isLoading) {
      getCard(String title, String subTitle, List<Color> color) {
        return Container(
          height: MediaQuery.of(context).size.height * .13,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Container(
              width: MediaQuery.of(context).size.width / 3.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue.shade700,Colors.blue.shade300],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                onTap: () => widget.onTap(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isLoading ? "" : subTitle,
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
