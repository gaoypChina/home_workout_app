import 'package:flutter/material.dart';
import 'package:full_workout/database/explore_page_workout/picked_workout_database.dart';
import 'package:full_workout/database/workout_list.dart';

import '../../enums/workout_type.dart';
import '../../models/explore_workout_card_model.dart';

List<ExploreWorkoutCardModel> beginnerWorkoutList = [
  ExploreWorkoutCardModel(
      workoutType: WorkoutType.Beginner,
      description: [
        "Abs workout for beginner is a combination of high-intensity body weight and body weight strength training that requires zero equipment.",
        "The idea is to understand that no equipment does not necessarily mean that one cannot work hard, train muscles, get fitter and a more toned body. In fact, there's a lot that you can achieve with some body weight exercises that just need to be done with the right technique."
      ],
      workoutList: [
        jumpingJacks,
        abdominalCrunches2,
        buttBridge2,
        elbowPlanks,
        reverseCrunches2,
        wipers,
        childPose,
        cobraStretch
      ],
      title: "Abs Beginner",
      imgSrc: "assets/icons/push-up.png",
      color: Colors.deepOrangeAccent),
  ExploreWorkoutCardModel(
      workoutType: WorkoutType.Beginner,
      description: [
        "Light cardio allow a person to perform cardio exercise almost anywhere, such as in their home, public park, or outdoor space.",
        "The following are calorie-burning exercises that a person can do at home with minimal equipment.",
      ],
      workoutList: [
        jumpingJacks,
        kneeToChestStretch,
        sideArmRaise,
        skippingWithOutRope,
        sumoSquat,
        jumpingJacks,
        kneeToChestStretch,
        sideArmRaise,
        jumpingJacks,
      ],
      title: "Light Cardio",
      imgSrc: "assets/icons/lunges.png",
      color: Colors.blueGrey),
  ExploreWorkoutCardModel(
      workoutType: WorkoutType.Beginner,
      description: [
        "Exercises, such as squats, lunges, jumping jacks will improve your range of motion. Once you’ve got the movements and proper mobility down, you’ll be able to safely tackle more weight and ultimately increase your gains.",
        "Strength training of legs outperforms standard cardio exercises when it comes to keeping metabolism levels high.",
      ],
      workoutList: [
        jumpingJacks,
        bottomLegLiftLeft,
        bottomLegLiftRight,
        sumoSquat,
        walkingLunges,
        vUps,
        flutterKikes2,
        walkingLunges,
        wallSit,
        sumoSquat,
        wallResistingSingleLegLeft,
        wallResistingSingleLegRight,
        lyingButterFlyStretch,
      ],
      title: "Leg workout",
      imgSrc: "assets/icons/exercises.png",
      color: Colors.redAccent),
  ExploreWorkoutCardModel(
      workoutType: WorkoutType.Beginner,
      description: bellyFatBurner.description,
      workoutList: [],
      title: "Arm workout",
      imgSrc: "assets/icons/lunges.png",
      color: Colors.teal),
  ExploreWorkoutCardModel(
      workoutType: WorkoutType.Beginner,
      description: bellyFatBurner.description,
      workoutList: [],
      title: "Abs workout",
      imgSrc: "assets/icons/fitness.png",
      color: Colors.pinkAccent),
  ExploreWorkoutCardModel(
      workoutType: WorkoutType.Beginner,
      description: bellyFatBurner.description,
      workoutList: [],
      title: "Wider shoulders",
      imgSrc: "assets/icons/yoga.png",
      color: Colors.blueGrey),
  ExploreWorkoutCardModel(
    workoutType: WorkoutType.Beginner,
    title: "Beginner push-up",
    imgSrc: "assets/icons/fitness.png",
    color: Colors.brown,
    description: bellyFatBurner.description,
    workoutList: bellyFatBurner.workoutList,
  ),
];
