import 'package:flutter/material.dart';

import '../../../../models/explore_workout_model.dart';

class BodyFocusWorkoutPage extends StatelessWidget {
  final String title;
  final String imgSrc;
  final List<ExploreWorkout> workoutList;

  const BodyFocusWorkoutPage(
      {super.key,
      required this.title,
      required this.imgSrc,
      required this.workoutList});

  @override
  Widget build(BuildContext context) {
    buildCard({required ExploreWorkout workout}) {
      return   ListTile(
          title: Text(
          workout.title,
      ),
      contentPadding:
      EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      onTap: () {
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (builder) {
          // return WorkoutSetupPage(
          // workout: workout,
          // header: getHeader(
          // imgSrc: workout.imgSrc,
          // workoutType: workout.workoutType,
          // title: workout.title),
          // );
          // }));
        },
      subtitle: Row(
      children: [
      Text("${workout.getTime} Min"),
      SizedBox(
      width: 6,
      ),
      Icon(
      Icons.circle,
      size: 6,
      color: Theme.of(context)
          .textTheme
          .bodyText1!
          .color!
          .withOpacity(.4),
      ),
      SizedBox(
      width: 6,
      ),
      Text(workout.getExerciseCount)
      ],
      ),
      trailing: Container(
      padding:
      EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
      color: Colors.blueGrey.withOpacity(.8),
      borderRadius:
      BorderRadius.all(Radius.circular(18))),
      child: Text(
      workout.getWorkoutType,
      style: TextStyle(color: Colors.white),
      )),
      leading: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
          child: Image.asset(
            workout.imgSrc,
            width: 70,
          ),
        ),
      ),);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(imgSrc),
            ...workoutList
                .map((workout) => buildCard(workout: workout))
                .toList()
          ],
        ),
      ),
    );
  }
}
