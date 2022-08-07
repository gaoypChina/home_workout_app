import '../../database/workout_list.dart';

import '../enums/workout_type.dart';

class ExploreWorkout {
  final String title;
  final WorkoutType workoutType;
  final List<Workout> workoutList;
  final String imgSrc;
  final List<String> description;
  int? customTime;

  ExploreWorkout(
      {required this.workoutType,
      required this.workoutList,
      required this.description,
      required this.imgSrc,
      required this.title,
      this.customTime});

  List<int> get getRapList {
    List<int> rapList = [];
    int time = 0;
    for (int index = 0; index < workoutList.length; index++) {
      if (workoutList[index].showTimer == true) {
        time = workoutList[index].duration ?? 30;
      } else {
        if (workoutType == WorkoutType.Beginner) {
          time = workoutList[index].beginnerRap ?? 8;
        } else if (workoutType == WorkoutType.Intermediate) {
          time = workoutList[index].intermediateRap ?? 10;
        } else if (workoutType == WorkoutType.Advance) {
          time = workoutList[index].advanceRap ?? 14;
        } else {
          time = 20;
        }
      }
      rapList.add(time);
    }
    return rapList;
  }

  int get getTime {
    if (customTime != null) {
      return customTime!;
    }

    int time = 0;
    int length = workoutList.length;
    if (length < 15) {
      time = length + 2;
    } else if (length < 20) {
      time = length + 4;
    } else {
      time = length + 6;
    }
    return time;
  }

  String get getExerciseCount {
    int exerciseCount = workoutList.length;
    return "$exerciseCount Exercise";
  }

  String get getWorkoutType => workoutType.name;
}
