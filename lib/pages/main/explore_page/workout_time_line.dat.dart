import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/helper/light_dark_mode.dart';
import 'package:full_workout/pages/main/explore_page/second_page.dart';
import 'package:full_workout/widgets/achivement.dart';
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

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  List isDayCompleted;
  String listKey = "listKey";

  void storeStringList(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(listKey, list);
  }

  Future<List<String>> getStringList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getStringList(listKey);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    tabController = new TabController(
      vsync: this,
      length: 1,
    );
    _scrollController.addListener(_scrollListener);
    isDayCompleted = List.generate(28, (index) {
      if (index < 15) {
        return false;
      } else {
        return true;
      }
    });
    print(isDayCompleted);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getTimeLineCard(int index, bool isDone,var item) {
      return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [item.color1, item.color2]),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Day: $index",
                    style: textTheme.subtitle2
                        .copyWith(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    "12 Exercise | 25 Minutes",
                    style: textTheme.subtitle2
                        .copyWith(fontSize: 14, color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              RaisedButton(
                onPressed: isDone ? () {} : () {},
                child: isDone
                    ? Text(
                        "Start",
                        style:
                            textTheme.subtitle2.copyWith(color: Colors.white),
                      )
                    : Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                color: isDone
                    ? index == 15
                        ? Colors.amber
                        : Colors.grey
                    : Colors.green,
                //   style: TextButton.styleFrom(
                //
                //       elevation: isDone ? 0 : 5,
                //       backgroundColor: isDone ?index == 15?Colors.amber: Colors.grey : Colors.green),
                //
              )
            ],
          ),
        ),
      );
    }

    getTimeLine(var item) {
      return FixedTimeline.tileBuilder(
        theme: TimelineThemeData(
          nodePosition: 0,
          indicatorTheme: IndicatorThemeData(
            size: 18.0,
          ),
          connectorTheme: ConnectorThemeData(
            thickness: 2.5,
          ),
        ),
        builder: TimelineTileBuilder.connected(
          contentsAlign: ContentsAlign.basic,
          indicatorBuilder: (_, index) {
            for (bool item in isDayCompleted)
              if (index <= 15) {
                return Indicator.dot(
                  color: Colors.blue,
                );
              } else {
                return Indicator.outlined(
                  borderWidth: 2.5,
                );
              }
            return OutlinedDotIndicator(
              borderWidth: 2.5,
            );
          },
          connectorBuilder: (_, index, ___) =>
              SolidLineConnector(color: Colors.blue),
          contentsBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 14.0, top: 14, bottom: 14),
              child: getTimeLineCard(index, isDayCompleted[index],item)),
          itemCount: 28,
        ),
      );
    }

    var item = widget.challengesModel;

    return Scaffold(
      backgroundColor: isShrink ? item.color1 : item.color1,
      body: SafeArea(
          child: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                          colors: [item.color1,item.color2]),
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
          body: TabBarView(
            controller: tabController,
            children: [
              ListView(
                padding: EdgeInsets.all(20),
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  getTimeLine(item)
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
