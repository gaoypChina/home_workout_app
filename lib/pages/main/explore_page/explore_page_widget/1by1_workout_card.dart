import 'package:flutter/material.dart';

import '../../../../database/explore_page_workout/picked_workout_database.dart';
import '../../../../models/explore_workout_model.dart';
import '../../../../widgets/prime_icon.dart';
import '../workout_setup_page/workout_setup_page.dart';

class HardCoreWorkout extends StatelessWidget {
  const HardCoreWorkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              "Extreme Workout",
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
                ...pickedWorkoutList.map((ExploreWorkout workout) {
                  return Padding(
                    padding: EdgeInsets.only(right: 18),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (builder) {
                          return WorkoutSetupPage(
                            workout: workout,
                            header: Stack(
                              children: [
                                Image.asset(workout.imgSrc),
                                Positioned(right: 8, top: 4, child: PrimeIcon())
                              ],
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
                                fontSize: 16,
                                letterSpacing: 0.4,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!
                                    .withOpacity(.8)),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              Text(
                                "30 Sec",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
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
                                        .bodyText1!
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
