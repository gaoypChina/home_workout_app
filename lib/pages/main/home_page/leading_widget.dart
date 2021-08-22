import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:full_workout/pages/main/report_page/workout_report/workout_detail_report.dart';
import 'package:full_workout/pages/main/setting_page/reminder_screen.dart';

List<Widget>  getLeading(BuildContext context, {Color color}){
  return  [
    IconButton(
      splashRadius: 24,
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => WorkoutDetailReport()));
      },
      icon: Icon(
        Feather.calendar,
        size: 22,
        color: color,
      ),
      tooltip: "Report",
    ),
    IconButton(
      onPressed: () => Navigator.of(context).pushNamed(ReminderTab.routeName),
      icon: Icon(
        Ionicons.md_alarm,
        size: 26,
        color: color,
      ),
      padding: EdgeInsets.only(right: 8, top: 0),
      splashRadius: 24,
    ),
    // IconButton(
    //   onPressed: () =>
    //       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    //     return Test();
    //   })),
    //   icon: Icon(
    //     Ionicons.md_alarm,
    //     size: 26,
    //   ),
    //   padding: EdgeInsets.only(right: 8, top: 0),
    //   splashRadius: 24,
    // ),
    //
    // IconButton(
    //   onPressed: () =>
    //       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    //         return WeeklyTest();
    //       })),
    //   icon: Icon(
    //     Ionicons.ios_add,
    //     size: 26,
    //   ),
    //   padding: EdgeInsets.only(right: 8, top: 0),
    //   splashRadius: 24,
    // ),


  ];
}