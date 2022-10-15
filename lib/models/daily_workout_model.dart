import 'explore_workout_model.dart';

class DailyWorkoutModel {
  final int index;
  final String dayName;
  final String imgSrc;
  final ExploreWorkout workout;

  DailyWorkoutModel(
      {required this.imgSrc,
        required this.index,
        required this.dayName,
        required this.workout});
}
