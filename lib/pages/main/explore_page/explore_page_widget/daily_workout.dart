import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../database/explore_page_workout/fast_workout_database.dart';
import 'picks_for_you_workout.dart';

class DailyWorkoutWeekly extends StatelessWidget {
  const DailyWorkoutWeekly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text("Daily Workout",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,letterSpacing: 1.2),),
          ),

          SizedBox(height: 8,),
          CarouselSlider(
            items: fastWorkoutList.map((e) {
              return
                  Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        child: Stack(
                          children: [
                            Image.asset(e.imgSrc,fit: BoxFit.fill,height: double.infinity,),
                            Positioned(
                                bottom: 0,
                                child:
                                Container(
                                  child:Row(
                                    children: [
                                      Padding(
                                        padding:EdgeInsets.all(8),
                                          child: Text("  Monday Workout",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),)),
                                    ],
                                  ) ,
                                  decoration: BoxDecoration(
                                      color: Colors.black45
                                  ),
                                ))
                          ],
                        )),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),

              );
            }).toList(),
            options: CarouselOptions(
              height: 180,
              viewportFraction: 0.7,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            )),
        ],
      );
  }
}
