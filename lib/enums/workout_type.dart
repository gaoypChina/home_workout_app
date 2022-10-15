enum WorkoutType {
  Beginner,
  Intermediate,
  Advance,
  None
}
WorkoutType workoutTypeFromInt(int value){
  if(value == 0){
    return WorkoutType.Beginner;
  }else if(value == 1){
    return WorkoutType.Intermediate;
  }else if(value == 2){
    return WorkoutType.Advance;
  }else{
    return WorkoutType.Beginner;
  }

}