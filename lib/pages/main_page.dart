import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/pages/main/home_page/home_page.dart';
import '../main.dart';
import 'main/explore_page/explore_page.dart';
import 'main/report_page/report_page.dart';
import 'main/report_page/weight_report/weight_report_detail.dart';
import 'main/setting_page/setting_screen.dart';

class MainPage extends StatefulWidget {
  static const routeName = "main-page";

  final int index;

  MainPage({this.index});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  String title = "WinkWack";

  onBack() {
    setState(() {
      currentIndex = 0;
    });
  }

  Future<bool> _onBackPressed(BuildContext context) {
    return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  title: new Text('Are you sure?'),
                  content: new Text('Do you want to exit Home Workout App'),
                  actions: <Widget>[
                    new TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text("YES"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text("NO"),
                    ),
                  ],
                )) ??
        false;
  }

  @override
  void initState() {
    currentIndex =widget.index!=null? widget.index:0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();
    return Scaffold(
        bottomNavigationBar: BottomNavigationBarTheme(
          data: BottomNavigationBarThemeData(
              //   backgroundColor: isDark ? Colors.black : Colors.white
              ),
          child: BottomNavigationBar(
            selectedLabelStyle: textTheme.bodyText1
                .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
            elevation: 010,
            showSelectedLabels: true,
            unselectedLabelStyle: textTheme.subtitle1
                .copyWith(fontSize: 12, fontWeight: FontWeight.w700),
            selectedItemColor: constants.widgetColor,
            iconSize: 20,
            backgroundColor: constants.bottomNavigationColor,
            unselectedItemColor: Colors.grey.shade800,
            showUnselectedLabels: true,
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(EvaIcons.homeOutline),
                activeIcon: Icon(EvaIcons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: Icon(AntDesign.appstore_o),
                  activeIcon: Icon(AntDesign.appstore1),
                  label: "Explore"),
              BottomNavigationBarItem(
                  icon: Icon(SimpleLineIcons.chart),
                  activeIcon: Icon(Entypo.bar_graph),
                  label: "Report"),
              BottomNavigationBarItem(
                  icon: Icon(Entypo.line_graph),
                  activeIcon: Icon(Entypo.line_graph),
                  label: "Weight"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  activeIcon: Icon(Icons.settings),
                  label: "Settings"),
            ],
            type: BottomNavigationBarType.fixed,
            onTap: (index) async {
              setState(() {
                  currentIndex = index;
                });
            },
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
      return ReportPage();
    } else if (currentIndex == 3) {
      return WeightReportDetail();
    } else if (currentIndex == 4) {
      return SettingPage();
    } else {
      return Container();
    }
  }
}
