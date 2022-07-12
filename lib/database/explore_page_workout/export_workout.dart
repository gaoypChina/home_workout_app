import 'package:full_workout/database/explore_page_workout/beginner_workout.dart';
import 'package:full_workout/database/explore_page_workout/fast_workout_database.dart';
import 'package:full_workout/database/explore_page_workout/featured_workout_database.dart';
import 'package:full_workout/database/explore_page_workout/picked_workout_database.dart';

import '../../models/explore_workout_model.dart';
import 'extreme_workout.dart';

List<ExploreWorkout> allExploreWorkout = [
  ...fastWorkoutList,
  ...featuredWorkoutList,
  ...extremeWorkoutList,
  ...pickedWorkoutList,
  ...beginnerWorkoutList,
];

List<ExploreWorkout> bodyFocusList =[
  ...fastWorkoutList,
];
