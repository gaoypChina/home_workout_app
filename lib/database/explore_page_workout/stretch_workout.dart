import 'package:flutter/material.dart';
import '../explore_page_workout/picked_workout_database.dart';
import '../../enums/workout_type.dart';
import '../../models/explore_workout_card_model.dart';

List<ExploreWorkoutCardModel> stretchWorkoutList = [
  ExploreWorkoutCardModel(
      workoutType: WorkoutType.Beginner,
      description: [],
      workoutList: [],
      title: "Full Body Stretching",
      imgSrc: "assets/icons/push-up.png",
      color: Colors.deepOrangeAccent),
  ExploreWorkoutCardModel(
      workoutType: WorkoutType.Beginner,
      description: bellyFatBurner.description,
      workoutList: [],
      title: "Shoulder & Neck Tension Relief",
      imgSrc: "assets/icons/lunges.png",
      color: Colors.blueGrey),
  ExploreWorkoutCardModel(
      workoutType: WorkoutType.Beginner,
      description: bellyFatBurner.description,
      workoutList: [],
      title: "Morning Stretches",
      imgSrc: "assets/icons/exercises.png",
      color: Colors.redAccent),
  ExploreWorkoutCardModel(
      workoutType: WorkoutType.Beginner,
      description: bellyFatBurner.description,
      workoutList: [],
      title: "Lower Back Pain Relief",
      imgSrc: "assets/icons/lunges.png",
      color: Colors.teal),
  ExploreWorkoutCardModel(
      workoutType: WorkoutType.Beginner,
      description: bellyFatBurner.description,
      workoutList: [],
      title: "Bed Time Stretches",
      imgSrc: "assets/icons/fitness.png",
      color: Colors.pinkAccent),
  ExploreWorkoutCardModel(
      workoutType: WorkoutType.Beginner,
      description: bellyFatBurner.description,
      workoutList: [],
      title: "Upper Body Stretching",
      imgSrc: "assets/icons/yoga.png",
      color: Colors.blueGrey),
  ExploreWorkoutCardModel(
    workoutType: WorkoutType.Beginner,
    title: "Lower Body Stretching",
    imgSrc: "assets/icons/fitness.png",
    color: Colors.brown,
    description: bellyFatBurner.description,
    workoutList: bellyFatBurner.workoutList,
  ),
];
