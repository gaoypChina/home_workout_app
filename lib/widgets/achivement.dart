import 'package:flutter/material.dart';
import 'package:full_workout/helper/light_dark_mode.dart';

class Achievement extends StatelessWidget {
  final String exerciseTitle;
  final int exerciseValue;
  final String timeTitle;
  final int timeValue;
  final String caloriesTitle;
  final int caloriesValue;
  final Color bgColor;

  Achievement({
    @required this.exerciseTitle,
    @required this.exerciseValue,
    @required this.timeTitle,
    @required this.timeValue,
    @required this.caloriesTitle,
    @required this.caloriesValue,
    this.bgColor =Colors.white,
  });

  Widget circulerCard(int value, String title) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Color(0xffF6F6F6),
          radius: 30,
          child: Text(
            value.toString(),style: textTheme.subtitle1.copyWith(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: 5,
        ),
Text(title,style: textTheme.subtitle2.copyWith(fontSize: 16,color: Colors.white),)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          circulerCard(exerciseValue, exerciseTitle),
          circulerCard(timeValue, timeTitle),
          circulerCard(caloriesValue, caloriesTitle),
        ],
      ),
    );
  }
}
