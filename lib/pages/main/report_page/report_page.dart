import 'package:flutter/material.dart';
import 'package:full_workout/constants/constant.dart';
import 'package:full_workout/pages/main/home_page/leading_widget.dart';
import 'package:full_workout/pages/main/report_page/workout_report/weekly_workout_report.dart';
import 'package:full_workout/pages/main/report_page/workout_report/workout_detail_report.dart';
import 'package:full_workout/pages/main/weight_report_page/weight_report.dart';
import 'package:full_workout/pages/services/bmi_service/bmi_card.dart';

import '../../../widgets/active_goal.dart';
import '../../../widgets/banner_medium_ad.dart';
import '../../rate_my_app/rate_my_app.dart';

class ReportPage extends StatefulWidget {
  static const routeName = "report-page";
  final Function onBack;

  ReportPage({required this.onBack});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  bool get isbouncing{
    return _scrollController.hasClients &&
        _scrollController.offset > (250 - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).textTheme.bodyText1!.color == Colors.white;
    Constants constants = Constants();
    var size = MediaQuery.of(context).size;

    _buildExercise({required String title, required String subtitle}) {
      return Expanded(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            subtitle,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ],
      ));
    }

    return RateAppInitWidget(
        builder: (rateMyApp) => WillPopScope(
              onWillPop: () {
                return widget.onBack();
              },
              child: Scaffold(
                body: NestedScrollView(

                  controller: _scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        actions: [
                          // ...getLeading(
                          //   context,
                          // ),
                        ],
                        title: Text(
                          "Report",
                          style: TextStyle(
                            color: isDark
                                ? Colors.white
                                : isShrink
                                    ? Colors.black
                                    : Colors.white,
                          ),
                        ),
                        elevation: .5,
                        centerTitle: false,
                        expandedHeight: size.height * .22,
                        collapsedHeight: 60,
                        pinned: true,
                        floating: false,
                        forceElevated: innerBoxIsScrolled,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                            color: Colors.blue.withOpacity(.5),
                            width: size.width,
                            child: Stack(
                              children: [
                                Opacity(
                                  opacity: .8,
                                  child: Image.asset(
                                    "assets/explore_image/img_20.jpg",
                                    fit: BoxFit.fill,
                                    width: size.width,
                                  ),
                                ),
                                Container(
                                  color: Colors.black.withOpacity(.6),
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 80,
                                    ),
                                    Spacer(),
                                    Container(

                                        //padding: EdgeInsets.only(bottom: 18),

                                        child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [

                                        _buildExercise(
                                            title: "Exercise", subtitle: "25"),

                                        _buildExercise(
                                            title: "Minute", subtitle: "06"),
                                        _buildExercise(
                                            title: "Calories", subtitle: "95")
                                      ],
                                    )),
                                    Spacer(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: SingleChildScrollView(
                    physics:isbouncing? BouncingScrollPhysics(): ScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        constants.getDivider(context: context),


                        // AbsorbPointer(
                        //   child: Achievement(
                        //     onTap: () {},
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 16,
                        // ),
                        // Container(
                        //   color: Theme.of(context).dividerColor,
                        //   height: .8,
                        // ),
                        //    constants.getDivider(context: context),




                        Container(
                          padding: const EdgeInsets.only(left: 18.0, right: 8),
                          child: Row(
                            children: [
                              Text(
                                "History",
                                style: Constants().titleStyle,
                              ),
                              Spacer(),
                              TextButton(
                                  onPressed: () => Navigator.pushNamed(
                                      context, WorkoutDetailReport.routeName),
                                  child: Text(
                                    "More",
                                  )),
                            ],
                          ),
                        ),
                        WeeklyWorkoutReport(
                          showToday: false,
                          onTap: () => Navigator.pushNamed(
                              context, WorkoutDetailReport.routeName),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                         constants.getDivider(context: context),
                        WeightReport(
                          title: "Weight",
                          isShow: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        constants.getDivider(context: context),

                        MediumBannerAd(
                            bgColor: Theme.of(context).scaffoldBackgroundColor,
                            showDivider: true),
                        BmiCard(
                          showBool: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
