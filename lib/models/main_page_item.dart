import 'package:flutter/cupertino.dart';
import 'package:full_workout/database/workout_list.dart';

class ExerciseCard {
  final List<Workout> workoutList;
  final String imageUrl;
  final String title;
  final String tag;

  ExerciseCard(
      {required this.workoutList,
      required this.imageUrl,
      required this.title,
      required this.tag});
}

List<String> exerciseName = [
  "Chest Workout",
  "Shoulder Workout",
  "Abs Workout",
  "Legs Workout",
  "Arms Workout"
];

List<ExerciseCard> absExercise = [
  ExerciseCard(
      workoutList: absBeginner,
      imageUrl: "assets/home_cover/14.jpg",
      title: "Abs Beginner",
      tag: "Beginner"),
  ExerciseCard(
      workoutList: absIntermediate,
      imageUrl: "assets/home_cover/13.jpg",
      title: "Abs Intermediate",
      tag: "Intermediate"),
  ExerciseCard(
      workoutList: absAdvance,
      imageUrl: "assets/home_cover/6.jpg",
      title: "Abs Advance",
      tag: "Advance")
];

List<ExerciseCard> chestExercise = [
  ExerciseCard(
      workoutList: chestBeginner,
      imageUrl: "assets/home_cover/10.jpg",
      title: "Chest Beginner",
      tag: "Beginner"),
  ExerciseCard(
      workoutList: chestIntermediate,
      imageUrl: "assets/home_cover/9.jpg",
      title: "Chest Intermediate",
      tag: "Intermediate"),
  ExerciseCard(
      workoutList: chestAdvance,
      imageUrl: "assets/home_cover/4.jpg",
      title: "Chest Advance",
      tag: "Advance")
];

List<ExerciseCard> shoulderExercise = [
  ExerciseCard(
      workoutList: shoulderBeginner,
      imageUrl: "assets/home_cover/11.jpg",
      title: "Shoulder Beginner",
      tag: "Beginner"),
  ExerciseCard(
      workoutList: shoulderIntermediate,
      imageUrl: "assets/home_cover/5.jpg",
      title: "Shoulder Intermediate",
      tag: "Intermediate"),
  ExerciseCard(
      workoutList: shoulderAdvance,
      imageUrl: "assets/home_cover/12.jpg",
      title: "Shoulder Advance",
      tag: "Advance")
];

List<ExerciseCard> legsExercise = [
  ExerciseCard(
      workoutList: legsBeginner,
      imageUrl: "assets/home_cover/1.jpg",
      title: "Legs Beginner",
      tag: "Beginner"),
  ExerciseCard(
      workoutList: legsIntermediate,
      imageUrl: "assets/home_cover/15.jpg",
      title: "Legs Intermediate",
      tag: "Intermediate"),
  ExerciseCard(
      workoutList: legsAdvance,
      imageUrl: "assets/home_cover/10.jpg",
      title: "Legs Advance",
      tag: "Advance")
];

List<ExerciseCard> armsExercise = [
  ExerciseCard(
      workoutList: armsBeginner,
      imageUrl: "assets/home_cover/5.jpg",
      title: "Arms Beginner",
      tag: "Beginner"),
  ExerciseCard(
      workoutList: armsIntermediate,
      imageUrl: "assets/home_cover/14.jpg",
      title: "Arms Intermediate",
      tag: "Intermediate"),
  ExerciseCard(
      workoutList: armsAdvance,
      imageUrl: "assets/home_cover/15.jpg",
      title: "Arms Advance",
      tag: "Advance")
];
