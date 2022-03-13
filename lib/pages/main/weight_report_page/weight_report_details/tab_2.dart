import 'package:flutter/material.dart';
import '../weight_report.dart';


class WeightDetailTab2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
              ),
              WeightReport(
                title: "Weight Statics",
                isShow: false,
              ),

            ],
          ),

      );

  }
}
