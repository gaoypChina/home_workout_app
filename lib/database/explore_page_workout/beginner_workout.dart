import 'package:flutter/material.dart';
import 'package:full_workout/database/explore_page_workout/picked_workout_database.dart';

import '../../enums/workout_type.dart';
import '../../models/begginer_workout_model.dart';
import '../../models/explore_workout_model.dart';

List<BeginnerWorkoutModel> beginnerWorkoutList = [
  BeginnerWorkoutModel(
      workoutType: WorkoutType.Beginner,
      description: bellyFatBurner.description,
      workoutList: bellyFatBurner.workoutList,
      title: "ONLY 4 moves for abs",
      imgSrc: "assets/icons/push-up.png",
      color: Colors.deepOrangeAccent),
  BeginnerWorkoutModel(
      workoutType: WorkoutType.Beginner,
      description: bellyFatBurner.description,
      workoutList: bellyFatBurner.workoutList,
      title: "Light Cardio",
      imgSrc: "assets/icons/lunges.png",
      color: Colors.blueGrey),
  BeginnerWorkoutModel(
      workoutType: WorkoutType.Beginner,
      description: bellyFatBurner.description,
      workoutList: bellyFatBurner.workoutList,
      title: "Leg workout",
      imgSrc: "assets/icons/exercises.png",
      color: Colors.redAccent),
  BeginnerWorkoutModel(
      workoutType: WorkoutType.Beginner,
      description: bellyFatBurner.description,
      workoutList: bellyFatBurner.workoutList,
      title: "Arm workout",
      imgSrc: "assets/icons/lunges.png",
      color: Colors.teal),
  BeginnerWorkoutModel(
      workoutType: WorkoutType.Beginner,
      description: bellyFatBurner.description,
      workoutList: bellyFatBurner.workoutList,
      title: "Abs workout",
      imgSrc: "assets/icons/fitness.png",
      color: Colors.pinkAccent),
  BeginnerWorkoutModel(
      workoutType: WorkoutType.Beginner,
      description: bellyFatBurner.description,
      workoutList: bellyFatBurner.workoutList,
      title: "Wider shoulders",
      imgSrc: "assets/icons/yoga.png",
      color: Colors.blueGrey),
  BeginnerWorkoutModel(
    workoutType: WorkoutType.Beginner,
    title: "Beginner push-up",
    imgSrc: "assets/icons/fitness.png",
    color: Colors.brown,
    description: bellyFatBurner.description,
    workoutList: bellyFatBurner.workoutList,
  ),
];
