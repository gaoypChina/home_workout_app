import 'package:flutter/material.dart';
import 'package:full_workout/database/workout_list.dart';

import '../../enums/workout_type.dart';
import '../../models/explore_workout_card_model.dart';

List<ExploreWorkoutCardModel> stretchWorkoutList = [
  fullBodyStretching,
  shoulderAndNeckStretching,
  morningStretching,
  lowerBackPainRelief,
  lowerBodyStretching,
  upperBodyStretching,
  bedTimeStretching,
];

var fullBodyStretching = ExploreWorkoutCardModel(
    title: "Full Body Stretching",
    workoutType: WorkoutType.beginner,
    description: [
      "Regular stretching helps increase your range of motion in the joints, improves blood circulation and posture and alleviates muscular tension throughout the body",
      "Not only can stretching help increase your flexibility, which is an important factor of fitness, but it can also improve your posture, reduce stress and body aches, and more."
    ],
    workoutList: [
      armCircleClockWise,
      armCircleCounterClockWise,
      shoulderStretch,
      tricepsStretchLeft,
      tricepsStretchRight,
      chestStretch,
      kneeToChestStretch,
      calfStretchLeft,
      calfStretchRight,
      spineLumberL,
      spineLumberR,
      childPose,
      cobraStretch,
    ],
    imgSrc: "assets/icons/push-up.png",
    color: Colors.deepOrangeAccent);
var shoulderAndNeckStretching = ExploreWorkoutCardModel(
    title: "Shoulder & Neck Stretching",
    workoutType: WorkoutType.beginner,
    description: [
      "Shoulder and neck stretching can help relieve muscle tension, pain, and tightness in the neck and shoulders.",
      "Stiff or tight neck and shoulders can cause discomfort and limit a person's range of motion, this workout help to increase flexibility, improves range of motion, and reduces muscle soreness",
    ],
    workoutList: [
      armCircleClockWise,
      armCircleCounterClockWise,
      armCurlsCrunchLeft,
      armCurlsCrunchRight,
      shoulderStretch,
      seatedSideBendL,
      seatedSideBendR,
      seatedSpinalTwistLeft,
      seatedSpinalTwistRight,
      catCowPose,
      childPose,
    ],
    imgSrc: "assets/icons/lunges.png",
    color: Colors.blueGrey);
var morningStretching = ExploreWorkoutCardModel(
    title: "Morning Stretching",
    workoutType: WorkoutType.beginner,
    description: [
      "A stretching routine can aid mobility and help prevent injury. It may also improve alertness.",
      "Stretching first thing in the morning can relieve any tension or pain from sleeping the night before. It also helps increase your blood flow and prepares your body for the day ahead."
    ],
    workoutList: [
      jumpingJacks,
      abdominalCrunches,
      armCurlsCrunchLeft,
      armCurlsCrunchRight,
      buttBridge,
      seatedSideBendL,
      seatedSideBendR,
      flutterKikes2,
      chestStretch,
      shoulderStretch,
      cobraStretch
    ],
    imgSrc: "assets/icons/exercises.png",
    color: Colors.redAccent);
var lowerBackPainRelief = ExploreWorkoutCardModel(
    title: "Lower Back Pain Relief",
    workoutType: WorkoutType.intermediate,
    description: [
      "Stretching and focused back and abdominal strengthening exercises are two of the best ways to ease lower back pain.",
      "Strong abdominal and hip flexor muscles help improve posture, and strong glutes help support the back while walking, standing, and sitting. Having well stretched muscles helps improve your mobility"
    ],
    workoutList: [
      crossTouchAndReach,
      catCowPose,
      reverseSnowAngle,
      cobraStretch,
      spineLumberL,
      spineLumberR,
      pulseUp,
      threadTheNeedleL,
      threadTheNeedleR,
      buttBridge,
      reverseCrunches,
      seatedSideBendL,
      seatedSideBendR,
      seatedSpinalTwistLeft,
      seatedSpinalTwistRight,
      childPose,
      cobraStretch,
    ],
    imgSrc: "assets/icons/lunges.png",
    color: Colors.teal);
var lowerBodyStretching = ExploreWorkoutCardModel(
    title: "Lower Body Stretching",
    workoutType: WorkoutType.intermediate,
    description: [
      "Stretching keeps the muscles flexible, strong, and healthy, and we need that flexibility to maintain a range of motion in the joints. Without it, the muscles shorten and become tight.",
      "Regular stretching helps increase your range of motion in the joints, improves blood circulation and posture and alleviates muscular tension throughout the body",
    ],
    workoutList: [
      forwardBend,
      curtsyLunges,
      kneeToChestStretch,
      fireHydrantLeft,
      fireHydrantRight,
      flutterKikes,
      lateralSquat,
      lyingButterFlyStretch,
      bottomLegLiftLeft,
      bottomLegLiftRight,
      mountainClimbing,
      calfStretchLeft,
      calfStretchRight,
      walkingLunges,
      quadStretchLeft,
      quadStretchright,
      spineLumberL,
      spineLumberR,
    ],
    imgSrc: "assets/icons/fitness.png",
    color: Colors.brown);
var upperBodyStretching = ExploreWorkoutCardModel(
    workoutType: WorkoutType.beginner,
    description: [
      "These upper body stretches will also help to maintain good posture. It's best to stretch after a warm up or your workout",
      "It Increases Your Active Range of Motion. As your tight and stiff muscles are being loosened through stretching, your active range of motion is also increased.",
    ],
    workoutList: [
      armCircleClockWise,
      armCircleCounterClockWise,
      armScissors,
      armCurlsCrunchLeft,
      armCurlsCrunchRight,
      tricepsStretchLeft,
      tricepsStretchRight,
      seatedSideBendL,
      seatedSideBendR,
      seatedSpinalTwistLeft,
      seatedSpinalTwistRight,
      spineLumberL,
      spineLumberR,
      chestStretch,
      childPose,
      cobraStretch,
    ],
    title: "Upper Body Stretching",
    imgSrc: "assets/icons/yoga.png",
    color: Colors.blueGrey);
var bedTimeStretching = ExploreWorkoutCardModel(
    title: "Bed Time Stretching",
    imgSrc: "assets/icons/exercises.png",
    color: Colors.redAccent,
    workoutType: WorkoutType.beginner,
    description: [
      "Stretching before bed can have both physical and mental benefits. It is an effective method to help melt away the day’s stress, stretches also help release and restore tense muscles for a better night’s sleep.",
      "Stretching keeps the muscles flexible, strong, and healthy, and we need that flexibility to maintain a range of motion in the joints. Without it, the muscles shorten and become tight.",
    ],
    workoutList: [
      calfStretchLeft,
      calfStretchRight,
      threadTheNeedleL,
      threadTheNeedleR,
      wipers,
      tricepsStretchLeft,
      tricepsStretchRight,
      catCowPose,
      lyingButterFlyStretch,
      spineLumberL,
      spineLumberR,
      cobraStretch,
      childPose,
    ]);
