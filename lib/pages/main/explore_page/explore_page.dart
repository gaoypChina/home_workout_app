import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/pages/main/explore_page/explore_page_widget/fast_workout.dart';
import 'package:full_workout/pages/main/home_page/leading_widget.dart';

import 'explore_page_widget/1by1_workout_card.dart';
import 'explore_page_widget/beginner_workout_challenges.dart';
import 'explore_page_widget/body_focus_workout.dart';
import 'explore_page_widget/discover_workout.dart';
import 'explore_page_widget/four_week_challenge_card.dart';
import 'explore_page_widget/picks_for_you_workout.dart';
import 'explore_page_widget/featured_workout.dart';
import 'explore_page_widget/strach_workout.dart';

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
        color: Colors.grey.withOpacity(.2),
        height: 14,
      );
    }

    return WillPopScope(
      onWillPop: () => widget.onBack(),
      child: Scaffold(
        appBar: AppBar(
          elevation: .5,
          automaticallyImplyLeading: false,
          actions: getLeading(context),
          titleSpacing: 14,
          title: Text(
            "Explore",
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          //  padding: EdgeInsets.all(14),
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12,
                ),
                FourWeekChallengeCard(),
                buildDivider(),
                PicksForYouWorkout(),
                buildDivider(),
                BeginnerWorkoutSection(),
                buildDivider(),
                FeaturedWorkout(title: "Sleep"),
                buildDivider(),
                HardCoreWorkout(),
                buildDivider(),
                StretchWorkout(),
                buildDivider(),
                FastWorkout(),
                buildDivider(),
                BodyFocusWorkout(),
                buildDivider(),
                TopPicksSection(),
                SizedBox(
                  height: 10,
                )
              ],
            )
        ),
      ),
    );}
}