import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../pages/main/report_page/workout_report/workout_detail_report.dart';
import '../../../pages/main/setting_page/reminder_screen.dart';
import '../../../provider/subscription_provider.dart';
import '../../subscription_page/subscription_page.dart';



List<Widget> getLeading(BuildContext context) {
  bool isDark = Theme.of(context).textTheme.bodyLarge!.color == Colors.white;

  buildButton({required IconData icon, required Function onTap}) {
    return
      Container(
        decoration: BoxDecoration(
          color: isDark? const Color(0xff222222): Colors.grey.shade50,
          boxShadow: [
            BoxShadow(
                color: isDark?Colors.white30:Theme.of(context).primaryColor.withOpacity(.4),
                blurRadius: 2.0,
                offset:const Offset(0, 0)),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: InkWell(
        onTap: () => onTap(),
        borderRadius: BorderRadius.all(Radius.circular(100)),
        radius: 18,
        child: CircleAvatar(
          child: Icon(
            icon,
            color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.9),
            size: 24,
          ),
          backgroundColor: Colors.transparent,
          radius: 18,
        ),
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
  Provider.of<SubscriptionProvider>(context, listen: false)
      .isProUser
      ? Row(
    children: [


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
        width: 12,
      ),
    ],
  )
      : Padding(
    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
    child: InkWell(
      onTap: () => Navigator.pushNamed(
          context, SubscriptionPage.routeName),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(

          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
                color: isDark?Colors.white30:Theme.of(context).primaryColor.withOpacity(.4),
                blurRadius: 2.0,
                offset:const Offset(0, 0)),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Row(
          children: [
            Image.asset(
              "assets/other/prime_icon.png",
              height: 22,
              color: Colors.white,
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              "PRO",
              style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    ),
  ),

  ];
}
