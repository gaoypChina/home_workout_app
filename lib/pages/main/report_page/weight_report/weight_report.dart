

import 'package:flutter/material.dart';
import 'package:full_workout/helper/weight_db_helper.dart';
import 'package:full_workout/pages/main/report_page/weight_report/weight_chart.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

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
      ],
    );
  }
}


