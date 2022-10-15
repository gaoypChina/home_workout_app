import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:full_workout/pages/main/explore_page/widget/beginner_workout_challenges.dart';
import 'package:full_workout/pages/main/explore_page/widget/body_focus_workout.dart';
import 'package:full_workout/pages/main/explore_page/widget/daily_workout.dart';
import 'package:full_workout/pages/main/explore_page/widget/discover_all_workout.dart';
import 'package:full_workout/pages/main/explore_page/widget/discover_workout.dart';
import 'package:full_workout/pages/main/explore_page/widget/fast_workout.dart';
import 'package:full_workout/pages/main/explore_page/widget/four_week_challenge_card.dart';
import 'package:full_workout/pages/main/explore_page/widget/picks_for_you_workout.dart';
import 'package:full_workout/pages/main/explore_page/widget/strach_workout.dart';

import '../home_page/leading_widget.dart';


class ExplorePage extends StatefulWidget {
  final Function onBack;

  ExplorePage({required this.onBack});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    buildDivider() {
      return Container(
        margin: EdgeInsets.only(top: 16, bottom: 12),
        color: Colors.grey.withOpacity(.15),
        height: 14,
      );
    }

List<Widget> sections = [
  SizedBox(
    height: 12,
  ),
  FourWeekChallengeCard(),
  buildDivider(),
  PicksForYouWorkout(),
  buildDivider(),
  DailyWorkout(),
  buildDivider(),
  BeginnerWorkoutSection(),
  buildDivider(),
  DiscoverWorkout(),
  buildDivider(),
  StretchWorkout(),
  buildDivider(),
  FastWorkout(),
  buildDivider(),
  BodyFocusWorkout(),
  buildDivider(),
  DiscoverAllWorkouts(),
  SizedBox(
    height: 10,
  )
];

    return WillPopScope(
      onWillPop: () => widget.onBack(),
      child: Scaffold(
        appBar: AppBar(
          elevation: .5,
          automaticallyImplyLeading: false,
          actions: getLeading(context),
          titleSpacing: 14,
          title: Text("Explore"),
          centerTitle: false,
        ),
        body:
        AnimationLimiter(
          child: ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: sections.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 605),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: sections[index],
                  ),
                ),
              );
            },
          ),
        ),
      ),
       // AnimationLimiter(
          // child: SingleChildScrollView(
          //     physics: BouncingScrollPhysics(),
          //     child:
          //
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //
          //       ],
          //     )),
      //  ),
    //  ),
    );
  }
}
