import 'package:flutter/material.dart';

import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/pages/services/youtube_player.dart';

import '../../main.dart';

class DetailPage extends StatelessWidget {
  final Workout workout;
  final int rapCount;

  DetailPage({@required this.workout, @required this.rapCount});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;


    getTopBar() {
      return Container(
        padding: EdgeInsets.only(top: 10),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context, true);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              label: Text(""),
            ),
            ElevatedButton.icon(
              onPressed: ()  {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          YoutubeTutorial(
                            rapCount:rapCount ,
                            workout: workout,
                          ),
                    ));
              },
              style: ElevatedButton.styleFrom(
                  primary:isDark?Colors.grey.shade200:Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 4)),
              icon: Icon(
                Icons.videocam,
                color: Colors.grey.shade800,
              ),
              label: Text(
                "Video",
                style: textTheme.button.copyWith(
                  color: Colors.grey.shade800,
                ),
              ),
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
              color: Colors.black,
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
        return
               ListTile(
                 minVerticalPadding: 0,
                  leading: Text("Step ${index + 1}: ",
                      style: textTheme.bodyText2.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                  title: Text(
                    "${workout.steps[index]}",
                    style: textTheme.bodyText2
                        .copyWith(color: Colors.white, fontSize: 14),
                  ));
        },itemCount: workout.steps.length,));
    }

    return Scaffold(

    backgroundColor:isDark?Colors.black: Colors.blue,
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
