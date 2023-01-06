import 'package:flutter/material.dart';

import '../../../../enums/workout_type.dart';

class ExploreWorkoutHeader extends StatelessWidget {
  final String imgSrc;
  final String title;
  final WorkoutType workoutType;


  const ExploreWorkoutHeader(
      {Key? key, required this.imgSrc, required this.title, required this.workoutType})
      : super(key: key);

  Color get tileColor {
    Color titleColor;
    if (workoutType == WorkoutType.beginner) {
      titleColor = Colors.green;
    } else if (workoutType == WorkoutType.intermediate) {
      titleColor = Colors.orange;
    } else {
      titleColor = Colors.red;
    }
    return titleColor;
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).textTheme.bodyText1!.color == Colors.white;

    return imgSrc.contains("icons")
        ? Container(
      color: Colors.black,
      constraints: BoxConstraints(minHeight: 130, maxHeight: 250),
      width: double.infinity,
      child: ClipRRect(
          child:
          Opacity(
            opacity: .7,
            child: Image.asset(
              "assets/explore_image/img_11.jpg",
              fit: BoxFit.fill,
              height: 10,
            ),
          )),
    )
        : Container(
      color: Colors.black,
            constraints: BoxConstraints(minHeight: 130, maxHeight: 250),
            width: double.infinity,
            child: ClipRRect(
                child:
                Opacity(
                  opacity: .7,
                  child: Image.asset(
              imgSrc,
              fit: BoxFit.fill,
              height: 10,
            ),
                )),
          );
  }
}
