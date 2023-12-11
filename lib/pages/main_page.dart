import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../pages/main/home_page/home_page.dart';
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
    currentIndex = widget.index ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        bottomNavigationBar:

        Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Container(height: 1,
            color: Colors.grey.withOpacity(.25),),
            BottomNavigationBar(
              elevation: 2,

              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              selectedLabelStyle:
                  TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              unselectedItemColor: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(.85),
              unselectedLabelStyle:
                  TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              selectedItemColor: Theme.of(context).primaryColor,
              iconSize: 22,

              currentIndex: currentIndex ?? 0,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    size: 26,
                  ),
                  activeIcon: Icon(
                    Icons.home,
                    size: 26,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                    icon: Icon(EvaIcons.gridOutline),
                    activeIcon: Icon(EvaIcons.grid),
                    label: "Explore"),
                BottomNavigationBarItem(
                    icon: Icon(
                      EvaIcons.pieChartOutline,
                    ),
                    activeIcon: Icon(
                      EvaIcons.pieChart,
                    ),
                    label: "Report"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.insert_chart_outlined),
                    activeIcon: Icon(Icons.insert_chart),

                    label: "Weight"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person_outline_sharp,
                      size: 23,
                    ),
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
          ],
        ),
        body: getIndex());
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
