import 'package:full_workout/database/workout_list.dart';

import '../../enums/workout_type.dart';
import '../../models/explore_workout_model.dart';

List<ExploreWorkout> discoverWorkoutList = [
  alphaCardio,
  absPower,
  workoutCircuit,
  strongerBody,
  oldSchoolWorkout,
];

var alphaCardio = ExploreWorkout(
    title: "Alpha Cardio",
    imgSrc: "assets/explore_image/img_11.jpg",
    workoutType: WorkoutType.Beginner,
    description: [
      "Cardio workout helps you to Improve the flow of oxygen throughout your body. Lower your blood pressure and cholesterol. Reduce your risk for heart disease, diabetes, Alzheimer's disease, stroke",
      "Cardio helps your energy by releasing endorphins, giving you more, lasting energy throughout your day. When it comes to hitting the sheets, struggling to fall asleep is the last thing you want after that long, busy day.",
    ],
    workoutList: [
      jumpingJacks,
      kneePushUps,
      walkingLunges,
      kneeToChestStretch,
      mountainClimbing,
      wipers,
      sumoSquat,
    ]);
var absPower = ExploreWorkout(
    title: "Abs Power",
    imgSrc: "assets/explore_image/img_19.jpg",
    workoutType: WorkoutType.Beginner,
    description: [
          "Building your abs does more than just help you look toned. In fact, a strong core can improve posture, stability, and balance as well as reduce sports-related injuries and low back pain.",
          "A strong core can also make everyday activities easier such as going up the stairs or sitting at your desk for an extended period of time.",
    ],
    workoutList: [
      abdominalCrunches,
      elbowPlanks,
      buttBridge,
      floorTricepsDips,
      abdominalCrunches2,
      wipers,
      reverseCrunches,
      cobraStretch,
    ]);
var workoutCircuit = ExploreWorkout(
    title: "Workout Circuit",
    imgSrc: "assets/explore_image/img_16.jpg",
    workoutType: WorkoutType.Intermediate,
    description: [
          "High intensity intervals can produce similar fat loss to traditional endurance exercise, even with a much smaller time commitment. They can also reduce waist circumference.",
          "Due to the intensity of the workout, HIIT can elevate your metabolism for hours after exercise. This results in burning additional calories even after you have finished exercising.",

    ],
    workoutList: [
      jumpingJacks,
      pushUps,
      burpee,
      walkingLunges,
      wipers,
      kneeToChestStretch,
      mountainClimbing,
      elbowPlanks,
      cobraStretch,
    ]);
var strongerBody = ExploreWorkout(
    title: "Stronger Body Plan",
    imgSrc: "assets/explore_image/img_13.jpg",
    workoutType: WorkoutType.Intermediate,
    description: [
      "You’re going to be pulling, pushing, jumping, doing any kind of activity using only your weight as the resistance.",
      "It may sound simple but you’ll be surprised by just how more challenging you can make it by implementing even the smallest changes.",
    ],
    workoutList: [
      jumpingJacks,
      armCurlsCrunchLeft,
      armCurlsCrunchRight,
      burpee,
      walkingLunges,
      plankUp,
      abdominalCrunches,
      squats,
      wipers,
      staggeredPushUps,
      cobraStretch,
    ]);
var oldSchoolWorkout = ExploreWorkout(
    title: "Old School Workout",
    imgSrc: "assets/explore_image/img_14.jpg",
    workoutType: WorkoutType.Intermediate,
    description: [
      "Old school workout include exercise for every mussel group to achieve your all fitness goal",
      "Exercise not only helps you live longer — it helps you live better. In addition to making your heart and muscles stronger and fending off a host of diseases"

    ],
    workoutList: [
      jumpingJacks,
      sidePlankLeft,
      sidePlankRight,
      squats,
      walkingLunges,
      pushUpsRotation,
      wallUp,
      pushUps,
      abdominalCrunches,
      elbowPlanks,
      mountainClimbing,
      tricepsDipsChest,
      cobraStretch
    ]);
