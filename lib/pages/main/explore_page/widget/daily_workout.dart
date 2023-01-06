import 'package:full_workout/pages/main/explore_page/widget/workout_header.dart';

import '../../../../constants/constant.dart';
import '../../../../database/explore_page_workout/weekday_workout.dart';
import '../../../../models/daily_workout_model.dart';
import 'package:flutter/material.dart';

import '../workout_setup_page/workout_setup_page.dart';

class DailyWorkout extends StatefulWidget {
  const DailyWorkout({
    Key? key,
  }) : super(key: key);

  @override
  State<DailyWorkout> createState() => _DailyWorkoutState();
}

class _DailyWorkoutState extends State<DailyWorkout> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).textTheme.bodyText1!.color == Colors.white;

    int todayIdx = DateTime.now().weekday -1;
    List<DailyWorkoutModel> workoutList = [
      DailyWorkoutModel(
          workout: weekdayWorkoutList[0],
          imgSrc: weekdayWorkoutList[0].imgSrc,
          index: 1,
          dayName: "Monday"),
      DailyWorkoutModel(
          workout: weekdayWorkoutList[1],
          imgSrc: weekdayWorkoutList[1].imgSrc,
          index: 2,
          dayName: "Tuesday"),
      DailyWorkoutModel(
          workout: weekdayWorkoutList[2],
          imgSrc: weekdayWorkoutList[2].imgSrc,
          index: 3,
          dayName: "Wednesday"),
      DailyWorkoutModel(
          workout: weekdayWorkoutList[3],
          imgSrc: weekdayWorkoutList[3].imgSrc,
          index: 4,
          dayName: "Thursday"),
      DailyWorkoutModel(
          workout: weekdayWorkoutList[4],
          imgSrc: weekdayWorkoutList[4].imgSrc,
          index: 5,
          dayName: "Friday"),
      DailyWorkoutModel(
          workout: weekdayWorkoutList[5],
          imgSrc: weekdayWorkoutList[5].imgSrc,
          index: 6,
          dayName: "Saturday"),
      DailyWorkoutModel(
          workout: weekdayWorkoutList[6],
          imgSrc: weekdayWorkoutList[6].imgSrc,
          index: 7,
          dayName: "Sunday"),
    ];
    buildDetail({required IconData icon, required String title}) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            size: 18,
            icon,
            color: isDark
                ? Colors.white.withOpacity(.9)
                : Colors.black.withOpacity(.7),
          ),
          SizedBox(
            width: 12,
          ),
          Text(title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isDark
                    ? Colors.white.withOpacity(.9)
                    : Colors.black.withOpacity(.7),
              ))
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (builder) =>WorkoutSetupPage(workout: workoutList[todayIdx].workout, header:  ExploreWorkoutHeader(
                    imgSrc: workoutList[todayIdx].imgSrc,
                    title: "${workoutList[todayIdx].dayName} Workout",
                    workoutType: weekdayWorkoutList[todayIdx].workoutType)))),
            child: Stack(
              children: [
                SizedBox(
                  height: 180 + 12 + 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Daily Workout Challenge",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.2),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          color: Colors.blue.withOpacity(isDark ? .2 : .5),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${workoutList[todayIdx ].dayName} Workout",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                ?.color!
                                                .withOpacity(.9)),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      buildDetail(
                                          icon: Icons.fitness_center_outlined,
                                          title: "${workoutList[todayIdx ]
                                              .workout
                                              .workoutList
                                              .length} Exercise"),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      buildDetail(
                                          icon: Icons.access_alarms_rounded,
                                          title: "${workoutList[todayIdx ]
                                              .workout
                                              .getTime} Minute"),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Let's Start",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.5,
                                              color: isDark
                                                  ? Colors.white.withOpacity(.9)
                                                  : Colors.black
                                                  .withOpacity(.7),
                                            ),
                                          ),
                                          Icon(
                                            Icons.navigate_next,
                                            color: isDark
                                                ? Colors.white.withOpacity(.9)
                                                : Colors.black.withOpacity(.7),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(child: Container()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 20,
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(24),
                          bottomRight: Radius.circular(24)),
                      child: Image.asset(
                        'assets/other/bg_partten.png',
                        color: isDark
                            ? Colors.white.withOpacity(.2)
                            : Colors.black.withOpacity(.4),
                        fit: BoxFit.fill,
                        height: 140,
                      )),
                ),
                Positioned(
                  right: 10,
                  top: 0,
                  bottom: 0,
                  child: Image.asset("assets/other/daily_workout_cover.png"),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
