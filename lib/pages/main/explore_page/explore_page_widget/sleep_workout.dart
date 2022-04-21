import 'package:flutter/material.dart';

class SleepWorkoutSection extends StatelessWidget {
  final String title;
  const SleepWorkoutSection({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SleepWorkoutModel> _workoutList = [
      SleepWorkoutModel(imgSrc: "assets/explore_image/img_1.jpg", title: "Full body stretching"),
      SleepWorkoutModel(imgSrc: "assets/explore_image/img_2.jpg", title: "Full body "),
      SleepWorkoutModel(imgSrc: "assets/explore_image/img_3.jpg", title: "Full body stretching"),
      SleepWorkoutModel(imgSrc: "assets/explore_image/img_4.jpg", title: "Full body stretching"),
      SleepWorkoutModel(imgSrc: "assets/explore_image/img_5.jpg", title: "Full body stretching"),
      SleepWorkoutModel(imgSrc: "assets/explore_image/img_6.jpg", title: "Full body stretching"),
      SleepWorkoutModel(imgSrc: "assets/explore_image/img_7.jpg", title: "Full body stretching"),
      SleepWorkoutModel(imgSrc: "assets/explore_image/img_8.jpg", title: "Full body stretching"),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,letterSpacing: 1.2),),
        SizedBox(height: 4,),
        Container(
          height: 300,

          color: Colors.white30,
          child: GridView.count(
              physics: BouncingScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 15/16,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.all(4.0),
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
              children:_workoutList.map((SleepWorkoutModel item) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 2,
                          child: Card(
                        elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),

                          child: ClipRRect(

                            borderRadius: BorderRadius.all(Radius.circular(8)),
                              child: Image.asset(item.imgSrc, fit: BoxFit.cover)))),

                      Expanded(child: Text(item.title,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,letterSpacing: 1.4),))
                    ],
                  ),
                );
              }).toList()),
        ),
      ],
    );
  }
}

class SleepWorkoutModel {
  final String title;
  final String imgSrc;

  SleepWorkoutModel({required this.imgSrc, required this.title});
}
