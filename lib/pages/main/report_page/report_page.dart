import 'package:flutter/material.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/pages/main/home_page/leading_widget.dart';
import 'package:full_workout/pages/main/report_page/workout_report/weekly_workout_report.dart';
import 'package:full_workout/pages/main/report_page/workout_report/workout_detail_report.dart';
import 'package:full_workout/pages/main/weight_report_page/weight_report.dart';
import 'package:full_workout/pages/services/bmi_service/bmi_card.dart';
import 'package:full_workout/widgets/achivement.dart';
import '../../../main.dart';

class ReportPage extends StatelessWidget {
  static const routeName = "report-page";

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor: isDark ? Colors.black : Colors.white,
          actions: getLeading(context),
          automaticallyImplyLeading: false,
          title: Text(
            "Report",
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Achievement(
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Text(
                      "History",
                      style: textTheme.subtitle1
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Spacer(),
                    TextButton(
                        onPressed: () => Navigator.pushNamed(
                            context, WorkoutDetailReport.routeName),
                        child: Text(
                          "More",
                          style: textTheme.button,
                        )),
                  ],
                ),
              ),
              WeeklyWorkoutReport(
                onTap: () =>
                    Navigator.pushNamed(context, WorkoutDetailReport.routeName),
              ),
              constants.getDivider(isDark),
              Padding(
                padding: const EdgeInsets.only(left: 18,top: 4,bottom: 12),

                 child:   Text(
                      "Weight",
                      style: textTheme.subtitle1
                          .copyWith(fontWeight: FontWeight.w700),
                    ),


              ),
            WeightReport(),
              constants.getDivider(isDark),
              BmiCard(
                showBool: true,
              ),
            ],
          ),
        ));
  }
}
