import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/widgets/custom_exercise_card.dart';

import '../../main.dart';
import 'exercise_instruction_screen.dart';

class ExerciseListScreen extends StatefulWidget {
  final List<Workout> workOutList;
  final String tag;
  final String title;
  final int tagValue;

  ExerciseListScreen(
      {required this.workOutList,
      required this.tag,
      required this.tagValue,
      required this.title});

  @override
  _ExerciseListScreenState createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen>
    with TickerProviderStateMixin {
  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();
  List<int> rapList = [];
  double countDownTime = 30;
  double restTime = 30;
  final TextEditingController searchQuery = new TextEditingController();
 late ScrollController _scrollController;
  late List<String> items;
 late TabController tabContoller;
  double padValue = 0;
  int pushUpIndex = 1;
  bool isLoading = true;
  bool lastStatus = true;
  String coverImgPath ="assets/workout_list_cover/arms.jpg";
  String title = "";
  int time = 20;

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

  getWorkoutList(){
    for( int index = 0; index <widget.workOutList.length; index++){
      if (widget.workOutList[index].showTimer == false) {
        List<String> splitTitle = widget.title.split(" ");
        if (splitTitle.length == 5) {
          int currDay = int.tryParse(splitTitle[4])!;
          print(currDay);
          if (currDay <= 10) {
            time = widget.workOutList[index].beginnerRap??0;
          } else if (currDay <= 20) {
            time =
                widget.workOutList[index].intermediateRap??0;
          } else
            time = widget.workOutList[index].advanceRap??0;
        } else {
          String tag = widget.tag.toLowerCase();
          if (tag == 'beginner') {
            time = widget.workOutList[index].beginnerRap??0;
          } else if (tag ==
              "intermediate") {
            time =
                widget.workOutList[index].intermediateRap??0;
          } else
            time = widget.workOutList[index].advanceRap??0;
        }
      } else if (widget.workOutList[index].showTimer ==
          true) {
        time = widget.workOutList[index].duration??0;
      } else {
        time = 30;
      }
      rapList.add(time);
    }
  }

  getTime() {
    int length = widget.workOutList.length;
    if (length < 15) return length + 2;
    if (length < 20) return length + 4;
    return length + 6;
  }

  getPadding() async {
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      setState(() {
        padValue = 1;
      });
    });
  }

  getCountDown() async {
    countDownTime = await spHelper.loadDouble(spKey.countdownTime) ?? 10;
    restTime = await spHelper.loadDouble(spKey.trainingRest) ?? 30;
  }

  getPushUpLevel() async {
    pushUpIndex = await spHelper.loadInt(spKey.pushUpLevel) ?? 1;
  }

  getCoverImage(){
    String tag = widget.title.toLowerCase();
   if(tag.contains("abs")){
     coverImgPath = "assets/workout_list_cover/abs.jpg";
   }else if(tag.contains("shoulder")){
     coverImgPath="assets/workout_list_cover/shoulder.jpg";
   }else if(tag.contains("legs")){
     coverImgPath = "assets/workout_list_cover/legs.jpg";
   }else if(tag.contains("chest")){
     coverImgPath = "assets/workout_list_cover/chest.jpg";
   }else if(tag.contains("arms")){
     coverImgPath = "assets/workout_list_cover/arms.jpg";
   }else{
     coverImgPath = "assets/workout_list_cover/legs.jpg";
   }
  }

  getTitle(){
   List<String> curr =widget.title.split(" ");
   if(curr.length == 5 && curr[0].toLowerCase() != "full"){
      title = "${curr[0]} ${curr[1]} ${curr[3]} ${curr[4]}";
   }else{
     title = widget.title;
   }
  }

  loadData() async {
    await getCountDown();
    await getPushUpLevel();
    await getPadding();
    getWorkoutList();
    getTitle();
    getCoverImage();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
    _scrollController = new ScrollController();
    _scrollController.addListener(_scrollListener);
    tabContoller = new TabController(vsync: this, length: 1);
  }

  @override
  void dispose() {
    tabContoller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: Container(
          padding: EdgeInsets.only(bottom: 0.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child:FloatingActionButton.extended(
              backgroundColor: Colors.blue.shade700,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InstructionScreen(
                      tag: widget.tag,
                      tagValue: widget.tagValue,
                      title: widget.title,
                      workOutList: widget.workOutList,
                      rapList: rapList,
                      countDownTime: countDownTime.toInt(),
                      restTime: restTime.toInt(),
                    ),
                  ),
                );
              },
              icon: Icon(
                 Icons.local_fire_department_sharp,
                color: Colors.white,
                size: 30,
              ),
              label: Text(
                "Start Workout",
                style: textTheme.button
                    !.copyWith(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ),
        body: isLoading
            ? CircularProgressIndicator()
            : NestedScrollView(
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: isDark ? Colors.black : Colors.white,
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: isDark
                              ? Colors.white
                              : isShrink
                                  ? Colors.black
                                  : Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),

                      expandedHeight: 150.0,
                      pinned: true,
                      elevation: isDark ? 0 : 1,
                      floating: false,
                      forceElevated: innerBoxIsScrolled,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          title,
                          style: TextStyle(
                              color: isDark
                                  ? Colors.white
                                  : isShrink
                                      ? Colors.black
                                      : Colors.white),
                        ),
                        background: Image.asset(
                          coverImgPath,
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
                                  style: textTheme.headline2!.copyWith(
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
                                        style: textTheme.headline2!.copyWith(
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
                                  time: rapList[index],
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
