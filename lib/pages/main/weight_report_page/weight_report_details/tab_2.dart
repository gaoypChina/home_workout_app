import 'package:flutter/material.dart';
import '../weight_report.dart';


class WeightDetailTab2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(

        backgroundColor: isDark ? Colors.black : Colors.white,
        body: SingleChildScrollView(
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
        ),
      );

  }
}
