import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/database/workout_plan/abs_challenges.dart';
import 'package:full_workout/database/workout_plan/arm_challenges.dart';
import 'package:full_workout/database/workout_plan/chest_challenge.dart';
import 'package:full_workout/database/workout_plan/full_body_challenge.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/pages/main/explore_page/workout_time_line.dat.dart';
import 'package:full_workout/pages/main/home_page/leading_widget.dart';

import '../../../main.dart';


class ExplorePage extends StatelessWidget {
  final Function onBack;




  ExplorePage({this.onBack});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    SpKey _spKey = SpKey();
    Constants constants = Constants();
    int i = 0;
    List<ChallengesModel> challenges = [
      ChallengesModel(
        title: "Full Body Challenge",
        tag: _spKey.fullBodyChallenge,
        currentDay: i,
        imageUrl: "assets/bg_cover/back-cover.png",
        challengeList: fullBodyChallenge,

        color1: Colors.blue.shade700,
        color2: Color(0xffb29f94),
      ),
      ChallengesModel(
          title: "Abs Workout Challenge",
          currentDay: i,
          tag: _spKey.absChallenge,

          imageUrl: "assets/splash/crunches.gif",
          challengeList: absChallenges,
          // color1: Colors.blue,
          color1: Colors.orange.shade300,
          color2: Colors.blue.shade700),
      ChallengesModel(
        tag: _spKey.chestChallenge,
          title: "Chest Workout Challenge",
          currentDay: i,
          imageUrl: "assets/all-workouts/cobraStratch.png",
          challengeList: chestChallenge,
          color1: Colors.blue.shade700,
          color2: Colors.teal),
      ChallengesModel(
          title: "Arm Workout Challenge",
          tag: _spKey.armChallenge,
          currentDay: i,
          imageUrl: "assets/all-workouts/cobraStratch.png",
          challengeList: armChallenges,
          color1: Colors.red.shade300,
          color2: Colors.blue.shade700),
    ];

    getCard(var item) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Ink(
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WorkoutTimeLine(
                            challengesModel: item,
                          )));
            },
            child: Container(
              height: height*.2,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [item.color1, item.color2],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Container(
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16)),
                      child: Container(
                      width: width*.45,
                        child: Image.asset(
                          item.imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: textTheme.headline2.copyWith(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Duration",
                                        style: textTheme.headline3.copyWith(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "28 Day",
                                        style: textTheme.headline3.copyWith(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Progress",
                                        style: textTheme.headline3.copyWith(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${item.currentDay}/28",
                                        style: textTheme.headline3.copyWith(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue.shade700,
        titleSpacing: 14,
      actions:getLeading(context,color: Colors.white),

        title: Text(
          "Explore",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(14),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [



            ...challenges.map((challenge) => getCard(challenge)).toList(),
            Padding(
              padding: const EdgeInsets.only(
                  top: 4.0, bottom: 18, left: 8, right: 8),
              child: Text(
                "Generally you can expect to notice results after two weeks. Your posture will improve and you'll feel more muscle tone. It takes three to four months for the muscles to grow.",
                style: textTheme.subtitle1
                    .copyWith(color: Colors.grey, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChallengesModel {
  final String title;
  final String imageUrl;
  final int currentDay;
  final Color color1;
  final String tag;
  final Color color2;
  final List<List<Workout>> challengeList;

  ChallengesModel({
    @required this.title,
    @required this.tag,
    @required this.imageUrl,
    @required this.currentDay,
    @required this.color1,
    @required this.color2,
    @required this.challengeList,
  });
}