import '../../enums/workout_type.dart';
import '../../models/explore_workout_model.dart';
import '../workout_list.dart';

ExploreWorkout tabata = ExploreWorkout(
  workoutType: WorkoutType.intermediate,
  title: "4 MIN Tabata",
  workoutList: [
    jumpingJacks,
    walkingLunges,
    burpee,
    jumpingSquats,
    declinePushUps,
    burpee,
    jumpingSquats,
    mountainClimbing
  ],customTime: 4,
  description: [
    "High intensity intervals can produce similar fat loss to traditional endurance exercise, even with a much smaller time commitment. They can also reduce waist circumference.",
    "Due to the intensity of the workout, HIIT can elevate your metabolism for hours after exercise. This results in burning additional calories even after you have finished exercising.",
  ],
  imgSrc: "assets/explore_image/img_13.jpg",
);
ExploreWorkout looseBellyFat = ExploreWorkout(
  workoutType: WorkoutType.beginner,
  title: "Lose Belly Fat",
  workoutList: [
    jumpingJacks,
    vUps,
    flutterKikes,
    jumpingSquats,
    buttBridge,
    pulseUp,
    childPose,
  ],
  description: [
    "To improve body composition, it comes down to diet and strength training. If fat loss is your goal, HIIT workout are very helpful to archive you fitness goal.",
    "With HIIT workout you will produce an after-burn effect with 25% more calories burned post-workout compared to going for a run or walk",
  ],
  imgSrc: "assets/explore_image/img_14.jpg",
);
ExploreWorkout cardio = ExploreWorkout(
  workoutType: WorkoutType.beginner,
  title: "Warmup Exercise",
  workoutList: [
    crossTouchAndReach,
    jumpingJacks,
    skippingWithOutRope,
    lateralSquat,
    mountainClimbing
  ],
  description: [
    "A good warm-up session will help you work out as hard as you can while ensuring that you stay injury-free and efficient at the same time",
    "Due to the intensity of the workout, HIIT can elevate your metabolism for hours after exercise. This results in burning additional calories even after you have finished exercising.",
  ],
  imgSrc: "assets/explore_image/img_15.jpg",
);
ExploreWorkout classic = ExploreWorkout(
  workoutType: WorkoutType.intermediate,
  title: "8 min Classic",
  customTime: 8,
  workoutList: [
    jumpingJacks,
    pushUps,
    wallUp,
    abdominalCrunches,
    walkingLunges,
    squats,
    tricepsDipsChest2,
    elbowPlanks,
    flutterKikes2,
    pushUpsRotation,
    sidePlankLeft,
    sidePlankRight,
    cobraStretch,
  ],
  description: [
    "Classic workout include exercise for every mussel group to achieve your all fitness goal",
    "Exercise not only helps you live longer — it helps you live better. In addition to making your heart and muscles stronger and fending off a host of diseases"
  ],
  imgSrc: "assets/explore_image/img_16.jpg",
);
ExploreWorkout hiitFatBurning = ExploreWorkout(
  workoutType: WorkoutType.beginner,
  title: "Fat burning HIIT",
  workoutList: [
    sumoSquat,
    mountainClimbing,
    pushUps,
    abdominalCrunches,
    flutterKikes,
    walkingLunges,
    wipers,
  ],
  description: [
    "HIIT workouts are so popular is because they're extremely effective for weight loss. When trying to lose weight, you want to burn fat and build lean muscle to continue to burn more fat. HIIT forces your body to use energy from fat as opposed to carbs.",
    "Results-wise, HIIT is one of the most efficient ways of burning fat and calories, and your body will carry on reaping the rewards for up to 24 hours after the workout ends.",
  ],
  imgSrc: "assets/explore_image/img_17.jpg",
);
ExploreWorkout absWorkout = ExploreWorkout(
  workoutType: WorkoutType.intermediate,
  customTime: 7,
  title: "7 min abs workout",
  workoutList: [
    crossTouchAndReach,
    mountainClimbing,
    abdominalCrunches,
    vUps,
    reverseCrunches,
    mountainClimbing,
    abdominalCrunches,
    pulseUp,
    reverseCrunches,
    cobraStretch,
  ],
  description: [
    "Abdominal muscles play a crucial role in posture, support of the spine, balance, stability, and respiratory functions such as breathing.",
    "Lower back pain is a problem affecting many people from all backgrounds. Weak abdominal muscles contribute to increased lower back pain. Lower back muscles that are not exercised become rigid in the joint areas and may lead to chronic lower back pain."
  ],
  imgSrc: "assets/explore_image/img_18.jpg",
);

List<ExploreWorkout> fastWorkoutList = [
  tabata,
  absWorkout,
  cardio,
  classic,
  hiitFatBurning,
  looseBellyFat
];
