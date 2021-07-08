

import 'package:flutter/material.dart';
import 'package:full_workout/database/weight_db_helper.dart';
import 'package:full_workout/pages/main/report_page/weight_report/weight_chart.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class WeightReport extends StatefulWidget {
  @override
  _WeightReportState createState() => _WeightReportState();
}

class _WeightReportState extends State<WeightReport> {
  WeightDatabaseHelper weightDatabaseHelper = WeightDatabaseHelper();


  getPicker() async {
    DateTime selectedDate = await showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
    );
    return selectedDate;
  }


  List weightData;

  loadData(DateTime currDate) async {
    //  weightData = await weightDatabaseHelper.getAllWeight();
    weightData = await weightDatabaseHelper.getRangeData(currDate);
    await weightDatabaseHelper.getMaxWeight();
    return weightData;
  }

  @override
  void initState() {
    print(weightData);
    //  loadData();
    print(weightData);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var res = "";
    return Column(
      children: [
        WeightChart(),
      ],
    );
  }
}


