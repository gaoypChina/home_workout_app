import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/pages/main/report_page/workout_report/workout_detail_report.dart';
import 'package:full_workout/pages/main/setting_page/reminder_screen.dart';

List<Widget> getLeading(BuildContext context) {
  return [
    IconButton(
      splashRadius: 24,
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => WorkoutDetailReport()));
      },
      icon: Icon(
        Icons.calendar_today_outlined,
        size: 24,
        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.8),
      ),
      tooltip: "Report",
    ),
    IconButton(
      onPressed: () => Navigator.of(context).pushNamed(ReminderTab.routeName),
      icon: Icon(
        CupertinoIcons.alarm,
        size: 24,
        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.8),
      ),
      padding: EdgeInsets.only(right: 8, top: 0),
      splashRadius: 24,
    ),
    SizedBox(
      width: 4,
    )
  ];
}