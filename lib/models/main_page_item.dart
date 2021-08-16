import 'package:flutter/cupertino.dart';
import 'package:full_workout/database/workout_list.dart';

class ExerciseCard {
  final List<Workout> workoutList;
  final String imageUrl;
  final String title;
  final String tag;

  ExerciseCard(
      {@required this.workoutList,
      @required this.imageUrl,
      @required this.title,
      @required this.tag});
}

List<String> exerciseName = [
  "Abs Workout",
  "Chest Workout",
  "Shoulder Workout",
  "Legs Workout",
  "Arms Workout"
];

List<ExerciseCard> absExercise = [
  ExerciseCard(
      workoutList: absBeginner,
      imageUrl: "assets/workout_cover/elbowPlank.png",
      title: "Abs Beginner",
      tag: "Beginner"),
  ExerciseCard(
      workoutList: absIntermediate,
      imageUrl: "assets/workout_cover/abdominal_crunches.png",
      title: "Abs Intermediate",
      tag: "Intermediate"),
  ExerciseCard(
      workoutList: absAdvance,
      imageUrl: "assets/workout_cover/walking_plack.png",
      title: "Abs Advance",
      tag: "Advance")
];

List<ExerciseCard> chestExercise = [
  ExerciseCard(
      workoutList: chestBeginner,
      imageUrl: "assets/workout_cover/elbowPlank.png",
      title: "Chest Beginner",
      tag: "Beginner"),
  ExerciseCard(
      workoutList: chestIntermediate,
      imageUrl: "assets/workout_cover/cobraStratch.png",
      title: "Chest Intermediate",
      tag: "Intermediate"),
  ExerciseCard(
      workoutList: chestAdvance,
      imageUrl: "assets/workout_cover/hindu_push_ups.png",
      title: "Chest Advance",
      tag: "Advance")
];

List<ExerciseCard> shoulderExercise = [
  ExerciseCard(
      workoutList: shoulderBeginner,
      imageUrl: "assets/workout_cover/arm_circle.png",
      title: "Shoulder Beginner",
      tag: "Beginner"),
  ExerciseCard(
      workoutList: shoulderIntermediate,
      imageUrl: "assets/workout_cover/arm_curls_crunches.png",
      title: "Shoulder Intermediate",
      tag: "Intermediate"),
  ExerciseCard(
      workoutList: shoulderAdvance,
      imageUrl: "assets/workout_cover/pick_pushups.png",
      title: "Shoulder Advance",
      tag: "Advance")
];

List<ExerciseCard> legsExercise = [
  ExerciseCard(
      workoutList: legsBeginner,
      imageUrl: "assets/workout_cover/mountain_climbilng.png",
      title: "Legs Beginner",
      tag: "Beginner"),
  ExerciseCard(
      workoutList: legsIntermediate,
      imageUrl: "assets/workout_cover/knee_hug.png",
      title: "Legs Intermediate",
      tag: "Intermediate"),
  ExerciseCard(
      workoutList: legsAdvance,
      imageUrl: "assets/workout_cover/squarts.png",
      title: "Legs Advance",
      tag: "Advance")
];

List<ExerciseCard> armsExercise = [
  ExerciseCard(
      workoutList: armsBeginner,
      imageUrl: "assets/workout_cover/walking_plack.png",
      title: "Arms Beginner",
      tag: "Beginner"),
  ExerciseCard(
      workoutList: armsIntermediate,
      imageUrl: "assets/workout_cover/pushpus_rotation.png",
      title: "Arms Intermediate",
      tag: "Intermediate"),
  ExerciseCard(
      workoutList: armsAdvance,
      imageUrl: "assets/workout_cover/diagonal_plack.png",
      title: "Arms Advance",
      tag: "Advance")
];
