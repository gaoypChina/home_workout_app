import 'package:flutter/material.dart';

import 'package:full_workout/database/workout_list.dart';

import '../../main.dart';

class DetailPage extends StatelessWidget {
  final Workout workout;
  final int rapCount;

  DetailPage({@required this.workout, @required this.rapCount});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    getTopBar() {
      return Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              label: Text(""),
            ),
            ElevatedButton.icon(
                onPressed: () {},
              style: ElevatedButton.styleFrom(primary: Colors.white,padding: EdgeInsets.all(0)),
                icon: Icon(Icons.videocam,color: Colors.blue,),
                label:   Text("Video",style: textTheme.button.copyWith(color: Colors.blue,),),
            )
          ],
        ),
      );
    }

    getImage(Workout workout, double height, double width) {
      return Container(
        height: height * .35,
        decoration: BoxDecoration(
          color: Colors.white,
            border: Border.all(
              color: Colors.red[500],
            ),
            borderRadius: BorderRadius.all(Radius.circular(12))        ),
        width: width,
        margin: EdgeInsets.all(8),
        child: Image.asset(
          workout.imageSrc,
          fit: BoxFit.scaleDown,
        ),
      );
    }

    getTitle(Workout workout){
      String rap = workout.showTimer == true ? "${rapCount}s": "X $rapCount";
     return Container(
        height: 50,
        child: Row(
          children: [
            Text("${workout.title} $rap",style: textTheme.bodyText1.copyWith(fontSize: 22,fontWeight: FontWeight.w600,color: Colors.white),),
          ],
        ),
      );
    }

    getSteps(Workout workout){
      return Expanded(child: ListView.builder(itemBuilder: (BuildContext context, int index){
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: RichText(
            text:TextSpan(
              children: [
                TextSpan(text: "Step ${index + 1}: ",style: textTheme.bodyText2.copyWith(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w700),),

                TextSpan(text: "${workout.steps[index]}",style: textTheme.bodyText2.copyWith(color: Colors.white,fontSize: 14),)
        ]
            )
        ));
      },itemCount: workout.steps.length,));
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Container(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                getTopBar(),
                getImage(workout, height, width),
                getTitle(workout),
                getSteps(workout)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
