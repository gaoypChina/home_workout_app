import 'package:flutter/material.dart';

class Achievement extends StatelessWidget {
  final String exerciseTitle;
  final int exerciseValue;
  final String timeTitle;
  final int timeValue;
  final String caloriesTitle;
  final int caloriesValue;

  Achievement({
    @required this.exerciseTitle,
    @required this.exerciseValue,
    @required this.timeTitle,
    @required this.timeValue,
    @required this.caloriesTitle,
    @required this.caloriesValue,
  });

  Widget circulerCard(int value, String title) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 30,
          child: Text(
            value.toString(),
          ),
        ),
        SizedBox(
          height: 5,
        ),
Text(title)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
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
