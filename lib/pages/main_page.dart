import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:full_workout/pages/main/home_page/home_page.dart';
import 'main/explore_page/explore_page.dart';
import 'main/progress_page/details_screen.dart';
import 'main/progress_page/report_screen.dart';
import 'main/setting_page/setting_screen.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        bottomNavigationBar: BottomNavigationBarTheme(
          data: BottomNavigationBarThemeData(
           //   backgroundColor: isDark ? Colors.black : Colors.white
        ),
          child: BottomNavigationBar(
            elevation: 10,
            showSelectedLabels: false,
            selectedItemColor: Colors.blue,
            iconSize: 28,
            unselectedItemColor: Colors.grey.shade500,
            showUnselectedLabels: false,
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(EvaIcons.homeOutline),
                  activeIcon: Icon(EvaIcons.home),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(MaterialCommunityIcons.notebook_outline),
                  activeIcon: Icon(MaterialCommunityIcons.notebook),
                  label: "Explore"),
              BottomNavigationBarItem(
                  icon: Icon(Entypo.bar_graph),
                  activeIcon: Icon(Entypo.bar_graph),
                  label: "Report"),

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
      return ReportScreen();
    } else if (currentIndex == 3) {
      return SettingPage();
    } else {
      return Container();
    }
  }
}