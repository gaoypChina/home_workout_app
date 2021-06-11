import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/database/workoutlist.dart';
import 'package:full_workout/widgets/achivement.dart';
import 'package:full_workout/widgets/custom_exercise_card.dart';

import 'instruction_screen.dart';

class ExerciseListScreen extends StatefulWidget {
  final List<WorkoutList> workOutList;
  final String tag;
  final String title;
  final int stars;

  ExerciseListScreen({
    @required this.workOutList,
    @required this.tag,
    @required this.stars,
    @required this.title
    
  });

  @override
  _ExerciseListScreenState createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _scrollController = new ScrollController();
    tabContoller = new TabController(
      vsync: this,
      length: 1,
    );
    super.initState();
  }

  final TextEditingController searchQuery = new TextEditingController();
  ScrollController _scrollController;
  List<String> items;
  TabController tabContoller;

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    int time;
    return Scaffold(
      backgroundColor: Colors.blue,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: Container(

          padding: EdgeInsets.only(bottom: 0.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InstructionScreen(
                      title: widget.title,
                      rap: time,
                      workOutList: widget.workOutList,
                      stars: widget.stars,
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.play_arrow,
                size: 40,
              ),
              label: Text(
                "Start Workout",
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

                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                title: Expanded(
                    child: Text(
                  widget.tag,
                  style: TextStyle(

                      fontWeight: FontWeight.w800,
                      fontSize: 22),
                  textAlign: TextAlign.start,
                  textScaleFactor: 1,
                )),
//collapsedHeight: 55,
                titleSpacing: 010,
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
//     child: Text(widget.tag),
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
          body:
          Scaffold(

            body:
            TabBarView(
              controller: tabContoller,
              children: [
                ListView.builder(
                  itemBuilder: (context, index) {
                    if (widget.workOutList[index].showTimer == null) {
                      if (widget.tag == 'Beginner') {
                        time = widget.workOutList[index].beginnerRap;
                      } else if (widget.tag == "Intermediate") {
                        time = widget.workOutList[index].advanceRap;
                      } else
                        time = widget.workOutList[index].advanceRap;
                    } else {
                      time = 30;
                    }
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child:
                      CustomExerciseCard(
                        title: widget.workOutList[index].title,
                        imgUrl: widget.workOutList[index].imageSrc,
                        time: time,
                        steps: widget.workOutList[index].steps,
                        link: widget.workOutList[index].videoLink,
                      ),
                    );
                  },
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.workOutList.length,
                )
              ],
            ),
          ),

        )));
  }
}
