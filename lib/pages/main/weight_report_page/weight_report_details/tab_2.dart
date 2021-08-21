import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../weight_chart.dart';
import '../weight_report_statics.dart';


class WeightDetailTab2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(

        backgroundColor: isDark ? Colors.black : Colors.white,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Weight Statics",
                style: textTheme.subtitle1
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
              ),

              SizedBox(
                height: 18,
              ),
              WeightChart(),
              SizedBox(
                height: 10,
              ),
              WeightReportStatics(),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      );

  }
}
