import 'package:flutter/material.dart';
import '../../../constants/constant.dart';
import '../../../pages/main/report_page/workout_report/weekly_workout_report.dart';
import '../../../../pages/main/report_page/workout_report/workout_detail_report.dart';
import '../../../pages/main/weight_report_page/weight_report.dart';
import '../../../pages/services/bmi_service/bmi_card.dart';
import '../../../widgets/achivement.dart';
import 'package:provider/provider.dart';

import '../../../provider/ads_provider.dart';
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

  bool get isbouncing {
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

    var adsProvider = Provider.of<AdsProvider>(context, listen: true);

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
                        expandedHeight: size.height * .20,
                        collapsedHeight: 60,
                        pinned: true,
                        floating: false,
                        forceElevated: innerBoxIsScrolled,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Achievement(
                            onTap: () {},
                          ),
                        ),
                      ),
                    ];
                  },
                  body: SingleChildScrollView(
                    physics:
                        isbouncing ? BouncingScrollPhysics() : ScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        constants.getDivider(context: context),
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
                                  style: TextButton.styleFrom(
                                      primary: Theme.of(context).primaryColor),
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
                        if (adsProvider.showBannerAd)
                          SizedBox(
                            height: 10,
                          ),
                        MediumBannerAd(),
                        if (adsProvider.showBannerAd)
                          SizedBox(
                            height: 10,
                          ),
                        if (adsProvider.showBannerAd)
                          constants.getDivider(context: context),
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
