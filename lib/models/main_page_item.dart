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
      imageUrl: "imageUrl",
      title: "Abs Beginner",
      tag: "Beginner"),
  ExerciseCard(
      workoutList: absIntermediate,
      imageUrl: "imageUrl",
      title: "Abs Intermediate",
      tag: "Intermediate"),
  ExerciseCard(
      workoutList: absAdvance,
      imageUrl: "imageUrl",
      title: "Abs Advance",
      tag: "Advance")
];

List<ExerciseCard> chestExercise = [
  ExerciseCard(
      workoutList: chestBeginner,
      imageUrl: "imageUrl",
      title: "Chest Beginner",
      tag: "Beginner"),
  ExerciseCard(
      workoutList: chestIntermediate,
      imageUrl: "imageUrl",
      title: "Chest Intermediate",
      tag: "Intermediate"),
  ExerciseCard(
      workoutList: chestAdvance,
      imageUrl: "imageUrl",
      title: "Chest Advance",
      tag: "Advance")
];

List<ExerciseCard> shoulderExercise = [
  ExerciseCard(
      workoutList: absBeginner,
      imageUrl: "imageUrl",
      title: "Abs Beginner",
      tag: "Beginner"),
  ExerciseCard(
      workoutList: absIntermediate,
      imageUrl: "imageUrl",
      title: "Abs Intermediate",
      tag: "Intermediate"),
  ExerciseCard(
      workoutList: absAdvance,
      imageUrl: "imageUrl",
      title: "Abs Advance",
      tag: "Advance")
];

List<ExerciseCard> legsExercise = [
  ExerciseCard(
      workoutList: absBeginner,
      imageUrl: "imageUrl",
      title: "Legs Beginner",
      tag: "Beginner"),
  ExerciseCard(
      workoutList: absIntermediate,
      imageUrl: "imageUrl",
      title: "Legs Intermediate",
      tag: "Intermediate"),
  ExerciseCard(
      workoutList: absAdvance,
      imageUrl: "imageUrl",
      title: "Legs Advance",
      tag: "Advance")
];

List<ExerciseCard> armsExercise = [
  ExerciseCard(
      workoutList: absBeginner,
      imageUrl: "imageUrl",
      title: "Arms Beginner",
      tag: "Beginner"),
  ExerciseCard(
      workoutList: absIntermediate,
      imageUrl: "imageUrl",
      title: "Arms Intermediate",
      tag: "Intermediate"),
  ExerciseCard(
      workoutList: absAdvance,
      imageUrl: "imageUrl",
      title: "Arms Advance",
      tag: "Advance")
];
