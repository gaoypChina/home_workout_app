import 'package:flutter/material.dart';
import 'package:full_workout/constants/constant.dart';
import 'package:full_workout/pages/main/report_page/workout_report/weekly_workout_report.dart';
import 'package:full_workout/pages/main/report_page/workout_report/workout_detail_report.dart';
import 'package:full_workout/pages/main/weight_report_page/weight_report.dart';
import 'package:full_workout/pages/services/bmi_service/bmi_card.dart';
import 'package:full_workout/widgets/achivement.dart';

import '../../rate_my_app/rate_my_app.dart';

class ReportPage extends StatelessWidget {
  static const routeName = "report-page";
  final Function onBack;
  ReportPage({required this.onBack});


  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();

    return RateAppInitWidget(
      builder: (rateMyApp)=> WillPopScope(
        onWillPop: (){
        return  onBack();
        },
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Text(
                "Report",
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
                  Container(
                    color: Theme.of(context).dividerColor,
                    height: .8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 8),
                    child: Row(
                      children: [
                        Text(
                          "History",
                          style: Constants().titleStyle,
                        ),
                        Spacer(),
                        TextButton(
                            onPressed: () => Navigator.pushNamed(
                                context, WorkoutDetailReport.routeName),
                            child: Text(
                              "More",
                            )),
                      ],
                    ),
                  ),
                  WeeklyWorkoutReport(
                    showToday: false,
                    onTap: () => Navigator.pushNamed(
                        context, WorkoutDetailReport.routeName),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  constants.getDivider(context: context),
                  WeightReport(
                    title: "Weight",
                    isShow: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  constants.getDivider(context: context),
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
