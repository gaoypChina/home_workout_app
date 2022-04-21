import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_workout/constants/constant.dart';
import 'package:full_workout/models/main_page_item.dart';
import 'package:full_workout/pages/main/report_page/workout_report/workout_detail_report.dart';
import 'package:full_workout/widgets/achivement.dart';
import 'package:full_workout/widgets/active_goal.dart';
import 'package:full_workout/widgets/workout_card.dart';

import 'leading_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() async{
      bool value = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),

              title: Text("Do you really want to exit the app?",
                style: TextStyle(fontSize: 18, letterSpacing: 1.5),),
              actions: [

                TextButton(
                  child: const Text("No"),

                  onPressed: () => Navigator.pop(context, false),
                ),
                TextButton(
                  child: const Text("Yes"),

                  onPressed: () => Navigator.pop(context, true),
                ),

              ],
            );
          }) ??
          false;

      if (value) {
        SystemNavigator.pop();
        return true;
      } else {
        return false;
      }
    }

    getTitle(String title) {
      return Container(
        padding: EdgeInsets.only(left: 12, top: 22, bottom: 10),
        child: Row(
          children: [
            Container(
       decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      gradient: LinearGradient(colors:[Colors.blue.shade700.withOpacity(.9), Colors.red.withOpacity(.9)], begin: Alignment.topRight, end: Alignment.bottomLeft)),

              height: 18,width: 6,),
            SizedBox(width: 8,),
            Text(title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  letterSpacing: 1.4,
                )),
          ],
        ),
      );
    }

    buildBanner(){
      return  Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        padding: EdgeInsets.symmetric(horizontal: 18,vertical: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: Colors.red.withOpacity(.15),),
        child: Stack(
          children: [
            Positioned(
              right: 0,
                top: 0,
                child: Container(

                  height: 35,
                  width: 35,

                  decoration: BoxDecoration(shape: BoxShape.circle,  color: Colors.green),
                  child: Icon(Icons.backup_outlined,color: Colors.white,),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12,),
                Text("Tack Backup or restore",style: TextStyle(fontSize: 20,letterSpacing: 1.2),),
                SizedBox(height: 12,),
                Text("Tacking backup prevent your device data from get erased, also you can refer this data in future.",style: TextStyle(letterSpacing:1.5),),
                Row(
                  children: [
                    Spacer(),
                    TextButton(onPressed: (){}, child: Text("Later")),
                    SizedBox(width: 0,),
                    TextButton(onPressed: (){}, child: Text("Backup")),
                    SizedBox(width: 4,),
                    TextButton(onPressed: (){}, child: Text("Restore"))
                  ],

                )
              ],
            ),
          ],
        ),
      );
    }


    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          backgroundColor: Theme.of(context).bottomAppBarColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: getLeading(context),
              elevation: .4,
              title: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Home ".toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        fontSize: 18)),
                TextSpan(
                    text: "Workout".toUpperCase(),
                    style: TextStyle(
                        letterSpacing: 1,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).primaryColor,
                        fontSize: 18))
              ])),
            ),
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                // SizedBox(
                //   height: 10,
                // ),
                // buildBanner(),
                SizedBox(
                  height: 16,
                ),
                Achievement(
                  onTap: () => Navigator.pushNamed(
                      context, WorkoutDetailReport.routeName),
                ),
                SizedBox(
                  height: 20,
                ),
                ActiveGoal(),
                SizedBox(height: 2,),
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
