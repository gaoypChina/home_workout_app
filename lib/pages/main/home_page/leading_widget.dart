import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../pages/main/report_page/workout_report/workout_detail_report.dart';
import '../../../pages/main/setting_page/reminder_screen.dart';
import '../../../widgets/prime_button.dart';

List<Widget> getLeading(BuildContext context) {
  buildButton({required IconData icon, required Function onTap}) {
    return InkWell(
      onTap: () => onTap(),
      borderRadius: BorderRadius.all(Radius.circular(100)),
      radius: 18,
      child: CircleAvatar(
        child: Icon(
          icon,
          color: Theme.of(context).textTheme.bodyText1!.color,
          size: 24,
        ),
        backgroundColor: Colors.transparent,
        radius: 18,
      ),
    );
  }

  buildUserAvatar() {
    return Padding(
        padding: EdgeInsets.only(right: 12),
        child: CircleAvatar(
          child: Text(
            "A",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
          ),
        ));
  }

  return [
    false
        ? PrimeButton()
        : Row(
            children: [
              // Image.network("https://cdn-icons.flaticon.com/png/512/2278/premium/2278049.png?token=exp=1654648220~hmac=3ce5606aa4fcc1316c40746d5e69b263",
              // width: 23,color: Colors.white,),
              buildButton(
                icon: Icons.calendar_today_outlined,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WorkoutDetailReport()));
                },
              ),
              SizedBox(
                width: 12,
              ),

              buildButton(
                icon: CupertinoIcons.alarm,
                onTap: () {
                  Navigator.of(context).pushNamed(ReminderTab.routeName);
                },
              ),
              SizedBox(
                width: 8,
              ),
            ],
          )
  ];
}
