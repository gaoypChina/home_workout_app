import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:full_workout/pages/main/weight_report_page/weight_report_details/tab_1.dart';
import 'package:full_workout/pages/main/weight_report_page/weight_report_details/tab_2.dart';

class WeightReportDetail extends StatelessWidget {
  final Function onBack;
  final int index;



  WeightReportDetail({ required this.onBack, required this.index});

  static const routeName = "weight-report-detail";

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return WillPopScope(
      onWillPop: () => onBack(),
      child: DefaultTabController(
        initialIndex: index,
        length: 2,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, _) => [
              SliverAppBar(
                pinned: true,
                floating: true,
                snap: true,
                backgroundColor:isDark?Colors.black: Colors.blue.shade700,
                flexibleSpace: Container(

                ),

                title: Text(
                  "Weight Tracker",
                ),
                automaticallyImplyLeading: false,
                bottom: TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.history,

                      ),
                      child: Text(
                        "HISTORY",
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        FontAwesomeIcons.chartLine,
                      ),
                      child: Text(
                        "STATICS",
                      ),
                    ),
                  ],
                ),
              ),
            ],
            body: TabBarView(
                children: [WeightDetailTab1(), WeightDetailTab2()],
            ),
          ),
        ),
      ),
    );
  }
}
