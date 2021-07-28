import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/models/main_page_item.dart';
import 'package:full_workout/widgets/achivement.dart';
import 'package:full_workout/widgets/active_goal.dart';
import 'package:full_workout/widgets/workout_card.dart';

import '../../../main.dart';
import 'leading_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();
    Future<bool> _onBackPressed() {
      return showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    title: new Text('Are you sure?'),
                    content: new Text('Do you want to exit Home Workout App'),
                    actions: <Widget>[
                      new TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),

              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
            ],
          ))??
          false;}
    getTitle(String title){
      return Container(
        padding: EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 4),
        child: Text(title.toUpperCase(),
            style: textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            )),
      );
    }

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          backgroundColor: Colors.white,

          body: NestedScrollView(

              physics: BouncingScrollPhysics(),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                    ),
                    actions: getLeading(context),
                    backgroundColor: constants.appBarColor,
                    automaticallyImplyLeading: false,
                    expandedHeight: 180.0,
                    title: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Home ",
                              style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20)),
                          TextSpan(
                              text: "Workout",
                              style: TextStyle(
                                  color: constants.appBarContentColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20))
                        ])),

                    pinned: true,
                    forceElevated: innerBoxIsScrolled,
                    flexibleSpace: FlexibleSpaceBar(collapseMode: CollapseMode.parallax,
                        background: Container(

                            padding: EdgeInsets.only(top: 90,bottom: 12),
                            child: Achievement()),



                    ),
                  ),
                ];
              },
              body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 8),
                physics: BouncingScrollPhysics(),
                children: [

                  ActiveGoal(),
                  getTitle(exerciseName[0]),
                  for (int i = 0; i < 3; i++)
                    WorkoutCard(
                      title: absExercise[i].title,
                      workoutList: absExercise[i].workoutList,
                      tagValue: i,
                      imaUrl: absExercise[i].imageUrl,
                      tag: absExercise[i].tag,
                    ),
                  getTitle(exerciseName[1]),
                  for (int i = 0; i < 3; i++)
                    WorkoutCard(
                      title: chestExercise[i].title,
                      workoutList: chestExercise[i].workoutList,
                      tagValue: i,
                      imaUrl: chestExercise[i].imageUrl,
                      tag: chestExercise[i].tag,
                    ),
                  getTitle(exerciseName[2]),
                  for (int i = 0; i < 3; i++)
                    WorkoutCard(
                      title: shoulderExercise[i].title,
                      workoutList: shoulderExercise[i].workoutList,
                      tagValue: i,
                      imaUrl: shoulderExercise[i].imageUrl,
                      tag: shoulderExercise[i].tag,
                    ),
                  getTitle(exerciseName[3]),
                  for (int i = 0; i < 3; i++)
                    WorkoutCard(
                      title: legsExercise[i].title,
                      workoutList: legsExercise[i].workoutList,
                      tagValue: i,
                      imaUrl: legsExercise[i].imageUrl,
                      tag: legsExercise[i].tag,
                    ),
                  getTitle(exerciseName[4]),
                  for (int i = 0; i < 3; i++)
                    WorkoutCard(
                      title: armsExercise[i].title,
                      workoutList: armsExercise[i].workoutList,
                      tagValue: i,
                      imaUrl: armsExercise[i].imageUrl,
                      tag: armsExercise[i].tag,
                    ),
                  SizedBox(
                    height: 20,
                  )
                ],
              )),
        ));
  }
}
