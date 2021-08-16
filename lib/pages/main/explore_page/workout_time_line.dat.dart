import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/pages/main/explore_page/explore_page.dart';
import 'package:full_workout/pages/workout_page/exercise_list_page.dart';
import 'package:timelines/timelines.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:dashed_circle/dashed_circle.dart';

import '../../../main.dart';

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
  Constants constants = Constants();
  bool _isLoading = true;
  int currentDay = 0;

  getCurrentDate() async {
    setState(() {
      _isLoading = true;
    });
    currentDay = await _spHelper.loadInt(widget.challengesModel.tag) ?? 0;
    setState(() {
      _isLoading = false;
    });
  }
  
  onComplete(int currIndex){
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ExerciseListScreen(
            workOutList: widget
                .challengesModel.challengeList[currIndex],
            tag: widget.challengesModel.tag,
            title: widget.challengesModel.title +
                " Day ${currIndex + 1}",
            tagValue: currentDay + 1,
          )),
    );
  }

  @override
  void initState() {
    getCurrentDate();
    _scrollController = ScrollController();
    tabController = new TabController(
      vsync: this,
      length: 1,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    List<String> title = ["Week 1", "Week 2", "Week 3", "Week 4"];
    getWeekTile(int index, bool isDark) {
      getDay(String day, int currIndex) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
              child: currIndex == currentDay
                  ? DashedCircle(
                      color: Colors.blue.shade700,
                      child: CircleAvatar(
                          child: Text(day,
                              style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontWeight: FontWeight.w700)),
                          radius: 16,
                          backgroundColor: Colors.transparent))
                  : currIndex > currentDay
                      ? DashedCircle(
                          color:isDark? Colors.grey.shade500:Colors.grey.shade300,
                          dashes: 111,
                          child: CircleAvatar(
                              child: Text(
                                day,
                                style: TextStyle(color: Colors.grey.shade400),
                              ),
                              radius: 16,
                              backgroundColor: Colors.transparent))
                      : CircleAvatar(
                          backgroundColor: Colors.blue.shade700,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                          radius: 16,
                        ),
              borderRadius: BorderRadius.all(Radius.circular(40)),
              onTap: () => currIndex <= currentDay
                  ? onComplete(currIndex)
                  :  onComplete(currIndex)
          )
            //TODO: uncomment below code
              //constants.getToast("Please complete previous challenges first")),
        );
      }

      getArrow(int currIndex) {
        return Padding(
          padding: const EdgeInsets.all(1.0),
          child: Icon(
            Icons.arrow_forward_ios,
            color: currIndex >= currentDay
                ? Colors.grey.shade400
                : Colors.blue.shade700,
            size: 16,
          ),
        );
      }

      getTrophy(int presentDay, int index){
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Icon(Entypo.trophy,size: 50,color:presentDay<currentDay?Colors.amber:isDark? Colors.grey.shade500:Colors.grey.shade400.withOpacity(.7),
            ),
            Center(child: Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: Text(index.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13),),
            ))
          ],
        );
      }

      return Container(
        child: Card(
          color: isDark ? constants.darkSecondary:Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
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
                  getArrow(index + 0),
                  getDay("2", index + 1),
                  getArrow(index + 1),
                  getDay("3", index + 2),
                  getArrow(index + 2),
                  getDay("4", index + 3)
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getDay("5", index + 4),
                  getArrow(index + 4),
                  getDay("6", index + 5),
                  getArrow(index + 5),
                  getDay("7", index + 6),
                  getArrow(index + 6),
                  getTrophy(index,(index~/7)+1),

                ],
              ),
              SizedBox(
                height: 10,
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
                if (index <= (currentDay / 7).floor()) {
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
                    size: 14,
                    color: Colors.white,
                  ),
                  size: 20,
                );
              },
              connectorBuilder: (_, index, ___) {
                if (index <= (currentDay / 7).floor()+1) {
                  return SolidLineConnector(color: Colors.blue.shade700);
                } else
                  return DashedLineConnector(
                    color: Colors.grey,
                    dash: 1,
                  );
              },
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

                getSubTitle(int index) {
                  int dayValue = currentDay + 1;
                  int indexValue = (index+1)*7;
                 if((dayValue/indexValue)>=1){
                   return "7 / 7";
                 }else{
                   if((indexValue - dayValue) <=7){
                     return "${(dayValue % 7) } / 7";
                   }else{
                     return "";
                   }
                 }
                }

                return Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            title[index],
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .merge(TextStyle(fontSize: 16)),
                          ),Spacer(),
                          Text(getSubTitle(index),style: TextStyle(color: Colors.blue.shade700,fontWeight: FontWeight.w700),),
                          SizedBox(width: 10,)
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: getWeekTile(indexIndex,isDark),
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
      body: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor:
                        isDark ? Colors.black : Colors.blue.shade700,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: Text(item.title),
                    elevation: 0,
                    centerTitle: false,
                    expandedHeight: 190.0,
                    collapsedHeight: 60,
                    pinned: true,
                    floating: false,
                    forceElevated: innerBoxIsScrolled,
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
                          width: MediaQuery.of(context).size.width * .9,
                          bottom: 20,
                          left: 20,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${28-currentDay} day left",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${currentDay + 1} / 28",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              LinearPercentIndicator(
                                percent: currentDay / 28,
                                lineHeight: 10,
                                animation: true,
                                progressColor: Colors.blue.shade700,
                                backgroundColor: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ];
              },
              body: Scaffold(
                backgroundColor: isDark ? Colors.black : Colors.white,
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
                      onPressed: ()=>onComplete(currentDay),
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
                          height: 100,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
