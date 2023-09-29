import 'package:flutter/material.dart';

import '../../../../enums/workout_type.dart';
import '../../../../models/explore_workout_model.dart';
import '../widget/body_focus_workout.dart';
import '../widget/workout_header.dart';
import '../workout_setup_page/workout_setup_page.dart';

class BodyFocusWorkoutPage extends StatelessWidget {
  final BodyFocusWorkoutModel workoutModel;

  BodyFocusWorkoutPage({required this.workoutModel});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).textTheme.bodyLarge!.color == Colors.white;

    Color  tileColor({required WorkoutType workoutType}) {
      Color titleColor;
      if (workoutType == WorkoutType.beginner) {
        titleColor = Colors.green;
      } else if (workoutType == WorkoutType.intermediate) {
        titleColor = Colors.orange;
      } else {
        titleColor = Colors.red;
      }
      return titleColor;
    }
    
    buildCard({required ExploreWorkout workout}) {
      return Column(
        children: [
          ListTile(
            title: Text(
              workout.title,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (builder) {
              return WorkoutSetupPage(
              workout: workout,
              header: ExploreWorkoutHeader(
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
                  color:
                      Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.4),
                ),
                SizedBox(
                  width: 6,
                ),
                Text(workout.getExerciseCount)
              ],
            ),
              trailing: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                      color: tileColor(workoutType: workout.workoutType).withOpacity(.1),
                      borderRadius:
                      BorderRadius.all(Radius.circular(18))),
                  child: Text(
                    workout.getWorkoutType,
                    style: TextStyle(fontSize: 14.5),
                  )),
            leading: CircleAvatar(child: Text(workout.title[0],style: TextStyle(color: Colors.white)),backgroundColor: tileColor(workoutType: workout.workoutType),)
          ),
          Container(height: 1, color: Colors.grey.withOpacity(.1),)
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(workoutModel.title),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [

            SizedBox(height: 12,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),

              child: Stack(
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.blue,
                        gradient: LinearGradient(colors: [
                          workoutModel.color.withOpacity(isDark ? .2 : .6),
                          workoutModel.color.withOpacity(isDark ? .3 : .8),
                        ])),
                    padding: EdgeInsets.only(bottom: 18, left: 18, right: 18),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        workoutModel.title,
                        style: TextStyle(
                            color: Colors.white, fontSize: 24, letterSpacing: 1.2),
                      ),
                    ),
                  ),
                  Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                          padding: EdgeInsets.only(left: 18, bottom: 8, top: 8, right: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30),
                                  topLeft: Radius.circular(18)),
                              color: workoutModel.color.withOpacity(isDark ? .1 : .5)),
                          height: 150,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Image.asset(
                              workoutModel.imgSrc,
                            ),
                          ))),
                ],
              ),
            ),

            SizedBox(height: 10,),



            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: workoutModel.description.map((detail) =>   Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(detail,
                      style: TextStyle(fontSize: 15,color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.7)),textAlign: TextAlign.justify,),
                  )).toList()
                )
                ),


 Container(height: 16, color: Colors.grey.withOpacity(.15),),

            ...workoutModel.workoutList
                .map((workout) => buildCard(workout: workout))
                .toList()
          ],
        ),
      ),
    );
  }
}

