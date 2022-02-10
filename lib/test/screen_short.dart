import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/models/main_page_item.dart';
import 'package:full_workout/pages/main/home_page/leading_widget.dart';
import 'package:full_workout/widgets/workout_card.dart';

class ScreenShort extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<List<Color>> cardColor = [
      [Colors.green, Colors.blue],
      [Colors.orange, Colors.blue],
      [Colors.red, Colors.blue],
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      title:   RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "Home ",
                  style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w600,
                      fontSize: 22)),
              TextSpan(
                  text: "Workout",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 22))
            ])),
          actions: getLeading(context, color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(

        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
        child: Column(
          children: [
            WorkoutCard(
              color: cardColor[0],
              title: "Abs Workout",
              workoutList: absExercise[0].workoutList,
              tagValue: 0,
              imaUrl: absExercise[0].imageUrl,
              tag: absExercise[0].tag,
              index: 0,
            ),



            WorkoutCard(
              color: cardColor[1],
              title: "Chest Workout",
              workoutList:  chestExercise[1].workoutList,
              tagValue: 0,
              imaUrl: absExercise[1].imageUrl,
              tag: absExercise[0].tag,
              index: 0,
            ),

            WorkoutCard(
              color: cardColor[2],
              title: "Shoulder Workout",
              workoutList: absExercise[0].workoutList,
              tagValue: 0,
              imaUrl: absExercise[0].imageUrl,
              tag: absExercise[0].tag,
              index: 0,
            ),

            WorkoutCard(
              color: cardColor[0],
              title: "Legs Workout",
              workoutList: absExercise[0].workoutList,
              tagValue: 0,
              imaUrl: absExercise[0].imageUrl,
              tag: absExercise[0].tag,
              index: 0,
            ),

            WorkoutCard(
              color: cardColor[1],
              title: "Arms Workout",
              workoutList: absExercise[0].workoutList,
              tagValue: 0,
              imaUrl: absExercise[0].imageUrl,
              tag: absExercise[0].tag,
              index: 0,
            ),
          ],
        ),
      ),
    );
  }
}
