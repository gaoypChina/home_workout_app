import '../../enums/workout_type.dart';
import '../../models/explore_workout_model.dart';

ExploreWorkout tabata = ExploreWorkout(
  workoutType: WorkoutType.Beginner,
  title: "4 MIN Tabata",
  workoutList: [],
  description: [],
  imgSrc: "assets/explore_image/img_13.jpg",
);
ExploreWorkout looseBellyFat = ExploreWorkout(
  workoutType: WorkoutType.Beginner,

  title: "Lose Belly Fat",
  workoutList: [],
  description: [],
  imgSrc: "assets/explore_image/img_14.jpg",
);
ExploreWorkout cardio = ExploreWorkout(
  workoutType: WorkoutType.Beginner,
  title: "Cardio Workout",
  workoutList: [],
  description: [],
  imgSrc: "assets/explore_image/img_15.jpg",
);
ExploreWorkout classic = ExploreWorkout(
  workoutType: WorkoutType.Beginner,
  title: "7 min Classic",
  workoutList: [],
  description: [],
  imgSrc: "assets/explore_image/img_16.jpg",
);
ExploreWorkout hiitFatBurning = ExploreWorkout(
  workoutType: WorkoutType.Beginner,
  title: "HIIT fat burning",
  workoutList: [],
  description: [],
  imgSrc: "assets/explore_image/img_17.jpg",
);
ExploreWorkout absWorkout = ExploreWorkout(
  workoutType: WorkoutType.Beginner,
  title: "7 min abs workout",
  workoutList: [],
  description: [],
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
