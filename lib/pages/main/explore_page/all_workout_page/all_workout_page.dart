import 'package:flutter/material.dart';
import '../../../../pages/main/explore_page/explore_page_widget/workout_header.dart';
import '../../../../pages/main/explore_page/workout_setup_page/workout_setup_page.dart';

import '../../../../database/explore_page_workout/export_workout.dart';
import '../../../../enums/workout_type.dart';

class AllWorkoutPage extends StatelessWidget {
  const AllWorkoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getTileColor({required WorkoutType workoutType}) {
      Color titleColor;
      if (workoutType == WorkoutType.Beginner) {
        titleColor = Colors.green;
      } else if (workoutType == WorkoutType.Intermediate) {
        titleColor = Colors.orange;
      } else {
        titleColor = Colors.red;
      }
      return titleColor;
    }

    getHeader(
        {required WorkoutType workoutType,
        required String imgSrc,
        required String title}) {
      if (imgSrc.contains("icons")) {
        return AnimatedWorkoutHeader(
            imgSrc: imgSrc,
            color: getTileColor(workoutType: workoutType),
            title: title);
      } else {
        return WorkoutHeader(imgSrc: imgSrc);
      }
    }

    return Scaffold(
        appBar: AppBar(title: Text("All Workout")),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(children: [
            ...allExploreWorkout.map((workout) => Column(
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
                            header: getHeader(
                                imgSrc: workout.imgSrc,
                                workoutType: workout.workoutType,
                                title: workout.title),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.blueGrey.withOpacity(.8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18))),
                          child: Text(
                            workout.getWorkoutType,
                            style: TextStyle(color: Colors.white),
                          )),
                      leading: CircleAvatar(
                        backgroundColor:
                            getTileColor(workoutType: workout.workoutType),
                        child: Text(
                          workout.title[0],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Colors.blueGrey.withOpacity(.05),
                    )
                  ],
                )),
          ]),
        ));
  }
}
