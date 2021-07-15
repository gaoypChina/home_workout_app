import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:full_workout/pages/main/report_page/workout_report/workout_detail_report.dart';
import 'package:full_workout/pages/services/faq_page.dart';


List<Widget>  getLeading(BuildContext context){

  return  [
    IconButton(
      padding:EdgeInsets.only(right: 5) ,
      splashRadius: 18,
      onPressed: () {
      },
      icon: Icon(
        Ionicons.ios_man,size: 22,
      ),
      tooltip: "Profile",
    ),
    
    IconButton(
      padding:EdgeInsets.only(right: 5) ,

      splashRadius: 12,
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => WorkoutDetailReport()));
      },
      icon: Icon(
        Feather.calendar,size: 22,
      ),
      tooltip: "Report",
    ),
    IconButton(
      padding:EdgeInsets.only(right: 5) ,
      splashRadius: 12,
      onPressed: () =>
          Navigator.of(context).pushNamed(FAQPage.routeName),
      icon: Icon(
        FontAwesome.question_circle_o,size: 22,
      ),
      tooltip: "FAQ",
    ),
  ];
}