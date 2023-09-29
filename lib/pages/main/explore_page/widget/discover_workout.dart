import 'package:flutter/material.dart';
import 'package:full_workout/pages/main/explore_page/widget/workout_header.dart';

import '../../../../database/explore_page_workout/discover_workout.dart';
import '../../../../models/explore_workout_model.dart';
import '../workout_setup_page/workout_setup_page.dart';

class DiscoverWorkout extends StatelessWidget {
  const DiscoverWorkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              "Discover Workout",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2),
            )),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 200,
          child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(
                  width: 12,
                ),
                ...discoverWorkoutList.map((ExploreWorkout workout) {
                  return Padding(
                    padding: EdgeInsets.only(right: 18),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (builder) {
                          return WorkoutSetupPage(
                            workout: workout,
                            header:  ExploreWorkoutHeader(
                              workoutType: workout.workoutType,title: workout.title,imgSrc: workout.imgSrc,
                            ),
                          );
                        }));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                child: Image.asset(
                                  workout.imgSrc,
                                  width: width * .68,
                                  fit: BoxFit.fill,
                                )),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            workout.title,
                            style: TextStyle(
                                fontSize: 16,fontWeight: FontWeight.w500,
                                letterSpacing: 0.4,

                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color!
                                    .withOpacity(.8)),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              Text(
                                workout.getTime.toString() +" Min",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(.8)),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.circle,
                                size: 6,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                workout.getWorkoutType,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(.8)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ]),
        ),
      ],
    );
  }
}
