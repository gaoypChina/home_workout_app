import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:full_workout/pages/main/report_page/workout_report/workout_detail_report.dart';
import 'package:full_workout/pages/main/setting_page/profile_settings_screen.dart';
import 'package:full_workout/pages/main/setting_page/faq_page.dart';

List<Widget>  getLeading(BuildContext context, {Color color}){
  return  [
    IconButton(
      onPressed: () =>
          Navigator.of(context).pushNamed(ProfileSettingScreen.routeName),
      icon: Icon(
        Icons.person_outline_rounded,
        size: 26,
      ),
      padding: EdgeInsets.only(right: 4, top: 4),
      splashRadius: 24,
    ),
    IconButton(
      padding: EdgeInsets.only(right: 5),
      splashRadius: 24,
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => WorkoutDetailReport()));
      },
      icon: Icon(
        Feather.calendar,
        size: 22,
      ),
      tooltip: "Report",
    ),
    IconButton(
      padding: EdgeInsets.only(right: 5),
      splashRadius: 24,
      onPressed: () => Navigator.of(context).pushNamed(FAQPage.routeName),
      icon: Icon(

        FontAwesome.question_circle_o,

        size: 22,
      ),
      tooltip: "FAQ",
    ),
  ];
}