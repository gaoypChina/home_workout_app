import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/helper/light_dark_mode.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/pages/main/explore_page/explore_page.dart';
import 'package:full_workout/pages/main/explore_page/rest_day_page.dart';
import 'package:full_workout/pages/workout_page/exercise_list_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timelines/timelines.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/percent_indicator.dart';

class WorkoutTimeLine extends StatefulWidget {
  final ChallengesModel challengesModel;

  WorkoutTimeLine({this.challengesModel});

  @override
  _WorkoutTimeLineState createState() => _WorkoutTimeLineState();
}

class _WorkoutTimeLineState extends State<WorkoutTimeLine>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  TabController tabController;
  SpHelper _spHelper = SpHelper();
  bool _isLoading = true;
  int currentDay = 0;

  getCurrentDate() async {
    currentDay = await _spHelper.loadInt(widget.challengesModel.tag);
  }

  @override
  void initState() {
    getCurrentDate();
    _scrollController = ScrollController();
    tabController = new TabController(
      vsync: this,
      length: 1,
    );
    setState(() {
      _isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (currentDay == 0) {
      currentDay = 1;
    }
    print(currentDay);

    List<String> title = ["Week 1", "Week 2", "Week 3", "Week 4"];
    getWeekTile(int index) {
      getDay(String day, int currIndex) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
              child: CircleAvatar(
                child: currIndex < currentDay ? Icon(Icons.check) : Text(day),
                radius: 16,
                backgroundColor: currIndex < currentDay
                    ? Colors.blue.shade700
                    : Colors.grey.shade300,
              ),
              onTap: () => currIndex < currentDay
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExerciseListScreen(
                                workOutList: widget
                                    .challengesModel.challengeList[currIndex],
                                tag: widget.challengesModel.tag,
                                title: widget.challengesModel.title +
                                    " Day ${currIndex + 1}",
                                tagValue: currentDay,
                              )),
                    )
                  : Fluttertoast.showToast(
                      msg: "Please Complete previous challenges",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.blue.shade700.withOpacity(.9),
                      textColor: Colors.white,
                      fontSize: 16.0)),
        );
      }

      getArrow() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 16,
          ),
        );
      }

      return Container(
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getDay("1", index + 0),
                  getArrow(),
                  getDay("2", index + 1),
                  getArrow(),
                  getDay("3", index + 2),
                  getArrow(),
                  getDay("4", index + 3)
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getDay("5", index + 4),
                  getArrow(),
                  getDay("6", index + 5),
                  getArrow(),
                  getDay("7", index + 6),
                  getArrow(),
                  CircleAvatar(
                    child: Icon(FontAwesome.trophy, color: Colors.white),
                    radius: 20,
                    backgroundColor: Colors.amberAccent,
                  ),
                  SizedBox(
                    width: 5,
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      );
    }

    getChallenges() {
      return FixedTimeline.tileBuilder(
          theme: TimelineThemeData(
            nodePosition: 0,
            color: Colors.blue,
            indicatorTheme: IndicatorThemeData(
              position: 0.028,
              size: 18.0,
            ),
            connectorTheme: ConnectorThemeData(
              thickness: 2.5,
            ),
          ),
          builder: TimelineTileBuilder.connected(
              connectionDirection: ConnectionDirection.before,
              itemCount: 4,
              indicatorBuilder: (_, index) {
                if (index < 2) {
                  return Indicator.dot(
                    size: 20,
                    child: Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    ),
                    color: Colors.blue.shade700,
                  );
                }
                return Indicator.dot(
                  color: Colors.grey,
                  child: Icon(
                    Icons.flash_on,
                    size: 15,
                    color: Colors.white,
                  ),
                  size: 20,
                );
              },
              connectorBuilder: (_, index, ___) => index > 1
                  ? DashedLineConnector(
                      color: Colors.grey,
                      dash: 1,
                    )
                  : SolidLineConnector(color: Theme.of(context).primaryColor),
              contentsBuilder: (context, index) {
                int indexIndex = 0;
                if (index == 0) {
                  indexIndex = 0;
                } else if (index == 1) {
                  indexIndex = 7;
                } else if (index == 2) {
                  indexIndex = 14;
                } else {
                  indexIndex = 21;
                }
                return Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        title[index],
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .merge(TextStyle(fontSize: 16)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: getWeekTile(indexIndex),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              }));
    }

    ChallengesModel item = widget.challengesModel;
    print(currentDay);

    return _isLoading == true
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Colors.blue,
            body: SafeArea(
                child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    title: Text(item.title),
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    centerTitle: false,
                    expandedHeight: 190.0,
                    collapsedHeight: 60,
                    pinned: true,
                    floating: false,
                    forceElevated: innerBoxIsScrolled,
                    backgroundColor: item.color1,
                    //collapsedHeight: 55,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(children: <Widget>[
                        Container(
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new ExactAssetImage(item.imageUrl),
                              fit: BoxFit.cover,
                            ),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [item.color1, item.color2]),
                          ),
                        ),
                        Positioned(
                    height: 20,
                    width: 300,
                    bottom: 20,
                    left: 20,
                    child: LinearPercentIndicator(
                      percent: 13 / 28,
                      lineHeight: 20,
                      animation: true,
                      center: new Text(
                        "13/28",
                        style: textTheme.subtitle2
                            .copyWith(fontSize: 14, color: Colors.white),
                      ),
                      progressColor: Colors.blue,
                            backgroundColor: Colors.blue.shade200,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ];
              },
              body: Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButtonAnimator:
                    FloatingActionButtonAnimator.scaling,
                floatingActionButton: Container(
                  padding: EdgeInsets.only(bottom: 0.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.blue.shade700,
                      onPressed: () {},
                      icon: Icon(
                        Icons.local_fire_department_sharp,
                        color: Colors.white,
                        size: 30,
                      ),
                      label: Text(
                        "Start Workout",
                        style: textTheme.button
                            .copyWith(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ),
                body: TabBarView(
                  controller: tabController,
                  children: [
                    ListView(
                      padding: EdgeInsets.all(10),
                      physics: BouncingScrollPhysics(),
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        getChallenges(),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
    );
  }
}
