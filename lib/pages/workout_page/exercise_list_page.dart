import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/helper/light_dark_mode.dart';
import 'package:full_workout/widgets/achivement.dart';
import 'package:full_workout/widgets/custom_exercise_card.dart';

import 'exercise_instruction_screen.dart';

class ExerciseListScreen extends StatefulWidget {
  final List<Workout> workOutList;
  final String tag;
  final String title;
  final int tagValue;


  ExerciseListScreen(
      {@required this.workOutList,
      @required this.tag,
      @required this.tagValue,
      @required this.title});

  @override
  _ExerciseListScreenState createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _colorAnim;
  List<int> rapList = [];

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )
      ..forward()
      ..repeat();

    _colorAnim = bgColor.animate(_controller);
    _scrollController = new ScrollController();
    tabContoller = new TabController(
      vsync: this,
      length: 1,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    tabContoller.dispose();
    super.dispose();
  }

  Animatable<Color> bgColor = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Colors.red, end: Colors.blue),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Colors.orangeAccent, end: Colors.green),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Colors.green, end: Colors.amberAccent),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Colors.amberAccent, end: Colors.red),
    ),
  ]);

  final TextEditingController searchQuery = new TextEditingController();
  ScrollController _scrollController;
  List<String> items;
  TabController tabContoller;

  @override
  Widget build(BuildContext context) {

    int time;
    return Scaffold(
        backgroundColor: Colors.blue,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: Container(
          padding: EdgeInsets.only(bottom: 0.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child:FloatingActionButton.extended(
              backgroundColor: Colors.blue.shade700,
              onPressed: () {
                widget.tag == "continue"
                    ? Navigator.of(context).pop()
                    : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InstructionScreen(
                      tag: widget.tag,
                      tagValue: widget.tagValue,
                      title: widget.title,
                      workOutList: widget.workOutList,
                      rapList:rapList,
                    ),
                  ),
                );
              },
              icon: Icon(
                widget.tag == "continue"
                    ? Icons.play_arrow
                    : Icons.local_fire_department_sharp,
                color: Colors.white,
                size: 30,
              ),
              label: Text(
                widget.tag == "continue" ? "Continue" : "Start Workout",
                style: textTheme.button.copyWith(fontSize: 16),
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ),
        body: SafeArea(
            child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                leading: IconButton(
                  icon: Icon(widget.tag == "continue"
                      ? Icons.close_rounded
                      : Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                actions: [
                  widget.tag == "continue"
                      ? Padding(
                          padding: const EdgeInsets.only(top: 18.0, right: 8),
                          child: Text(
                            "2/3",
                            style: textTheme.bodyText1
                                .copyWith(fontSize: 16, color: Colors.amber),
                          ),
                        )
                      : Text("")
                ],
                title: Expanded(
                    child: Text(
                  widget.title,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
                  textAlign: TextAlign.start,
                  textScaleFactor: 1,
                )), titleSpacing: 010,
                automaticallyImplyLeading: false,
                expandedHeight: 190.0,
                pinned: true,
                floating: false,
                forceElevated: innerBoxIsScrolled,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(children: <Widget>[
                    Column(
                      children: [
                        Container(
                          height: 50,
                        ),
                        Container(
                          child: Achievement(
                            timeTitle: "Time",
                            timeValue: Duration(
                                    seconds: (widget.workOutList.length * 30))
                                .inMinutes,
                            caloriesTitle: "Calories",
                            caloriesValue: 14,
                            exerciseTitle: "Exercise",
                            exerciseValue: widget.workOutList.length,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ],
                    )
                  ]),
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
                      if (widget.tag.toLowerCase() == 'beginner') {
                        time = widget.workOutList[index].beginnerRap;
                      } else if (widget.tag.toLowerCase() == "intermediate") {
                        time = widget.workOutList[index].intermediateRap;
                      } else
                        time = widget.workOutList[index].advanceRap;
                    } else if(widget.workOutList[index].showTimer == true) {
                      time = widget.workOutList[index].duration;
                    }else{
                      time = 69;
                    }

                    rapList.add(time);

                    print(time);
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: CustomExerciseCard(
                        index: index,
                        workOutList: widget.workOutList,
                        time: time,
                      ),
                    );
                  },
                  padding: EdgeInsets.only(bottom: 70),
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.workOutList.length,
                )
              ],
            ),
          ),
        )));
  }
}
