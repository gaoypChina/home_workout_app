import 'package:flutter/material.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';

import '../main.dart';

class Achievement extends StatefulWidget {

  @override
  _AchievementState createState() => _AchievementState();
}


class _AchievementState extends State<Achievement> {
  bool isLoading = true;
  SpHelper _spHelper = SpHelper();
  SpKey _spKey = SpKey();


  int time;
  int exercise;
  double calories;
  getData() async{
  int  loadedTime = await _spHelper.loadInt(_spKey.time)== null ? 0:await _spHelper.loadInt(_spKey.time);
  int  loadedExercise = await _spHelper.loadInt(_spKey.exercise) == null ? 0 : await _spHelper.loadInt(_spKey.exercise);
    calories = loadedExercise * (18/60);
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


    Widget getAchievementCard(int time, int exercise, double calories) {
      getCard(String title, String subTitle, Color color) {
        return Container(

          height: MediaQuery.of(context).size.height*.12,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Container(
              width: MediaQuery.of(context).size.width/3.5,
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

      return Container(


        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            getCard("Exercise",exercise.toString(), Colors.green.shade500),
            getCard("Time",(time % 60).toString().padLeft(2, '0') , Colors.red.shade400),
            getCard("Calories",calories.toInt().toString(), Colors.orange.shade400),
          ],
        ),
      );
    }
    return
    isLoading ? CircularProgressIndicator():
      getAchievementCard( time,  exercise,  calories);
  }
}
