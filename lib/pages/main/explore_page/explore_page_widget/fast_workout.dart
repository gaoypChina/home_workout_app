import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/database/explore_page_workout/fast_workout_database.dart';
import 'package:full_workout/pages/main/explore_page/explore_page_widget/workout_header.dart';

import '../../../../models/explore_workout_model.dart';
import '../../../../widgets/prime_icon.dart';
import '../workout_setup_page/workout_setup_page.dart';

class FastWorkout extends StatelessWidget {

  const FastWorkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            "Fast Workout",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 200,
          child: GridView.count(
              physics: BouncingScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1 / 3.3,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              children: fastWorkoutList.map((ExploreWorkout workout) {
                return InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) => WorkoutSetupPage(
                          workout: workout, header:
                          WorkoutHeader(imgSrc: workout.imgSrc),))),
                  child: Container(
                    //   color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex:3,
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                            child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                child: Image.asset(workout.imgSrc,height: 80,fit: BoxFit.fill,)),
                          ),
                        ),
                        SizedBox(width: 8,),
                        Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(),
                                Text(
                                  workout.title ,
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    Text( "${workout.getTime} Min"),
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
                                    Text(workout.getWorkoutType)
                                  ],
                                ),
                                Spacer(),
                                Container(height: 1,
                                  width: 180,
                                  color: Colors.grey.withOpacity(.3),),
                                SizedBox(height: 5,)
                              ],
                            )),

                      ],
                    ),
                  ),
                );
              }).toList()),
        ),
      ],
    );
  }
}

