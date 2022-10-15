import 'package:flutter/material.dart';
import 'package:full_workout/pages/main/explore_page/widget/workout_header.dart';

import '../../../../database/explore_page_workout/stretch_workout.dart';
import '../workout_setup_page/workout_setup_page.dart';

class StretchWorkout extends StatelessWidget {
  const StretchWorkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            "Stretching Workout",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.2),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 150,
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(
                width: 10,
              ),
              ...stretchWorkoutList.map((workout) => Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (builder) => WorkoutSetupPage(
                                    workout: workout,
                                    header: ExploreWorkoutHeader(
                                      title: workout.title,
                                      imgSrc: workout.imgSrc,
                                      workoutType: workout.workoutType,
                                    )))),
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue,
                                    gradient: LinearGradient(
                                        colors: [
                                          workout.color.withOpacity(.66),
                                          workout.color.withOpacity(.88),
                                        ],
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft)),
                                height: 150,
                                width: 150,
                                padding: EdgeInsets.only(
                                    bottom: 12, left: 10, right: 10),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    workout.title,
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
                                          left: 18,
                                          bottom: 8,
                                          top: 8,
                                          right: 8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(30),
                                            topRight: Radius.circular(10),
                                          ),
                                          color: workout.color.withOpacity(.3)),
                                      height: 70,
                                      child: Image.asset(
                                        workout.imgSrc,
                                      )))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
