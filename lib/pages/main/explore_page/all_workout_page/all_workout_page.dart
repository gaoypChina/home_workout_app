import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../database/explore_page_workout/export_workout.dart';
import '../../../../enums/workout_type.dart';
import '../../../../models/explore_workout_model.dart';
import '../../../../pages/main/explore_page/workout_setup_page/workout_setup_page.dart';
import '../widget/workout_header.dart';

class AllWorkoutPage extends StatefulWidget {
  const AllWorkoutPage({Key? key}) : super(key: key);

  @override
  State<AllWorkoutPage> createState() => _AllWorkoutPageState();
}

class _AllWorkoutPageState extends State<AllWorkoutPage> {
  List<ExploreWorkout> workoutList = [];

  @override
  void initState() {
    sortList();

    super.initState();
  }

  sortList() async{
   await Future.delayed(Duration(seconds: 0));
    workoutList = ExportWorkout().allExploreWorkout
      ..sort((a, b) => a.title.compareTo(b.title))..shuffle(Random(101));
   setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Color tileColor({required WorkoutType workoutType}) {
      Color titleColor;
      if (workoutType == WorkoutType.beginner) {
        titleColor = Colors.green;
      } else if (workoutType == WorkoutType.intermediate) {
        titleColor = Colors.orange;
      } else if(workoutType == WorkoutType.advance){
        titleColor = Colors.red;
      }else{
        titleColor = Colors.amber;
      }
      return titleColor;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("All Workout"),
          elevation: .3,
        ),
        body: Scrollbar(
          child: ListView.builder(
            itemCount: workoutList.length,

            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index){
              var workout = workoutList[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      workout.title,
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (builder) {
                        return WorkoutSetupPage(
                          workout: workout,
                          header: ExploreWorkoutHeader(
                            imgSrc: workout.imgSrc,
                            title: workout.title,
                            workoutType: workout.workoutType,
                          ),
                        );
                      }));
                    },
                    subtitle: Row(
                      children: [
                        Text("${workout.getTime} Min"),
                        SizedBox(
                          width: 6,
                        ),
                        Icon(
                          Icons.circle,
                          size: 6,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(.4),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(workout.getExerciseCount)
                      ],
                    ),
                    trailing: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                            color:
                            tileColor(workoutType: workout.workoutType)
                                .withOpacity(.1),
                            borderRadius:
                            BorderRadius.all(Radius.circular(18))),
                        child: Text(
                          workout.getWorkoutType == "None" ?"Everyone" : workout.getWorkoutType  ,
                          style: TextStyle(fontSize: 14.5),
                        )),
                    leading: CircleAvatar(
                      backgroundColor:
                      tileColor(workoutType: workout.workoutType),
                      child: Text(
                        workout.title[0],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    // tileColor: tileColor(workoutType: workout.workoutType).withOpacity(.1),
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey.withOpacity(.1),
                  )
                ],
              );
            },
            ),

        ));
  }
}
