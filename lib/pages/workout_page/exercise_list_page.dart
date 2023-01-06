import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../database/workout_list.dart';
import '../../helper/sp_helper.dart';
import '../../helper/sp_key_helper.dart';
import '../../widgets/custom_exercise_card.dart';
import '../../widgets/custom_rounded_button.dart';
import 'exercise_instruction_screen.dart';

class ExerciseListScreen extends StatefulWidget {
  final List<Workout> workOutList;
  final String tag;
  final String title;
  final int tagValue;
  final String imgSrc;

  ExerciseListScreen(
      {required this.workOutList,
      required this.tag,
      required this.tagValue,
      required this.title,
      required this.imgSrc});

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
  late ScrollController _scrollController;
  late List<String> items;
  late TabController tabContoller;
  int pushUpIndex = 1;
  bool isLoading = true;
  bool lastStatus = true;
  String coverImgPath = "assets/workout_list_cover/arms.jpg";
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

  getWorkoutList() {
    for (int index = 0; index < widget.workOutList.length; index++) {
      if (widget.workOutList[index].showTimer == false) {
        List<String> splitTitle = widget.title.split(" ");
        if (splitTitle.length == 5) {
          int currDay = int.tryParse(splitTitle[4])!;
          print(currDay);
          if (currDay <= 10) {
            time = widget.workOutList[index].beginnerRap ?? 8;
          } else if (currDay <= 20) {
            time = widget.workOutList[index].intermediateRap ?? 10;
          } else
            time = widget.workOutList[index].advanceRap ?? 14;
        } else {
          String tag = widget.tag.toLowerCase();
          if (tag == 'beginner') {
            time = widget.workOutList[index].beginnerRap ?? 8;
          } else if (tag == "intermediate") {
            time = widget.workOutList[index].intermediateRap ?? 10;
          } else
            time = widget.workOutList[index].advanceRap ?? 14;
        }
      } else if (widget.workOutList[index].showTimer == true) {
        time = widget.workOutList[index].duration ?? 30;
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

  getCountDown() async {
    countDownTime = await spHelper.loadDouble(spKey.countdownTime) ?? 10;
    restTime = await spHelper.loadDouble(spKey.trainingRest) ?? 30;
  }

  getPushUpLevel() async {
    pushUpIndex = await spHelper.loadInt(spKey.pushUpLevel) ?? 1;
  }

  String getDifficulty() {
    List<String> tagList = widget.tag.split(" ");
    int length = tagList.length;
    if (length > 1 && length == 2) {
      return tagList[1];
    }

    if (length <= 10) {
      return "Beginner";
    } else if (length <= 16) {
      return "Intermediate";
    } else {
      return "Advance";
    }

  }

  getCoverImage() {
    String tag = widget.title.toLowerCase();
    if (tag.contains("abs")) {
      coverImgPath = "assets/workout_list_cover/abs.jpg";
    } else if (tag.contains("shoulder")) {
      coverImgPath = "assets/workout_list_cover/shoulder.jpg";
    } else if (tag.contains("legs")) {
      coverImgPath = "assets/workout_list_cover/legs.jpg";
    } else if (tag.contains("chest")) {
      coverImgPath = "assets/workout_list_cover/chest.jpg";
    } else if (tag.contains("arms")) {
      coverImgPath = "assets/workout_list_cover/arms.jpg";
    } else {
      coverImgPath = "assets/workout_list_cover/legs.jpg";
    }
  }

  getTitle() {
    List<String> curr = widget.title.split(" ");
    if (curr.length == 5 && curr[0].toLowerCase() != "full") {
      title = "${curr[0]} ${curr[1]} ${curr[3]} ${curr[4]}";
    } else {
      title = widget.title;
    }
  }

  loadData() async {
    await getCountDown();
    await getPushUpLevel();
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
    bool isDark = Theme.of(context).textTheme.bodyText1!.color == Colors.white;

    buildChip({
      required String title,
      required IconData icon,
    }) {
      return Expanded(
          child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        color: Colors.blue.withOpacity(.2),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(.8)),
                SizedBox(
                  width: 8,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(.8)),
                ),
              ],
            ),
          ],
        ),
      ));
    }

    return Scaffold(
        bottomNavigationBar: Material(
          elevation: 5,
          color: Theme.of(context).bottomAppBarColor,
          child: Container(
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 18)
                  .copyWith(bottom: 16, top: 12),
              child: RoundedIconButton(
                icon: Icons.play_arrow,
                title: "Start Workout".toUpperCase(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InstructionScreen(
                        tag: widget.tag,
                        title: widget.title,
                        workOutList: widget.workOutList,
                        rapList: rapList,
                        countDownTime: countDownTime.toInt(),
                        restTime: restTime.toInt(),
                      ),
                    ),
                  );
                },
              )),
        ),
        body: isLoading
            ? CircularProgressIndicator()
            : NestedScrollView(
                controller: _scrollController,
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
                      expandedHeight: 130.0,
                      pinned: true,
                      floating: false,
                      forceElevated: innerBoxIsScrolled,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          title,
                          style: TextStyle(
                            fontSize:isShrink?18: 16,
                              color: isDark
                                  ? Colors.white
                                  : isShrink
                                      ? Colors.black
                                      : Colors.white),
                        ),
                        background: Stack(
                          children: [
                            Image.asset(
                              widget.imgSrc,
                              fit: BoxFit.fill,
                              height: 120 +80,

                              width: double.infinity,
                            ),
                            Container(
                              color: Colors.black.withOpacity(.5),
                            )
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
                      Column(
                        children: [
                          Container(
                            height: 1,
                            color:
                                Theme.of(context).appBarTheme.backgroundColor,
                          ),
                          Row(
                            children: [
                              buildChip(
                                icon: Icons.timer_outlined,
                                title: "${getTime()} Minute",
                              ),
                              SizedBox(
                                width: 1,
                              ),
                              buildChip(
                                icon: Icons.library_books_outlined,
                                title: widget.workOutList.length.toString() +
                                    " Workout",
                              ),
                              SizedBox(
                                width: 1,
                              ),
                              buildChip(
                                icon: Icons.person_outline,
                                title: getDifficulty(),
                              ),
                            ],
                          ),


                          Expanded(
                            child: AnimationLimiter(
                              child: ListView.builder(
                                physics: isShrink ? BouncingScrollPhysics():ScrollPhysics(),
                                padding: EdgeInsets.only(top: 8),
                                itemCount: widget.workOutList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 605),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: Column(
                                          children: [
                                            CustomExerciseCard(
                                              index: index,
                                              workOutList: widget.workOutList,
                                              time: rapList[index],
                                            ),
                                            Divider(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ));
  }
}
