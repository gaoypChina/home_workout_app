import 'package:flutter/material.dart';

import '../../database/workout_list.dart';
import '../../enums/workout_type.dart';
import '../../models/explore_workout_card_model.dart';

List<ExploreWorkoutCardModel> beginnerWorkoutList = [
  absMaker,
  lightCardio,
  legWorkout,
  armWorkout,
  widerShoulder,
  robustChestBeginner,
];

ExploreWorkoutCardModel absMaker = ExploreWorkoutCardModel(
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
    title: "Abs Maker",
    imgSrc: "assets/icons/push-up.png",
    color: Colors.deepOrangeAccent);
ExploreWorkoutCardModel lightCardio = ExploreWorkoutCardModel(
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
    color: Colors.blueGrey);
ExploreWorkoutCardModel legWorkout = ExploreWorkoutCardModel(
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
    wallUp,
    sumoSquat,
    wallResistingSingleLegLeft,
    wallResistingSingleLegRight,
    lyingButterFlyStretch,
  ],
  title: "Leg workout",
  imgSrc: "assets/icons/exercises.png",
  color: Colors.redAccent,
);
ExploreWorkoutCardModel armWorkout = ExploreWorkoutCardModel(
  workoutType: WorkoutType.Beginner,
  description: [
    "If you have no weights in sight or you’re new to arm workouts, you can just use your body weight to get an arm workout.",
    "According to Salvatore, most arm exercises without weights are just variations of planks or push-ups, which means they require you to engage your core"
  ],
  workoutList: [
    jumpingJacks,
    armCircleClockWise,
    tricepsDipsChest,
    pushUps,
    elbowPlanks,
    tricepsDipsChest2,
    pushUps2,
    elbowPlanks,
    tricepsStretchLeft,
    tricepsStretchLeft,
    cobraStretch,
  ],
  title: "Arm workout",
  imgSrc: "assets/icons/lunges.png",
  color: Colors.teal,
);
ExploreWorkoutCardModel widerShoulder = ExploreWorkoutCardModel(
    workoutType: WorkoutType.Beginner,
    description: [
      "Shoulder strength is like the foundation pillar for your head, arms and upper torso. Having strong arms means that you can pretty much do any work like a boss.",
      "An overall toned shoulder benefits other muscles as well. Apart from reduced risk of injury, your biceps and triceps become much stronger. You can perform other types of athletic activities which are indirectly supported by your shoulder muscles."
    ],
    workoutList: [
      shoulderStretch,
      armScissors,
      floorTricepsDips2,
      declinePushUps,
      pikePushUps2,
      floorTricepsDips2,
      tricepsStretchLeft,
      tricepsStretchRight,
      cobraStretch
    ],
    title: "Wider shoulders",
    imgSrc: "assets/icons/yoga.png",
    color: Colors.blueGrey);
ExploreWorkoutCardModel robustChestBeginner = ExploreWorkoutCardModel(
  workoutType: WorkoutType.Beginner,
  title: "Robust chest beginner",
  imgSrc: "assets/icons/fitness.png",
  color: Colors.brown,
  description: [
    "As one of the upper body’s biggest muscle groups, your chest muscles are large enough to handle a great deal of weight. Depending on your workout intensity, you can build progressive strength and add muscle to your chest.",
    "After getting into the groove of chest workouts, you may notice that tasks that were once challenging now require less effort.",
  ],
  workoutList: [
    jumpingJacks,
    tricepsStretchLeft,
    tricepsStretchRight,
    kneePushUps,
    rhomboidPulls,
    inclinePushUps2,
    kneePushUps2,
    chestStretch,
    cobraStretch,
  ],
);
