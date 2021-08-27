import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/models/main_page_item.dart';
import 'package:full_workout/pages/main/report_page/workout_report/workout_detail_report.dart';
import 'package:full_workout/widgets/achivement.dart';
import 'package:full_workout/widgets/active_goal.dart';
import 'package:full_workout/widgets/workout_card.dart';

import '../../../main.dart';
import 'leading_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  )) ??
          false;
    }

    getTitle(String title) {
      return Container(
        padding: EdgeInsets.only(left: 18, right: 8, top: 12, bottom: 6),
        child: Text(title,
            style: textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            )),
      );
    }

    List<List<Color>> cardColor = [
      [Colors.green, Colors.blue],
      [Colors.orange, Colors.blue],
      [Colors.red, Colors.blue],
    ];

    double height = MediaQuery.of(context).size.height;
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;


    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          backgroundColor: isDark?Colors.black:Colors.white,
          body: NestedScrollView(
              physics: BouncingScrollPhysics(),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    actions: [...getLeading(context,color:isDark? Colors.white:Colors.black)],
                    backgroundColor: isDark?Colors.black:Colors.white,
                    automaticallyImplyLeading: false,
                    expandedHeight:height * .16,
                    elevation: 0,
                    title:
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Home ",
                          style: TextStyle(
                              color:
                                  isDark ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 22)),
                      TextSpan(
                          text: "Workout",
                          style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 22))
                    ])),

                    pinned: true,
                    forceElevated: innerBoxIsScrolled,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Container(
                          decoration: BoxDecoration(
                            color: isDark ? Colors.black : Colors.white,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Spacer(
                                  flex: 4,
                                ),
                                Achievement(
                                  onTap: () => Navigator.pushNamed(
                                      context, WorkoutDetailReport.routeName),
                                ),
                                Spacer(),
                                // Divider(height: 8,thickness:isDark? .1 : .1,color:isDark?Colors.grey: Colors.grey.shade300,)
                              ],
                            ),
                          )),
                    ),
                  ),
                ];
              },
              body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 0),
                children: [
                  ActiveGoal(),
                  SizedBox(height: 2,),
                  getTitle(exerciseName[0]),
                  for (int i = 0; i < 3; i++)
                    WorkoutCard(
                      color: cardColor[i],
                      title: absExercise[i].title,
                      workoutList: absExercise[i].workoutList,
                      tagValue: i,
                      imaUrl: absExercise[i].imageUrl,
                      tag: absExercise[i].tag,
                      index: 0,
                    ),
                  getTitle(exerciseName[1]),
                  for (int i = 0; i < 3; i++)
                    WorkoutCard(
                      color: cardColor[i],
                      title: chestExercise[i].title,
                      workoutList: chestExercise[i].workoutList,
                      tagValue: i,
                      imaUrl: chestExercise[i].imageUrl,
                      tag: chestExercise[i].tag,
                      index: 1,
                    ),
                  getTitle(exerciseName[2]),
                  for (int i = 0; i < 3; i++)
                    WorkoutCard(
                      color: cardColor[i],
                      title: shoulderExercise[i].title,
                      workoutList: shoulderExercise[i].workoutList,
                      tagValue: i,
                      imaUrl: shoulderExercise[i].imageUrl,
                      tag: shoulderExercise[i].tag,
                      index: 0,
                    ),
                  getTitle(exerciseName[3]),
                  for (int i = 0; i < 3; i++)
                    WorkoutCard(
                      color: cardColor[i],
                      title: legsExercise[i].title,
                      workoutList: legsExercise[i].workoutList,
                      tagValue: i,
                      imaUrl: legsExercise[i].imageUrl,
                      tag: legsExercise[i].tag,
                      index: 1,
                    ),
                  getTitle(exerciseName[4]),
                  for (int i = 0; i < 3; i++)
                    WorkoutCard(
                      color: cardColor[i],
                      title: armsExercise[i].title,
                      workoutList: armsExercise[i].workoutList,
                      tagValue: i,
                      imaUrl: armsExercise[i].imageUrl,
                      tag: armsExercise[i].tag,
                      index: 0,
                    ),
                  SizedBox(
                    height: 20,
                  )
                ],
              )),
        ));
  }
}
