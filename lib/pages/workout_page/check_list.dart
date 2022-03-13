import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/widgets/custom_exercise_card.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


class CheckListScreen extends StatefulWidget {
  final List<Workout> workOutList;
  final String tag;
  final String title;
  final double progress;

  CheckListScreen(
      {required this.workOutList,
       required this.tag,
       required this.progress,
       required this.title});

  @override
  _ExerciseListScreenState createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<CheckListScreen>
    with TickerProviderStateMixin {
  List<int> rapList = [];
  late ScrollController _scrollController;
  late List<String> items;
  late TabController tabContoller;
  double padValue = 0;
  bool isLoading = true;
  bool lastStatus = true;
  String coverImgPath ="assets/workout_list_cover/arms.jpg";
  String title = "";

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
    await getPadding();
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
    bool isDark = Theme.of(context).textTheme.bodyText1!.color == Colors.white;

    int time;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: Container(
          padding: EdgeInsets.only(bottom: 0.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child:FloatingActionButton.extended(
              backgroundColor: Colors.blue.shade700,
              onPressed: () =>Navigator.of(context).pop(),
              icon: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 30,
              ),
              label: Text(
                "Continue",
                style: TextStyle(fontSize: 16, color: Colors.white),
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
                  background: Column(
                    children: [
                   Expanded(
                     child:
                     Container(
                       width:double.infinity,
                       child: Image.asset(
                              coverImgPath,
                              fit: BoxFit.cover,
                            ),
                     ),
                   ),
                      
                      LinearPercentIndicator(
                        padding: EdgeInsets.all(0),
                        animation: true,
                        lineHeight: 5.0,
                        percent: widget.progress,
                        backgroundColor:isDark?Colors.grey.shade800: Colors.blue.shade50,
                        linearStrokeCap: LinearStrokeCap.round,
                        progressColor:isDark? Colors.blue:Colors.blue.shade700,
                      ),
                    ],
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
                        int currDay = int.tryParse(splitTitle[4])!;

                        if (currDay <= 10) {
                          time = widget.workOutList[index].beginnerRap!;
                        } else if (currDay <= 20) {
                          time =
                              widget.workOutList[index].intermediateRap!;
                        } else
                          time = widget.workOutList[index].advanceRap!;
                      } else {
                        String tag = widget.tag.toLowerCase();
                        if (tag == 'beginner') {
                          time = widget.workOutList[index].beginnerRap!;
                        } else if (tag ==
                            "intermediate") {
                          time =
                              widget.workOutList[index].intermediateRap!;
                        } else
                          time = widget.workOutList[index].advanceRap!;
                      }
                    } else if (widget.workOutList[index].showTimer ==
                        true) {
                      time = widget.workOutList[index].duration!;
                    } else {
                      time = 30;
                    }
                    rapList.add(time);

                    return
                      Column(
                        children: [
                


                    if (index == 0)
                            Container(height: 12,),
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
