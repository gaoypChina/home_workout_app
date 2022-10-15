import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../database/explore_page_workout/weekday_workout.dart';
import '../../../../models/daily_workout_model.dart';
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

    int todayIdx = DateTime.now().weekday;
    List<DailyWorkoutModel> workoutList = [
      DailyWorkoutModel(
          workout: weekdayWorkoutList[0],
          imgSrc: "assets/explore_image/img_8.jpg",
          index: 1,
          dayName: "Monday"),
      DailyWorkoutModel(
          workout: weekdayWorkoutList[1],
          imgSrc: "assets/explore_image/img_9.jpg",
          index: 2,
          dayName: "Tuesday"),
      DailyWorkoutModel(
          workout: weekdayWorkoutList[2],
          imgSrc: "assets/explore_image/img_10.jpg",
          index: 3,
          dayName: "Wednesday"),
      DailyWorkoutModel(
          workout: weekdayWorkoutList[3],
          imgSrc: "assets/explore_image/img_18.jpg",
          index: 4,
          dayName: "Thursday"),
      DailyWorkoutModel(
          workout: weekdayWorkoutList[4],
          imgSrc: "assets/explore_image/img_19.jpg",
          index: 5,
          dayName: "Friday"),
      DailyWorkoutModel(
          workout: weekdayWorkoutList[5],
          imgSrc: "assets/explore_image/img_20.jpg",
          index: 6,
          dayName: "Saturday"),
      DailyWorkoutModel(
          workout: weekdayWorkoutList[6],
          imgSrc: "assets/explore_image/img_8.jpg",
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
                builder: (builder) => WorkoutSetupPage(
                      workout: workoutList[todayIdx - 1].workout,
                      header: CarouselSlider(
                          items: workoutList.map((workout) {
                            return Container(
                              width: MediaQuery.of(context).size.width * .75,
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18)),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.asset(
                                        workout.imgSrc,
                                        fit: BoxFit.fill,
                                        height: double.infinity,
                                      ),
                                      if (workout.index != todayIdx)
                                        Container(
                                          color: Colors.black.withOpacity(.7),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.lock_outlined,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                " You can view ${workoutList[todayIdx - 1].dayName} Workout challenge only ",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    backgroundColor: Colors
                                                        .amber
                                                        .withOpacity(.1)),
                                              )
                                            ],
                                          ),
                                        ),
                                      Positioned(
                                          bottom: 0,
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.all(8),
                                                    child: Text(
                                                      "  ${workout.dayName} Workout",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.black45),
                                          ))
                                    ],
                                  )),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                              ),
                            );
                          }).toList(),
                          options: CarouselOptions(
                            height: 160,
                            viewportFraction: 0.8,
                            initialPage: todayIdx - 1,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: false,
                            scrollDirection: Axis.horizontal,
                          )),
                    ))),
            child: Stack(
              children: [
                Container(
                  height: 180 + 12 + 22,
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
                                        "${workoutList[todayIdx - 1].dayName} Workout",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                ?.color!.withOpacity(.9)),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      buildDetail(
                                        icon: Icons.fitness_center_outlined,
                                        title: workoutList[todayIdx - 1].workout.workoutList.length.toString()+" Exercise"),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      buildDetail(
                                          icon: Icons.access_alarms_rounded,
                                          title:
                                          workoutList[todayIdx - 1].workout.getTime.toString()+" Minute"),
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
                                                color:isDark? Colors.white.withOpacity(.9): Colors.black.withOpacity(.7),),
                                          ),
                                          Icon(
                                            Icons.navigate_next,
                                            color:isDark? Colors.white.withOpacity(.9): Colors.black.withOpacity(.7),
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
                        color:isDark? Colors.white.withOpacity(.2): Colors.black.withOpacity(.4),
                        fit: BoxFit.fill,
                        height: 140,
                      )),
                ),
                Positioned(
                  right: 10,
                  top: 0,
                  bottom: 0,
                  child: Container(
                      child:
                          Image.asset("assets/other/daily_workout_cover.png")),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
