

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../database/explore_page_workout/fast_workout_database.dart';

class DailyWorkoutPage extends StatefulWidget {
  const DailyWorkoutPage({Key? key}) : super(key: key);

  @override
  State<DailyWorkoutPage> createState() => _DailyWorkoutPageState();
}

class _DailyWorkoutPageState extends State<DailyWorkoutPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 20,),
            CarouselSlider(
                items: fastWorkoutList.map((e) {
                  return Container(
                    width: MediaQuery.of(context).size.width*.75,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              e.imgSrc,
                              fit: BoxFit.fill,
                              height: double.infinity,
                            ),
                            Positioned(
                                bottom: 0,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                            "  Monday Workout",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          )),
                                    ],
                                  ),
                                  decoration: BoxDecoration(color: Colors.black45),
                                ))
                          ],
                        )),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 160,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: false,
                  scrollDirection: Axis.horizontal,
                )),
          ],),
        ),
      ),
    );
  }
}
