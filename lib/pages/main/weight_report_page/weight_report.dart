

import 'package:flutter/material.dart';
import 'package:full_workout/helper/weight_db_helper.dart';
import 'package:full_workout/pages/main/weight_report_page/weight_chart.dart';
import 'package:full_workout/pages/main/weight_report_page/weight_report_statics.dart';

class WeightReport extends StatefulWidget {
  @override
  _WeightReportState createState() => _WeightReportState();
}

class _WeightReportState extends State<WeightReport> {
  WeightDatabaseHelper weightDatabaseHelper = WeightDatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WeightChart(),
        SizedBox(height: 5,),
        WeightReportStatics(),
      ],
    );
  }
}


