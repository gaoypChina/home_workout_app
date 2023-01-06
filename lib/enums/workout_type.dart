enum WorkoutType {
  beginner,
  intermediate,
  advance,
  none
}
WorkoutType workoutTypeFromInt(int value){
  if(value == 0){
    return WorkoutType.beginner;
  }else if(value == 1){
    return WorkoutType.intermediate;
  }else if(value == 2){
    return WorkoutType.advance;
  }else{
    return WorkoutType.beginner;
  }

}