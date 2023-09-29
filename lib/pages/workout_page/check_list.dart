import 'package:flutter/material.dart';
import '../../../database/workout_list.dart';
import '../../../widgets/custom_exercise_card.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CheckListScreen extends StatefulWidget {
  final List<Workout> workOutList;
  final String tag;
  final String title;
  final int currentWorkout;

  CheckListScreen(
      {required this.workOutList,
      required this.tag,
      required this.title,
      required this.currentWorkout});

  @override
  _ExerciseListScreenState createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<CheckListScreen>
    with TickerProviderStateMixin {
  List<int> rapList = [];
  late List<String> items;
  late TabController tabContoller;
  double padValue = 0;
  bool isLoading = true;
  bool lastStatus = true;
  String coverImgPath = "assets/workout_list_cover/arms.jpg";
  String title = "";
  int time = 20;

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
    getWorkoutList();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).textTheme.bodyLarge!.color == Colors.white;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: Container(
          padding: EdgeInsets.only(bottom: 0.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton.extended(
              backgroundColor: Colors.blue.shade700,
              onPressed: () => Navigator.of(context).pop(),
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
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              SizedBox(
                height: 2,
              ),
              Text(
                "${widget.currentWorkout}/${widget.workOutList.length} exercise completed",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(.6)),
              )
            ],
          ),
          elevation: 0,
        ),
        body: Column(
          children: [
            LinearPercentIndicator(
              padding: EdgeInsets.all(0),
              animation: true,
              lineHeight: 5.0,
              percent: widget.currentWorkout / widget.workOutList.length,
              backgroundColor:
                  isDark ? Colors.grey.shade800 : Colors.blue.shade50,
              progressColor: isDark ? Colors.blue : Colors.blue.shade700,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      if (index == 0)
                        Container(
                          height: 12,
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
              ),
            ),
          ],
        ));
  }
}
