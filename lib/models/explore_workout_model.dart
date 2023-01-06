import '../database/workout_list.dart';
import '../enums/workout_type.dart';

class ExploreWorkout {
  final String title;
  final WorkoutType workoutType;
  final List<Workout> workoutList;
  final String imgSrc;
  final List<String> description;
  int? customTime;
  String? tag;

  ExploreWorkout(
      {required this.workoutType,
      required this.workoutList,
      required this.description,
      required this.imgSrc,
      required this.title,
      this.customTime,
      this.tag});

  List<int> get getRapList {
    List<int> rapList = [];
    int time = 0;
    for (int index = 0; index < workoutList.length; index++) {
      if (workoutList[index].showTimer == true) {
        time = workoutList[index].duration ?? 30;
      } else {
        if (workoutType == WorkoutType.beginner) {
          time = workoutList[index].beginnerRap ?? 8;
        } else if (workoutType == WorkoutType.intermediate) {
          time = workoutList[index].intermediateRap ?? 10;
        } else if (workoutType == WorkoutType.advance) {
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

  String get getWorkoutType =>
      workoutType.name.substring(0, 1).toUpperCase() +
      workoutType.name.substring(1, workoutType.name.length);
}
