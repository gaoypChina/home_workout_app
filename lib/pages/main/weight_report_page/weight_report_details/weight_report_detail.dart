import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:full_workout/pages/main/weight_report_page/weight_report_details/tab_1.dart';
import 'package:full_workout/pages/main/weight_report_page/weight_report_details/tab_2.dart';

class WeightReportDetail extends StatelessWidget {
  final Function onBack;

  WeightReportDetail({this.onBack});

  static const routeName = "weight-report-detail";

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return WillPopScope(
      onWillPop: () => onBack(),
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, _) => [
              SliverAppBar(
                pinned: true,
                floating: true,
                snap: true,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      // image: DecorationImage(
                      //     image: AssetImage("assets/weight_tracker.jpg"),
                      //     fit: BoxFit.cover,
                      //     colorFilter: ColorFilter.mode(
                      //         Colors.black.withOpacity(.6), BlendMode.colorBurn)),
                      gradient:
                          LinearGradient(colors: [Colors.blue.shade700, Colors.blue.shade700])),
                ),
                title: Text(
                  "Weight Tracker",
                ),
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
                        Icons.stacked_line_chart_outlined,
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
