import '../../database/explore_page_workout/beginner_workout.dart';
import '../../database/explore_page_workout/fast_workout_database.dart';
import '../../database/explore_page_workout/featured_workout_database.dart';
import '../../database/explore_page_workout/picked_workout_database.dart';
import '../../database/explore_page_workout/stretch_workout.dart';

import '../../models/explore_workout_model.dart';
import 'extreme_workout.dart';

List<ExploreWorkout> allExploreWorkout = [
  ...fastWorkoutList,
  ...featuredWorkoutList,
  ...extremeWorkoutList,
  ...pickedWorkoutList,
  ...beginnerWorkoutList,
  ...stretchWorkoutList,
];

List<ExploreWorkout> bodyFocusList = [
  ...fastWorkoutList,
];
