import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_workout/constants/constant.dart';
import 'package:full_workout/pages/main/home_page/home_page.dart';
import 'main/explore_page/explore_page.dart';
import 'main/report_page/report_page.dart';
import 'main/setting_page/setting_screen.dart';
import 'main/weight_report_page/weight_report_details/weight_report_detail.dart';

class MainPage extends StatefulWidget {
  static const routeName = "main-page";

  final int? index;

  MainPage({required this.index});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int? currentIndex = 0;
  onBack() {
    setState(() {
      currentIndex = 0;
    });
  }


  @override
  void initState() {
    currentIndex =widget.index??0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();
     return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.4),
                blurRadius: 1,
              ),
            ],
          ),
          child: BottomNavigationBarTheme(
            data: BottomNavigationBarThemeData(
              elevation: 1,
                  backgroundColor:Theme.of(context).bottomAppBarColor
                ),
            child: BottomNavigationBar(
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              elevation: 010,
              showSelectedLabels: true,
              unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              selectedItemColor: constants.primaryColor,
              iconSize: 20,
              showUnselectedLabels: true,
              currentIndex: currentIndex??0,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.house,size: 22,),
                  activeIcon: Icon(CupertinoIcons.house_fill,size: 22,),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                    icon: Icon(EvaIcons.gridOutline),
                    activeIcon: Icon(EvaIcons.grid),
                    label: "Explore"),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.chartBar),
                    activeIcon: Icon(FontAwesomeIcons.chartBar),
                    label: "Report"),
                BottomNavigationBarItem(
                    icon: Icon(EvaIcons.pieChartOutline,),
                    activeIcon: Icon(EvaIcons.pieChart,),
                    label: "Weight"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline_sharp,size: 23,),
                    activeIcon: Icon(CupertinoIcons.person_solid),
                    label: "Profile"),
              ],
              type: BottomNavigationBarType.fixed,
              onTap: (index) async {
                setState(() {
                    currentIndex = index;
                  });
              },
            ),
          ),
        ),
        body:getIndex());
  }
  getIndex() {
    if (currentIndex == 0) {
      return HomePage();
    } else if (currentIndex == 1) {
      return ExplorePage(
        onBack: onBack,
      );
    } else if (currentIndex == 2) {
      return ReportPage(
        onBack: onBack,
      );
    } else if (currentIndex == 3) {
      return WeightReportDetail(
        onBack: onBack,
        index: 0,
      );
    } else if (currentIndex == 4) {
      return SettingPage(
        onBack: onBack,
      );
    } else {
      return Container();
    }
  }
}
