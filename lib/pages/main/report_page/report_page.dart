import 'package:flutter/material.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/pages/main/report_page/workout_report/weekly_workout_report.dart';
import 'package:full_workout/pages/main/report_page/workout_report/workout_detail_report.dart';
import 'package:full_workout/pages/main/weight_report_page/weight_report.dart';
import 'package:full_workout/pages/services/bmi_service/bmi_card.dart';
import 'package:full_workout/widgets/achivement.dart';
import '../../../main.dart';
import '../../rate_my_app/rate_my_app.dart';

class ReportPage extends StatelessWidget {
  static const routeName = "report-page";
  final Function onBack;
  ReportPage({this.onBack});


  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return RateAppInitWidget(
      builder: (rateMyApp)=> WillPopScope(
        onWillPop: (){
        return  onBack();
        },
        child: Scaffold(
            backgroundColor: isDark ? Colors.black : Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: isDark ? Colors.black : Colors.white,
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
                  AbsorbPointer(
                    child: Achievement(
                      onTap: () {},
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Divider(
                    color: Colors.blueGrey,
                    height: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 8),
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
                    showToday: false,
                    onTap: () =>
                        Navigator.pushNamed(context, WorkoutDetailReport.routeName),
                  ),
                  constants.getDivider(isDark),
                  SizedBox(height: 5,),
                  WeightReport(
                    title: "Weight",
                    isShow: true,
                  ),
                  constants.getDivider(isDark),
                  BmiCard(
                    showBool: true,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
