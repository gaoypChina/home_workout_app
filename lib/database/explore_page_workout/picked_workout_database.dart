import 'package:full_workout/database/workout_list.dart';

import '../../enums/workout_type.dart';
import '../../models/explore_workout_model.dart';

ExploreWorkout strengthenBody = ExploreWorkout(
  title: "Strengthen Body Plan",
  workoutType: WorkoutType.Beginner,
  workoutList: [
    jumpingJacks,
    kneeToChestStretch,
    jumpingSquats,
    tricepsDipsChest,
    mountainClimbing,
    pulseUp,
    squats,
    declinePushUps,
    sidePlankLeft,
    sidePlankRight,
    cobraStretch
  ],
  description: [
    "You’re going to be pulling, pushing, jumping, doing any kind of activity using only your weight as the resistance.",
    "It may sound simple but you’ll be surprised by just how more challenging you can make it by implementing even the smallest changes.",
    "Home workout exercises can promote muscle growth if you increase time under tension. This refers to the amount of time you’re putting strain on your muscles."
  ],
  imgSrc: "assets/explore_image/img_2.jpg",
);

ExploreWorkout toneAbs = ExploreWorkout(
  workoutType: WorkoutType.Beginner,
  workoutList: [
    jumpingJacks,
    walkingPlank,
    sidePlankLeft,
    sidePlankRight,
    reverseCrunches,
    mountainClimbing,
    russianTwist,
    elbowPlanks,
    cobraStretch
  ],
  description: [
    "Building your abs does more than just help you look toned. In fact, a strong core can improve posture, stability, and balance as well as reduce sports-related injuries and low back pain.",
    "A strong core can also make everyday activities easier such as going up the stairs or sitting at your desk for an extended period of time.",
  ],
  imgSrc: "assets/explore_image/img_3.jpg",
  title: "Tone Abs",
);

ExploreWorkout bellyFatBurner = ExploreWorkout(
    workoutType: WorkoutType.Beginner,
    workoutList: [
      jumpingJacks,
      jumpingSquats,
      jumpingJacks,
      abdominalCrunches,
      burpee,
      pulseUp,
      mountainClimbing,
      punches,
      vUps,
      legBurpee,
      abdominalCrunches2,
      mountainClimbing2,
      pulseUp2,
      flutterKikes,
      vUps2,
      lyingButterFlyStretch,
      cobraStretch,
      childPose,
    ],
    description: [
      "HIIT involves short bursts of intense exercise alternated with low intensity recovery periods. Interestingly, it is perhaps the most time-efficient way to exercise",
      "HIIT training can increase the rate at which your body burns calories, it is an excellent training method to burn belly fat",
    ],
    imgSrc: "assets/explore_image/img_1.jpg",
    title: "Belly fat burner HIIT",
    customTime: 15);

ExploreWorkout tricepsSmasher = ExploreWorkout(
  workoutType: WorkoutType.Intermediate,
  workoutList: [
    jumpingJacks,
    benchDips,
    inclinePushUps,
    rhomboidPulls,
    floorTricepsDips,
    diamond,
    inclinePushUps,
    plankUp,
    sideArmRaise,
    floorTricepsDips2,
    inchWorm2,
    threadTheNeedleL,
    threadTheNeedleR,
    childPose
  ],
  description: [
    "The triceps are essential for building upper body strength and helping with movement in your shoulders and elbows.",
    "Increasing triceps strength brings stability to your shoulders and arms, improves flexibility, and increases range of motion."
  ],
  imgSrc: "assets/explore_image/img_1.jpg",
  title: "Triceps Smasher",
);

ExploreWorkout manBoobs = ExploreWorkout(
  workoutType: WorkoutType.Beginner,
  workoutList: [],
  description: [
    "An imbalance between estrogen and androgen hormones typically causes gynecomastia. Men's bodies usually produce small amounts of estrogen, the hormone that controls breast growth.",
    "for the majority of men, man boobs are simply a result of having excess fat on the chest. Your pectoral muscles are underneath the layer of fat. So, by losing body fat and gaining muscle, you can work to get rid of your man boobs.",
  ],
  imgSrc: "assets/explore_image/img_4.jpg",
  title: "Get rid of man boobs",
);


ExploreWorkout insaneAbs = ExploreWorkout(
  workoutType: WorkoutType.Intermediate,
  workoutList: [
    jumpingJacks,
    pulseUp,
    flutterKikes2,
    catCowPose,
    reverseCrunches,
    abdominalCrunches,
    vUps,
    plankUp,
    reverseCrunches2,
    abdominalCrunches2,
    vUps2,
    plankUp2,
    childPose,
    cobraStretch,
    spineLumberL,
    spineLumberR
  ],
  customTime: 14,
  description: [
    "V-cut abs are a coveted shape for many people looking to define their abs.",
    "The V-shape or line is located where the obliques meet the transversus abdominis muscles."
  ],
  imgSrc: "assets/explore_image/img_5.jpg",
  title: "Insane V-shape Abs",
);

ExploreWorkout hiitIntermediate = ExploreWorkout(
  workoutType: WorkoutType.Intermediate,
  workoutList: [
    jumpingJacks,
    armScissors,
    skippingWithOutRope,
    curtsyLunges,
    vUps,
    russianTwist,
    abdominalCrunches,
    squats,
    pushUps,
    kneeToChestStretch,
    flutterKikes,
    squats,
    kneePushUps,
    kneeToChestStretch,
    tricepsStretchLeft,
    tricepsStretchRight,
    calfStretchLeft,
    calfStretchRight,
    cobraStretch,
  ],
  description: [
    "Just 15 min workout to burn and train your full body with the high intensity workout",
    "HIIT can promote a number of physiological benefits, such as increased mitochondrial density, improved stroke volume, improved oxidative capacity of muscle and enhanced aerobic efficiency",
  ],
  customTime: 15,
  imgSrc: "assets/explore_image/img_6.jpg",
  title: "HIIT Intermediate",
);

List<ExploreWorkout> pickedWorkoutList = [
  strengthenBody,
  bellyFatBurner,
  toneAbs,
  tricepsSmasher,
  manBoobs,
  insaneAbs,
  hiitIntermediate
];
