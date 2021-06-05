import 'package:flutter/cupertino.dart';

class WorkOutModel {
  double caleries;
  double numberOfExercise;
  double duration;
  String imageSource;
  WorkOutModel({
    @required this.caleries,
    @required this.duration,
    @required this.numberOfExercise,
    @required this.imageSource
  });
}

WorkOutModel chestBeginnerModel = WorkOutModel(
  caleries: 12,
  duration: 12,
  numberOfExercise: 18,
);
