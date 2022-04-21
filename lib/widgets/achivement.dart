import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';


class Achievement extends StatefulWidget {
  final Function onTap;

  Achievement({required this.onTap});

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

    int loadedTime = await _spHelper.loadInt(_spKey.time) ??0;
    int loadedExercise = await _spHelper.loadInt(_spKey.exercise) ??0;
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

          decoration: BoxDecoration(
              color: color[0].withOpacity(.1),
            borderRadius: BorderRadius.all(Radius.circular(18))
          ),
          padding: EdgeInsets.symmetric(horizontal: 18,vertical: 18),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            onTap: () => widget.onTap(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  isLoading ? "" : subTitle.length == 1?"0"+subTitle : subTitle,

                  style: TextStyle(
                    letterSpacing: 1.5,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.8),
                      fontSize: 30),
                ),

                SizedBox(height: 2,),
                Text(
                  title,
                  style: TextStyle(
                    letterSpacing: 1.5,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      fontWeight: FontWeight.w400,
                      fontSize: 13),
                ),
              ],
            ),
          ),
        );
      }

      return Container(

        padding: EdgeInsets.symmetric(horizontal: 12),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            getCard("Exercise", exercise.toString(),
                [Colors.green.shade700, Colors.green]),
            getCard(" Minute ", (time/60).ceil().toString(),
                [Colors.orange.shade700, Colors.red.shade300]),
            getCard("Calories", calories.toInt().toString(),
                [Colors.amber.shade700, Colors.blue]),
          ],
        ),
      );
    }
    return getAchievementCard(time, exercise, calories, isLoading);
  }
}
