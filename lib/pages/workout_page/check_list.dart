import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/widgets/custom_exercise_card.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../main.dart';

class CheckListScreen extends StatefulWidget {
  final List<Workout> workOutList;
  final String title;
  final double progress;
  final String tag;

  CheckListScreen(
      {@required this.workOutList,
      @required this.tag,
      @required this.progress,
      @required this.title});

  @override
  _ExerciseListScreenState createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<CheckListScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  List<int> rapList = [];
  ScrollController _scrollController;
  List<String> items;
  TabController tabContoller;
  double padValue = 1;

  getTime() {
    int length = widget.workOutList.length;
    if (length < 15) return length + 2;
    if (length < 20) return length + 4;
    return length + 6;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    tabContoller = new TabController(vsync: this, length: 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    tabContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int time;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: Container(
          padding: EdgeInsets.only(bottom: 0.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton.extended(
              backgroundColor: Colors.blue.shade700,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 30,
              ),
              label: Text(
                "Continue",
                style: textTheme.button
                    .copyWith(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ),
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                backgroundColor: Colors.blue.shade700,
                automaticallyImplyLeading: false,
                expandedHeight: 150.0,
                pinned: true,
                floating: false,
                forceElevated: innerBoxIsScrolled,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(widget.title),
                  background: Image.asset(
                    "assets/cover/back-cover.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ];
          },
          body: Scaffold(
            body: TabBarView(
              controller: tabContoller,
              children: [
                ListView.builder(
                  itemBuilder: (context, index) {
                    if (widget.workOutList[index].showTimer == false) {
                      List<String> splitTitle = widget.title.split(" ");
                      if (splitTitle.length == 5) {
                        int currDay = int.tryParse(splitTitle[4]);
                        print(currDay);
                        if (currDay <= 10) {
                          time = widget.workOutList[index].beginnerRap;
                        } else if (currDay <= 20) {
                          time =
                              widget.workOutList[index].intermediateRap;
                        } else
                          time = widget.workOutList[index].advanceRap;
                      } else {
                        String tag = widget.tag.toLowerCase();
                        if (tag == 'beginner') {
                          time = widget.workOutList[index].beginnerRap;
                        } else if (tag ==
                            "intermediate") {
                          time =
                              widget.workOutList[index].intermediateRap;
                        } else
                          time = widget.workOutList[index].advanceRap;
                      }
                    } else if (widget.workOutList[index].showTimer ==
                        true) {
                      time = widget.workOutList[index].duration;
                    } else {
                      time = 30;
                    }
                    rapList.add(time);

                    return
                      Column(
                        children: [
                          if (index == 0)
                            AnimatedPadding(
                              duration: Duration(milliseconds: 400),
                              padding: EdgeInsets.only(
                                  left: padValue * 20,
                                  right: padValue,
                                  top: padValue * 8,
                                  bottom: padValue * 8),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 6,
                                    backgroundColor: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.workOutList.length.toString() +
                                        " Workouts",
                                    style: textTheme.headline6.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  CircleAvatar(
                                    radius: 6,
                                    backgroundColor: Colors.orange,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    getTime().toString() + " Minutes",
                                    style: textTheme.headline6.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          if (index == 0)
                            Divider(
                              thickness: .5,
                            ),
                          AnimatedPadding(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.easeOutCubic,
                            padding: EdgeInsets.only(
                                top: padValue * 1,
                                left: padValue * 1,
                                right: padValue * 1),
                            child: CustomExerciseCard(
                              index: index,
                              workOutList: widget.workOutList,
                              time: time,
                            ),
                          ),
                          Divider(
                            thickness: .5,
                          ),
                        ],
                      );
                  },
                  padding: EdgeInsets.only(bottom: 100),
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.workOutList.length,
                )
              ],
            ),
          ),
        ));
  }
}
