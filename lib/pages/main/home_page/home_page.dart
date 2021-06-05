import 'dart:io';

import 'package:flutter/material.dart';
import 'package:full_workout/widgets/achivement.dart';
import 'package:full_workout/widgets/workout_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  TabController tabController;

  @override
  void initState() {
    _scrollController = new ScrollController();
    tabController = new TabController(
      vsync: this,
      length: 1,
    );
    super.initState();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    List<String> bodyPart = ["Abs", "Chest", "Shoulder", "Legs", "Arms"];
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    List<String> cover = [
      "assets/cover/abs-cover.jpg",
      "assets/cover/chest.jpg",
      "assets/cover/back-cover.jpg",
      "assets/cover/leg-cover.jpg",
      "assets/cover/arm-cover.jpg",
    ];

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          body: SafeArea(
              child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  title: Text(
                    "Home Workout",
                    style: TextStyle(
                        //   color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 22),
                    textAlign: TextAlign.start,
                    textScaleFactor: 1,
                  ),
                  //collapsedHeight: 55,
                  backgroundColor: isDark ? Colors.black : Colors.white,
                  elevation: 0,
                  brightness: Brightness.dark,
                  automaticallyImplyLeading: false,
                  centerTitle: false,
                  titleSpacing: 010,
                  expandedHeight: 210.0,
                  pinned: true,
                  floating: false,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(children: <Widget>[
                      Column(
                        children: [
                          Container(
                            // child: Text("akash"),
                            height: 50,
                          ),
                          Container(
                            child: Achievement(
                              timeTitle: "Time",
                              timeValue: 12,
                              caloriesTitle: "Calories",
                              caloriesValue: 14,
                              exerciseTitle: "Exercise",
                              exerciseValue: 16,
                            ),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(""),
                                ),
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)
                                        // bottomLeft: Radius.circular(40),
                                        // bottomRight: Radius.circular(40))
                                        )),
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width * .99,
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              ];
            },
            body: Scaffold(
              backgroundColor:isDark ?Colors.black:Colors.white,
              body: TabBarView(
                controller: tabController,
                children: [
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return WorkOutCard(
                          tag: "abc",
                          title: bodyPart[index],
                          image: cover[index],
                          press: () {});
                    },
                    physics: BouncingScrollPhysics(),

                    itemCount: bodyPart.length,
                  )
                ],
              ),
            ),
          )),
        ));
  }
}
