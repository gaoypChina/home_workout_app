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

class FourWeekChallengePage extends StatefulWidget {



  @override
  State<FourWeekChallengePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<FourWeekChallengePage> {
  @override
  void initState() {
    super.initState();
    var provider = Provider.of<AdsProvider>(context, listen: false);
    provider.isLoaded = false;
    //  provider.createBottomBannerAd();
  }


  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var provider = Provider.of<AdsProvider>(context, listen: false);

    SpHelper _spHelper = SpHelper();
    SpKey _spKey = SpKey();
    List<ChallengesModel> challenges = [
      ChallengesModel(
        title: "Full Body Challenge",
        tag: _spKey.fullBodyChallenge,
        imageUrl: "assets/home_cover/11.jpg",
        coverImage: "assets/workout_list_cover/legs.jpg",
        challengeList: fullBodyChallenge,
        color1: Color(0xff2f7336),
        color2: Colors.orange.shade300,
      ),
      ChallengesModel(
          title: "Abs Workout Challenge",
          tag: _spKey.absChallenge,
          imageUrl: "assets/home_cover/10.jpg",
          coverImage: "assets/workout_list_cover/abs.jpg",
          challengeList: absChallenges,
          // color1: Colors.blue,
          color1: Color(0xffff4b1f),
          color2: Color(0xffff9068)),
      ChallengesModel(
          tag: _spKey.chestChallenge,
          title: "Chest Workout Challenge",
          imageUrl: "assets/home_cover/3.jpg",
          coverImage: "assets/workout_list_cover/chest.jpg",
          challengeList: chestChallenge,
          color1: Color(0xff4da0b0),
          color2: Color(0xffd39d38)),
      ChallengesModel(
        title: "Arm Workout Challenge",
        tag: _spKey.armChallenge,
        imageUrl: "assets/home_cover/1.jpg",
        coverImage: "assets/workout_list_cover/arms.jpg",
        challengeList: armChallenges,
        color1: Color(0xffff5f6d),
        color2: Color(0xffffc371),
      )
    ];

    getProgress(String key) {
      return FutureBuilder(
          future: _spHelper.loadInt(key),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                color: Colors.white70,
              );
            }
            if (snapshot.hasData) {
              return Text(
                "${snapshot.data}/28",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              );
            } else {
              return Text(
                "0/28",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              );
            }
          });
    }

    getCard(ChallengesModel item) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Container(
          height: 165,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    item.imageUrl,
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(.4), BlendMode.darken)),
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
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
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
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Duration",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "28 Days",
                                      style: TextStyle(
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
                                      style: TextStyle(
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
                  Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    getPrimeButton() {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
          height: 100,
          child: Stack(
            children: [
              ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.darken),
                  child: Image.asset(
                    "assets/home_cover/14.jpg",
                    height: 100,
                    width: width,
                    fit: BoxFit.fill,
                  )),
              Container(
                alignment: Alignment.center,
                child: ListTile(
                  title: Text(
                    "GET PRIME",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  subtitle: Text(
                    "Prime subscription starts\n from ₹99 only",
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                  trailing: Container(
                    height: 50,
                    child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: Colors.blue.shade700,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    createAd() {

      return Column(
        children: [
          Text(provider.bottomBannerAd.size.width.toDouble().toString()),
          Text(provider.bottomBannerAd.adUnitId.toString()),
          Container(
            color: Colors.red,
            alignment: Alignment.center,
            height: provider.bottomBannerAd.size.height.toDouble(),
            width: provider.bottomBannerAd.size.width.toDouble(),
            child: AdWidget(
              ad: provider.bottomBannerAd,
            ),
          ),
        ],
      );





    }


    return Scaffold(
      appBar: AppBar(

        elevation: .5,

        titleSpacing: 14,
        title: Text(
          "7 X 4 days challenges",
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
                style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(.5),
                    fontSize: 14,
                    letterSpacing: 1.5),
              ),
            ),
            //   getPrimeButton(),
            //   SizedBox(height: 18,),
            //  createAd()
          ],
        ),
      ),
    );
  }
}
