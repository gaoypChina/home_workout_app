import 'package:flutter/material.dart';
import '../../../pages/main/weight_report_page/weight_chart.dart';
import '../../../pages/main/weight_report_page/weight_report_statics.dart';
import '../../../pages/main_page.dart';

class WeightReport extends StatelessWidget {
  final bool isShow;
  final String title;
  WeightReport({required this.isShow, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WeightChart(
            showButton: isShow,
            title: title,
            onAdd: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainPage(
                            index: 2,
                          )),
                  ModalRoute.withName("/"));
            }),
        SizedBox(
          height: 5,
        ),
        WeightReportStatics(),
      ],
    );
  }
}
