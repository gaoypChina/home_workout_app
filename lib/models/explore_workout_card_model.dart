import 'dart:ui';

import '../database/workout_list.dart';
import '../enums/workout_type.dart';
import 'explore_workout_model.dart';

class ExploreWorkoutCardModel extends ExploreWorkout {
  final title;
  final imgSrc;
  final List<String> description;
  final WorkoutType workoutType;
  final List<Workout> workoutList;

  final Color color;

  ExploreWorkoutCardModel(
      {required this.title,
      required this.imgSrc,
      required this.color,
      required this.workoutType,
      required this.description,
      required this.workoutList})
      : super(
          imgSrc: imgSrc,
          title: title,
          description: description,
          workoutList: workoutList,
          workoutType: workoutType,
        );
}
