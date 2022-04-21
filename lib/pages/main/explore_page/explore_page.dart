import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/database/workout_plan/abs_challenges.dart';
import 'package:full_workout/database/workout_plan/arm_challenges.dart';
import 'package:full_workout/database/workout_plan/chest_challenge.dart';
import 'package:full_workout/database/workout_plan/full_body_challenge.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/models/challenges_model.dart';
import 'package:full_workout/pages/main/explore_page/four_week_challenges_page/workout_time_line.dat.dart';
import 'package:full_workout/pages/main/home_page/leading_widget.dart';
import 'package:full_workout/provider/ads_provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'explore_page_widget/2by2_card.dart';
import 'explore_page_widget/four_week_challenge_card.dart';
import 'explore_page_widget/sleep_workout.dart';

class ExplorePage extends StatefulWidget {
  final Function onBack;

  ExplorePage({required this.onBack});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () => widget.onBack(),
      child: Scaffold(
        appBar: AppBar(

          elevation: .5,
          automaticallyImplyLeading: false,
          actions:[ ...getLeading(context)],
          titleSpacing: 14,
          title: Text(
            "Explore",
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(14),
           physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              FourWeekChallengeCard(),
              SizedBox(height: 20,),
              WorkoutCard2by2(title:"Picks for you"),
              SizedBox(height: 20,),
              SleepWorkoutSection(title: "Sleep"),
              SizedBox(height: 10,),
              FourWeekChallengeCard(),
              SizedBox(height: 20,),
              WorkoutCard2by2(title:"Fast workout"),
              SizedBox(height: 20,),
              SleepWorkoutSection(title: "Sleep"),

            ],
          )
        ),
      ),
    );}
}