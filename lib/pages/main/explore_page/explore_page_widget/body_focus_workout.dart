import 'package:flutter/material.dart';

import '../../../../database/explore_page_workout/export_workout.dart';
import '../../../../enums/workout_type.dart';
import '../../../../models/begginer_workout_model.dart';
import '../../../../models/explore_workout_model.dart';
import '../body_focus_workout_page/body_focus_workout_page.dart';

class BodyFocusWorkout extends StatelessWidget {
  const BodyFocusWorkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BeginnerWorkoutModel> _challenges = [
      BeginnerWorkoutModel(
          workoutType: WorkoutType.Beginner,
          workoutList: [],
          description: [],
          title: "4 Day Challenge",
          imgSrc: "assets/icons/push-up.png",
          color: Colors.blueGrey),
      BeginnerWorkoutModel(
          workoutType: WorkoutType.Beginner,
          workoutList: [],
          description: [],
          title: "Plack Challenge",
          imgSrc: "assets/icons/exercises.png",
          color: Colors.redAccent),
      BeginnerWorkoutModel(
          workoutType: WorkoutType.Beginner,
          workoutList: [],
          description: [],
          title: "Push-up Challenge",
          imgSrc: "assets/icons/lunges.png",
          color: Colors.teal),
      BeginnerWorkoutModel(
          workoutType: WorkoutType.Beginner,
          workoutList: [],
          description: [],
          title: "Full Body Challenge",
          imgSrc: "assets/icons/fitness.png",
          color: Colors.pinkAccent),
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Text(
          "Body Focus Workout",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.2),
        ),
      ),
      SizedBox(
        height: 8,
      ),
      GridView.count(
        physics: BouncingScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 9 / 8,
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 12.0, right: 12),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        children: [
          ..._challenges.map((e) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (builder) {
                        return BodyFocusWorkoutPage(
                          title: "Body Focus Workout",
                          imgSrc: "assets/home_cover/1.jpg",
                          workoutList: bodyFocusList,
                        );
                      }));
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              gradient: LinearGradient(
                                  colors: [
                                    e.color.withOpacity(.6),
                                    e.color.withOpacity(.8),
                                  ],
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  tileMode: TileMode.mirror)),
                          padding:
                              EdgeInsets.only(bottom: 12, left: 8, right: 8),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              e.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 1.2),
                            ),
                          ),
                        ),
                        Positioned(
                            right: 0,
                            child: Container(
                                padding: EdgeInsets.only(
                                    left: 18, bottom: 8, top: 8, right: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(0)),
                                    color: e.color.withOpacity(.8)),
                                height: 70,
                                child: Image.asset(
                                  e.imgSrc,
                                )))
                      ],
                    ),
                  ),
                ),
              ))
        ],
      )
    ]);
  }
}
