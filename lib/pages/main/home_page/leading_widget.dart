import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_workout/pages/main/report_page/workout_report/workout_detail_report.dart';
import 'package:full_workout/pages/main/setting_page/reminder_screen.dart';

List<Widget>  getLeading(BuildContext context, {required Color color}){
  return  [
    IconButton(
      splashRadius: 24,
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => WorkoutDetailReport()));
      },
      icon: Icon(
        FontAwesomeIcons.calendarAlt,
        size: 20,
        color: color,
      ),
      tooltip: "Report",
    ),
    IconButton(
      onPressed: () => Navigator.of(context).pushNamed(ReminderTab.routeName),
      icon: Icon(
        FontAwesomeIcons.bell,
        size: 22,
        color: color,
      ),
      padding: EdgeInsets.only(right: 8, top: 0),
      splashRadius: 24,
    ),


  ];
}