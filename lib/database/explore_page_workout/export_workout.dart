import 'package:full_workout/database/explore_page_workout/weekday_workout.dart';
import 'package:full_workout/enums/workout_type.dart';

import '../../database/explore_page_workout/beginner_workout.dart';
import '../../database/explore_page_workout/fast_workout_database.dart';
import '../../database/explore_page_workout/picked_workout_database.dart';
import '../../database/explore_page_workout/stretch_workout.dart';
import '../../models/explore_workout_model.dart';
import '../../models/main_page_item.dart';
import 'discover_workout.dart';

class ExportWorkout{
  List<ExploreWorkout> get allExploreWorkout => _allExploreWorkout;


  List<ExploreWorkout> get chestWorkoutList => _chestWorkoutList;
  List<ExploreWorkout> get armsAndShoulderWorkoutList => _armsAndShoulderWorkoutList;
  List<ExploreWorkout> get buttAndLesWorkoutList => _buttAndLesWorkoutList;
  List<ExploreWorkout> get sixPackAbsWorkoutList => _sixPackAbsWorkoutList;


  List<ExploreWorkout> _allExploreWorkout = [
    ...pickedWorkoutList,
    ...weekdayWorkoutList,
    ...beginnerWorkoutList,
    ...discoverWorkoutList,
    ...stretchWorkoutList,
    ...fastWorkoutList,
    for (int i = 0; i < 3; i++)
      ExploreWorkout(
          title: chestExercise[i].title,
          workoutList: chestExercise[i].workoutList,
          workoutType: workoutTypeFromInt(i),
          imgSrc: chestExercise[i].imageUrl,
          description: []),
    for (int i = 0; i < 3; i++)
      ExploreWorkout(
          title: shoulderExercise[i].title,
          workoutList: shoulderExercise[i].workoutList,
          workoutType: workoutTypeFromInt(i),
          imgSrc: shoulderExercise[i].imageUrl,
          description: []),
    for (int i = 0; i < 3; i++)
      ExploreWorkout(
          title: absExercise[i].title,
          workoutList: absExercise[i].workoutList,
          workoutType: workoutTypeFromInt(i),
          imgSrc: absExercise[i].imageUrl,
          description: []),
    for (int i = 0; i < 3; i++)
      ExploreWorkout(
          title: legsExercise[i].title,
          workoutList: legsExercise[i].workoutList,
          workoutType: workoutTypeFromInt(i),
          imgSrc: legsExercise[i].imageUrl,
          description: []),
    for (int i = 0; i < 3; i++)
      ExploreWorkout(
          title: armsExercise[i].title,
          workoutList: armsExercise[i].workoutList,
          workoutType: workoutTypeFromInt(i),
          imgSrc: armsExercise[i].imageUrl,
          description: []),
  ];

  List<ExploreWorkout> _chestWorkoutList = [
    robustChestBeginner,
    manBoobs,
    upperBodyStretching,
  ];
  List<ExploreWorkout> _armsAndShoulderWorkoutList = [
    armWorkout,
    tricepsSmasher,
    shoulderAndNeckStretching,
    widerShoulder,
  ];
  List<ExploreWorkout> _buttAndLesWorkoutList = [
    legWorkout,
    lightCardio,
    lowerBodyStretching
  ];
  List<ExploreWorkout> _sixPackAbsWorkoutList = [
    bellyFatBurner,
    toneAbs,
    insaneAbs,
    absMaker,
    absPower,
    looseBellyFat,
    absWorkout,
  ];

 List<ExploreWorkout> allWork = [ ...pickedWorkoutList,
  ...weekdayWorkoutList,
  ...beginnerWorkoutList,
  ...discoverWorkoutList,
  ...stretchWorkoutList,
  ...fastWorkoutList,];

}
