import 'package:flutter/material.dart';

import '../../../../enums/workout_type.dart';
import '../../../../widgets/prime_icon.dart';

class ExploreWorkoutHeader extends StatelessWidget {
  final String imgSrc;
  final String title;
  final WorkoutType workoutType;


  const ExploreWorkoutHeader(
      {Key? key, required this.imgSrc, required this.title, required this.workoutType})
      : super(key: key);

  Color get tileColor {
    Color titleColor;
    if (workoutType == WorkoutType.Beginner) {
      titleColor = Colors.green;
    } else if (workoutType == WorkoutType.Intermediate) {
      titleColor = Colors.orange;
    } else {
      titleColor = Colors.red;
    }
    return titleColor;
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme
        .of(context)
        .textTheme
        .bodyText1!
        .color == Colors.white;


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: imgSrc.contains("icons") ? Stack(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.blue,
                gradient: LinearGradient(colors: [
                  tileColor.withOpacity(isDark ? .2 : .6),
                  tileColor.withOpacity(isDark ? .3 : .8),
                ])),
            padding: EdgeInsets.only(bottom: 18, left: 18, right: 18),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white, fontSize: 24, letterSpacing: 1.2),
              ),
            ),
          ),
          Positioned(
              left: 0,
              top: 0,
              child: Container(
                  padding: EdgeInsets.only(left: 18, bottom: 8, top: 8, right: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          topLeft: Radius.circular(18)),
                      color: tileColor.withOpacity(isDark ? .1 : .5)),
                  height: 150,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Image.asset(
                      imgSrc,
                    ),
                  ))),
          Positioned(right: 8, top: 8, child: PrimeIcon())
        ],
      ):
       Stack(
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: 180,
                maxHeight: 250
              ),
              width: double.infinity,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(imgSrc,fit: BoxFit.fill,)),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.black.withOpacity(.15),
              ),
            ),
            Positioned(right: 8, top: 8, child: PrimeIcon())
          ],
        ),

    ) ;
  }
}
