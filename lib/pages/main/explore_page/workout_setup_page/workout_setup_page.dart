import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../../../../helper/sp_helper.dart';
import '../../../../helper/sp_key_helper.dart';
import '../../../../models/explore_workout_model.dart';
import '../../../../provider/ads_provider.dart';
import '../../../../provider/subscription_provider.dart';
import '../../../../widgets/custom_exercise_card.dart';
import '../../../workout_page/exercise_instruction_screen.dart';
import '../widget/get_prime_bottom_modal.dart';

class WorkoutSetupPage extends StatefulWidget {
  final ExploreWorkout workout;
  final Widget header;

  const WorkoutSetupPage(
      {Key? key, required this.workout, required this.header})
      : super(key: key);

  @override
  State<WorkoutSetupPage> createState() => _WorkoutSetupPageState();
}

class _WorkoutSetupPageState extends State<WorkoutSetupPage>
    with TickerProviderStateMixin {
  double countDownTime = 10;
  double restTime = 30;
  bool isUnlocked = false;
  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();
  late ScrollController _scrollController;
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
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isProUser = isUnlocked ||
        Provider
            .of<AdsProvider>(context, listen: true)
            .isRewarded;

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

    List<int> rapList = widget.workout.getRapList;

    buildChip({
      required String title,
      required IconData icon,
    }) {
      return Expanded(
          child: Container(
        padding: EdgeInsets.symmetric(vertical: 18),
        color: Colors.amber.withOpacity(.3),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon,
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(.9)),
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
                          .bodyLarge!
                          .color!
                          .withOpacity(.9)),
                ),
              ],
            ),
          ],
        ),
      ));
    }

    bool isDark = Theme.of(context).textTheme.bodyLarge!.color == Colors.white;

    return Consumer<SubscriptionProvider>(builder: (context, data, _) {
      return Scaffold(
          bottomNavigationBar: Material(
            elevation: 5,
            color: Theme.of(context).bottomAppBarTheme.color,
            child: Container(
              height: 65,
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: isProUser
                  ? ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32))),
                          backgroundColor: Theme.of(context).primaryColor),
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
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32))), backgroundColor: Theme.of(context).primaryColor),
                      onPressed: getBottomSheet,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_arrow,
                            size: 32,
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
          body: NestedScrollView(
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
                  expandedHeight: 200.0,
                  pinned: true,
                  floating: false,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        widget.workout.title,
                        style: TextStyle(
                            fontSize: isShrink ? 20 : 16,
                            color: isDark
                                ? Colors.white
                                : isShrink
                                    ? Colors.black
                                    : Colors.white),
                      ),
                      background: widget.header),
                ),
              ];
            },
            body: Scaffold(
              body: Column(
                children: [
                  Container(
                    height: 1,
                    color: Theme.of(context).appBarTheme.backgroundColor,
                  ),
                  Row(
                    children: [
                      buildChip(
                        icon: Icons.timer_outlined,
                        title: "${widget.workout.getTime} Minute",
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      buildChip(
                        icon: Icons.library_books_outlined,
                        title: widget.workout.getExerciseCount,
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      buildChip(
                        icon: Icons.person_outline,
                        title: widget.workout.getWorkoutType,
                      ),
                    ],
                  ),
                  Container(
                    height: 1,
                    color: Theme.of(context).appBarTheme.backgroundColor,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics:
                          isShrink ? BouncingScrollPhysics() : ScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.workout.description.isNotEmpty)
                            Column(
                              children: [
                                SizedBox(
                                  height: 16,
                                ),
                                ...widget.workout.description
                                    .map((desc) => Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12.0,
                                              right: 12,
                                              bottom: 12),
                                          child: Text(
                                            desc,
                                            style: TextStyle(
                                                fontSize: 15,
                                                letterSpacing: 1.2,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .color!
                                                    .withOpacity(.8)),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ))
                                    .toList(),
                                SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  height: 16,
                                  color: Colors.grey.withOpacity(.1),
                                ),
                              ],
                            ),
                          SizedBox(
                            height: 12,
                          ),
                          ListView.separated(
                            padding: EdgeInsets.only(bottom: 12),
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12),
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
                  ),
                ],
              ),
            ),
          ));
    });
  }
}
