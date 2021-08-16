import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/database/workout_plan/abs_challenges.dart';
import 'package:full_workout/database/workout_plan/arm_challenges.dart';
import 'package:full_workout/database/workout_plan/chest_challenge.dart';
import 'package:full_workout/database/workout_plan/full_body_challenge.dart';
import 'package:full_workout/helper/sp_helper.dart';
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
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    SpHelper _spHelper = SpHelper();

    SpKey _spKey = SpKey();
    int i = 0;
    List<ChallengesModel> challenges = [
      ChallengesModel(
        title: "Full Body Challenge",
        tag: _spKey.fullBodyChallenge,
        currentDay: i,
        imageUrl: "assets/workout_cover/arm_curls_crunches.png",
        challengeList: fullBodyChallenge,
        color1: Color(0xff2f7336),
        color2: Colors.orange.shade300,
      ),
      ChallengesModel(
          title: "Abs Workout Challenge",
          currentDay: i,
          tag: _spKey.absChallenge,
          imageUrl: "assets/workout_cover/elbowPlank.png",
          challengeList: absChallenges,
          // color1: Colors.blue,
          color1: Color(0xffff4b1f),
          color2: Color(0xffff9068)),
      ChallengesModel(
          tag: _spKey.chestChallenge,
          title: "Chest Workout Challenge",
          currentDay: i,
          imageUrl:"assets/workout_cover/mountain_climbilng.png",
          challengeList: chestChallenge,
          color1: Color(0xff4da0b0),
          color2: Color(0xffd39d38)),
      ChallengesModel(
        title: "Arm Workout Challenge",
        tag: _spKey.armChallenge,
        currentDay: i,
        imageUrl: "assets/all-workouts/cobraStratch.png",
        challengeList: armChallenges,
        color1: Color(0xffff5f6d),
        color2: Color(0xffffc371),
      )
    ];
    
    getProgress(String key){
      return FutureBuilder(future:_spHelper.loadInt(key) ,
          builder: (BuildContext context,AsyncSnapshot snapshot){
        print(snapshot);
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator(color: Colors.white70,);
        }
        if(snapshot.hasData){
           return  Text(
            "${snapshot.data}/28",
            style: textTheme.bodyText1.copyWith(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          );
        }else{
          return  Text(
            "0/28",
            style: textTheme.bodyText1.copyWith(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          );
        }

      });
    }

    getCard(var item) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),

          child: Container(

          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [item.color1, item.color2],
              ),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WorkoutTimeLine(
                        challengesModel: item,
                      )));
            },

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
                            SizedBox(height: 10),

                            Text(
                              item.title,
                              style: textTheme.headline2.copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
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
                                      style: textTheme.bodyText1.copyWith(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "28 Days",
                                      style: textTheme.bodyText1.copyWith(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Progress",
                                      style: textTheme.bodyText1.copyWith(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                   getProgress(item.tag),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                            SizedBox(height: 10),

                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: ()=>
       onBack(),


      child: Scaffold(
        backgroundColor:isDark?Colors.black: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: getLeading(context),
          backgroundColor:isDark?Colors.black: Colors.white,
          titleSpacing: 14,
          title: Text(
            "Explore",
            style: TextStyle(color:isDark?Colors.white: Colors.black),
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