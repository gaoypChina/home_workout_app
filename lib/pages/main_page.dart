import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_workout/navigation/navigation_service.dart';
import 'package:full_workout/pages/main/home_page/home_page.dart';
import 'package:full_workout/pages/main/second_page/second_page.dart';


import 'main/main_menu/main_meanu.dart';
import 'package:toggle_switch/toggle_switch.dart';

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

    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    List<String> bodyPart =["Abs","Shoulder","Arms","Chest","Legs"];
    return Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: BottomNavigationBarTheme(
          data: BottomNavigationBarThemeData(
              backgroundColor: isDark ? Colors.black : Colors.white),
          child: BottomNavigationBar(
            elevation: 0,
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
                  label: "Wink Wack"),
              BottomNavigationBarItem(
                  icon: Icon(EvaIcons.globeOutline),
                  activeIcon: Icon(EvaIcons.globe),
                  label: "Explore"),
              BottomNavigationBarItem(
                  icon: Icon(EvaIcons.messageCircleOutline),
                  activeIcon: Icon(EvaIcons.messageCircle),
                  label: "Messages"),
              BottomNavigationBarItem(
                  icon: Icon(EvaIcons.flashOutline),
                  activeIcon: Icon(EvaIcons.flash),
                  label: "Super Powers"),
              BottomNavigationBarItem(
                  icon: Icon(EvaIcons.moreVerticalOutline),
                  activeIcon: Icon(EvaIcons.moreVertical),
                  label: "More"),
            ],
            type: BottomNavigationBarType.fixed,
            onTap: (index) async {
              if (index != 4) {
                setState(() {
                  currentIndex = index;
                });
              } else {
                SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness: Brightness.dark,
                    ));
                final value = await Navigator.of(context)
                    .push(FadeTransitionPageRouteBuilder(
                    page: MainMenu(
                      currentIndex: currentIndex,
                    )));
                setState(() {
                  if (value != null && value != currentIndex) {
                    currentIndex = value;
                  }
                });
              }
            },
          ),
        ),
        body:getIndex());
  }
  getIndex() {
    if (currentIndex == 0) {
      return HomePage();
    } else if (currentIndex == 1) {
      return SecondPage(
        onBack: onBack,
      );
    } else if (currentIndex == 2) {
      return Scaffold(
        body: SafeArea(
          child: ToggleSwitch(
            initialLabelIndex: 0,
            labels: ['America', 'Canada', 'Mexico'],
            onToggle: (index) {

            },
          ),
        ),
      );
    } else if (currentIndex == 3) {
      return Scaffold(
      );
    } else {
      return Container();
    }
  }

}