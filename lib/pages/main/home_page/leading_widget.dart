import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/pages/main/report_page/workout_report/workout_detail_report.dart';
import 'package:full_workout/pages/main/setting_page/reminder_screen.dart';

List<Widget> getLeading(BuildContext context) {
  buildButton({required IconData icon, required Function onTap}) {
    return InkWell(
      onTap:()=> onTap(),
      borderRadius: BorderRadius.all(Radius.circular(100)),
      radius: 18,
      child: CircleAvatar(

        child: Icon(icon,color:Theme.of(context).textTheme.bodyText2!.color,size: 22,),
        backgroundColor: Colors.blue.withOpacity(.1),
        radius: 18,


      ),
    );
  }

  return [
    buildButton(icon: Icons.calendar_today_outlined, onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => WorkoutDetailReport()));
    },),
    SizedBox(
      width:12,
    ),

    buildButton(icon: CupertinoIcons.alarm, onTap: () {
  Navigator.of(context).pushNamed(ReminderTab.routeName);
    },),
    SizedBox(
      width:8,
    ),



  ];
}