import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_workout/models/main_page_item.dart';
import 'package:full_workout/pages/main/report_page/workout_report/workout_detail_report.dart';
import 'package:full_workout/widgets/achivement.dart';
import 'package:full_workout/widgets/active_goal.dart';
import 'package:full_workout/widgets/workout_card.dart';

import '../../../widgets/dialogs/exit_app_dialog.dart';
import 'leading_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    getTitle(String title) {
      return Container(
        padding: EdgeInsets.only(left: 12, top: 22, bottom: 10),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  color:Theme.of(context).primaryColor.withOpacity(.8)),
              height: 18,
              width: 6,
            ),
            SizedBox(width: 8,),
            Text(title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.8),
                  letterSpacing: 1.4,
                )),
          ],
        ),
      );
    }

    bool isDark = Theme.of(context).textTheme.bodyText1!.color == Colors.white;
    var size = MediaQuery.of(context).size;

    _buildExercise({required String title, required String subtitle}) {
      return Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                subtitle,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
              ),
              Text(
                title,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ],
          ));
    }


    return WillPopScope(
        onWillPop: ()=>exitAppDialog(context: context),
        child: Scaffold(
            backgroundColor:isDark?Colors.blueGrey.shade300.withOpacity(.05): Colors.blueGrey.shade300.withOpacity(.1),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: getLeading(context),
              elevation: .4,
              title: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Home ".toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                        color: Theme.of(context).primaryColor,
                        fontSize: 18)),
                    TextSpan(
                        text: "Workout".toUpperCase(),
                        style: TextStyle(
                            letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        fontSize: 18))
                  ])),
            ),
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: [


                // Achievement(
                //   onTap: () => Navigator.pushNamed(
                //       context, WorkoutDetailReport.routeName),
                // ),

                SizedBox(
                  height: 18,
                ),
                ActiveGoal(),
            
                getTitle(exerciseName[0]),
                for (int i = 0; i < 3; i++)
                  WorkoutCard(
                    title: chestExercise[i].title,
                    workoutList: chestExercise[i].workoutList,
                    tagValue: i,
                    imaUrl: chestExercise[i].imageUrl,
                    tag: chestExercise[i].title,
                    index: 1,
                  ),

                getTitle(exerciseName[1]),
                for (int i = 0; i < 3; i++)

                  WorkoutCard(
                    title: shoulderExercise[i].title,
                    workoutList: shoulderExercise[i].workoutList,
                    tagValue: i,
                    imaUrl: shoulderExercise[i].imageUrl,
                    tag: shoulderExercise[i].title,
                    index: 0,
                  ),


                getTitle(exerciseName[2]),
                for (int i = 0; i < 3; i++)

                  WorkoutCard(
                    title: absExercise[i].title,
                    workoutList: absExercise[i].workoutList,
                    tagValue: i,
                    imaUrl: absExercise[i].imageUrl,
                    tag: absExercise[i].title,
                    index: 0,
                  ),

                getTitle(exerciseName[3]),
                for (int i = 0; i < 3; i++)

                  WorkoutCard(
                    title: legsExercise[i].title,
                    workoutList: legsExercise[i].workoutList,
                    tagValue: i,
                    imaUrl: legsExercise[i].imageUrl,
                    tag: legsExercise[i].title,
                    index: 1,
                  ),

                getTitle(exerciseName[4]),
                for (int i = 0; i < 3; i++)

                  WorkoutCard(
                    title: armsExercise[i].title,
                    workoutList: armsExercise[i].workoutList,
                    tagValue: i,
                    imaUrl: armsExercise[i].imageUrl,
                    tag: armsExercise[i].title,
                    index: 0,
                  ),

                SizedBox(height:20),


              ],
            )));
  }
}
