import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../../helper/sp_helper.dart';
import '../../../../helper/sp_key_helper.dart';
import '../../../../pages/main/explore_page/workout_setup_page/widget/get_prime_modal.dart';
import '../../../../provider/ads_provider.dart';
import '../../../../provider/subscription_provider.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../../../../models/explore_workout_model.dart';
import '../../../../widgets/custom_exercise_card.dart';
import '../../../workout_page/exercise_instruction_screen.dart';

class WorkoutSetupPage extends StatefulWidget {
  final ExploreWorkout workout;
  final Widget header;

  const WorkoutSetupPage(
      {Key? key, required this.workout, required this.header})
      : super(key: key);

  @override
  State<WorkoutSetupPage> createState() => _WorkoutSetupPageState();
}

class _WorkoutSetupPageState extends State<WorkoutSetupPage> {
  double countDownTime = 10;
  double restTime = 30;
  bool isUnlocked = false;
  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();

  getCountDown() async {
    countDownTime = await spHelper.loadDouble(spKey.countdownTime) ?? 10;
    restTime = await spHelper.loadDouble(spKey.trainingRest) ?? 30;
  }

  checkProUser() async {
    Provider.of<AdsProvider>(context, listen: false).isRewarded = false;
    isUnlocked = await Provider.of<AdsProvider>(context, listen: false)
        .isUnlocked(key: widget.workout.title, context: context);
    setState(() {});
    log("success");
  }

  @override
  void initState() {
    getCountDown();
    checkProUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isProUser = isUnlocked ||
        Provider.of<AdsProvider>(context, listen: true).isRewarded;

    void getBottomSheet() async {
      showSlidingBottomSheet(context, builder: (context) {
        return SlidingSheetDialog(
          elevation: 8,
          cornerRadius: 16,
          padding: EdgeInsets.symmetric(horizontal: 18),
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          builder: (context, state) {
            return GetPrimeBottomSheet(
              spKey: widget.workout.title,
            );
          },
        );
      });
    }

    buildChip(
        {required String title, required IconData icon, required Color color}) {
      bool isDark =
          Theme.of(context).textTheme.bodyText1!.color == Colors.white;
      return Container(
          margin: EdgeInsets.only(right: 8, bottom: 10),
          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 7),
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(.1),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isDark ? Colors.white70 : Colors.black.withOpacity(.6),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color:
                        isDark ? Colors.white70 : Colors.black.withOpacity(.7)),
              ),
              SizedBox(
                width: 2,
              ),
            ],
          ));
    }

    List<int> rapList = widget.workout.getRapList;

    return Consumer<SubscriptionProvider>(builder: (context, data, _) {
      return Scaffold(
        bottomNavigationBar: Material(
          elevation: 5,
          color: Theme.of(context).bottomAppBarColor,
          child: Container(
            height: 65,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: isProUser
                ? ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InstructionScreen(
                            tag: widget.workout.getWorkoutType,
                            title: widget.workout.title,
                            workOutList: widget.workout.workoutList,
                            rapList: rapList,
                            countDownTime: countDownTime.toInt(),
                            restTime: restTime.toInt(),
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.play_arrow_outlined,
                      size: 28,
                    ),
                    label: Text(
                      "Start Workout".toUpperCase(),
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                    onPressed: getBottomSheet,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_arrow,
                          size: 28,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Unlock".toUpperCase(),
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    )),
          ),
        ),
        appBar: AppBar(
          title: Text(widget.workout.title),
          //    actions: [TextButton(onPressed: () {}, child: Text("PRO"))],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: widget.header,
              ),
              SizedBox(
                height: 18,
              ),
              ...widget.workout.description
                  .map((desc) => Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, right: 12, bottom: 12),
                        child: Text(
                          desc,
                          style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 1.2,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color!
                                  .withOpacity(.8)),
                          textAlign: TextAlign.justify,
                        ),
                      ))
                  .toList(),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  children: [
                    buildChip(
                      color: Colors.blueGrey,
                      icon: Icons.timer_outlined,
                      title: "Time : ${widget.workout.getTime} Minute",
                    ),
                    buildChip(
                      color: Colors.blueGrey,
                      icon: Icons.library_books_outlined,
                      title: "Total : ${widget.workout.getExerciseCount}",
                    ),
                    buildChip(
                      color: Colors.blueGrey,
                      icon: Icons.person_outline,
                      title: "Difficulty : ${widget.workout.getWorkoutType}",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                height: 16,
                color: Colors.grey.withOpacity(.1),
              ),
              SizedBox(
                height: 16,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.workout.workoutList.length,
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemBuilder: (context, index) {
                    return isProUser
                        ? CustomExerciseCard(
                            index: index,
                            time: rapList[index],
                            workOutList: widget.workout.workoutList,
                          )
                        : Container(
                            height: 70,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Exercise ${index + 1}",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                )),
                          );
                  })
            ],
          ),
        ),
      );
    });
  }
}
