import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/database/workout_plan/abs_challenges.dart';
import 'package:full_workout/database/workout_plan/arm_challenges.dart';
import 'package:full_workout/database/workout_plan/chest_challenge.dart';
import 'package:full_workout/database/workout_plan/full_body_challenge.dart';
import 'package:full_workout/helper/light_dark_mode.dart';
import 'package:full_workout/pages/main/explore_page/workout_time_line.dat.dart';

class ExplorePage extends StatelessWidget {
  final Function onBack;

  ExplorePage({this.onBack});

  @override
  Widget build(BuildContext context) {
    int i = 0;
    List<ChallengesModel> challenges = [
      ChallengesModel(
        title: "Full Body Challenge",
        currentDay: i,
        imageUrl: "assets/bg_cover/back-cover.png",
        challengeList: fullBodyChallenge,
        color1: Color(0xff603813),
        color2: Color(0xffb29f94),
      ),
      ChallengesModel(
          title: "Abs Challenge",
          currentDay: i,
          imageUrl: "assets/all-workouts/cobraStratch.png",
          challengeList: absChallenges,
          color1: Colors.blue,
          color2: Color(0xffb31217)),

      ChallengesModel(
          title: "Chest Challenge",
          currentDay: i,
          imageUrl: "assets/all-workouts/cobraStratch.png",
          challengeList: chestChallenge,
          color1: Colors.amber,
          color2: Colors.teal),
      ChallengesModel(
          title: "Arm Challenge",
          currentDay: i,
          imageUrl: "assets/all-workouts/cobraStratch.png",
          challengeList: armChallenges,
          color1: Colors.red,
          color2: Colors.purple),
    ];

    getCard(int index) {
      var item = challenges[index];
      return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => WorkoutTimeLine(challengesModel: item,challengeList: item.challengeList,)));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [item.color1, item.color2]),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child:
            Container(
                child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16)),
                  child: Container(
                    height: 105,
                    width: 150,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            )),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
      ),
      body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: challenges.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
                 child: getCard(index),
               )
            ;
          }),
    );
  }
}

class ChallengesModel {
  final String title;
  final String imageUrl;
  final int currentDay;
  final Color color1;
  final Color color2;
  final List<List<Workout>> challengeList;

  ChallengesModel( {
    this.title,
    this.imageUrl,
    this.currentDay,
    this.color1,
    this.color2,
    this.challengeList,
  });
}