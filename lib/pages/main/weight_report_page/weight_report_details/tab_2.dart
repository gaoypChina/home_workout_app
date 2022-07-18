import 'package:flutter/material.dart';
import 'package:full_workout/constants/constant.dart';
import 'package:full_workout/widgets/banner_medium_ad.dart';

import '../weight_report.dart';

class WeightDetailTab2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
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
              SizedBox(height: 10,),
              Constants().getDivider(context: context),
              SizedBox(height: 18,),
              MediumBannerAd(
          ),
              SizedBox(height: 20,),
        ],
          ),

      );

  }
}
