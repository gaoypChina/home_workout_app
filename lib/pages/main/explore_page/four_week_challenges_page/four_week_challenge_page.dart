import 'package:flutter/material.dart';
import '../../../../pages/main/explore_page/four_week_challenges_page/workout_time_line.dat.dart';
import '../../../../widgets/prime_icon.dart';

import '../../../../database/workout_plan/four_week_challenges/abs_challenges.dart';
import '../../../../database/workout_plan/four_week_challenges/arm_challenges.dart';
import '../../../../database/workout_plan/four_week_challenges/chest_challenge.dart';
import '../../../../database/workout_plan/four_week_challenges/full_body_challenge.dart';
import '../../../../helper/sp_helper.dart';
import '../../../../helper/sp_key_helper.dart';
import '../../../../models/challenges_model.dart';
import '../../../../widgets/banner_regular_ad.dart';

class FourWeekChallengePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SpHelper _spHelper = SpHelper();
    SpKey _spKey = SpKey();
    List<ChallengesModel> challenges = [
      ChallengesModel(
        title: "Full Body Challenge",
        tag: _spKey.fullBodyChallenge,
        imageUrl: "assets/home_cover/11.jpg",
        coverImage: "assets/workout_list_cover/legs.jpg",
        challengeList: fullBodyChallenge,
      ),
      ChallengesModel(
        title: "Abs Workout Challenge",
        tag: _spKey.absChallenge,
        imageUrl: "assets/home_cover/10.jpg",
        coverImage: "assets/workout_list_cover/abs.jpg",
        challengeList: absChallenges,
      ),
      ChallengesModel(
        tag: _spKey.chestChallenge,
        title: "Chest Workout Challenge",
        imageUrl: "assets/home_cover/3.jpg",
        coverImage: "assets/workout_list_cover/chest.jpg",
        challengeList: chestChallenge,
      ),
      ChallengesModel(
        title: "Arm Workout Challenge",
        tag: _spKey.armChallenge,
        imageUrl: "assets/home_cover/1.jpg",
        coverImage: "assets/workout_list_cover/arms.jpg",
        challengeList: armChallenges,
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
          height: 155,
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
            onTap: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WorkoutTimeLine(
                            challengesModel: item,
                          )));
            },
            child: Stack(
              children: [
                Container(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Duration",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
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
                                              color: Colors.white,
                                              fontSize: 15),
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
                Positioned(right: 10, top: 10, child: PrimeIcon())
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      bottomNavigationBar: RegularBannerAd(),
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
                textAlign: TextAlign.justify,
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
            SizedBox(
              height: 18,
            ),
          ],
        ),
      ),
    );
  }
}
