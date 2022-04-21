import 'package:flutter/material.dart';
import 'package:full_workout/pages/main/explore_page/four_week_challenges_page/four_week_challenge_page.dart';

class FourWeekChallengeCard extends StatelessWidget {
  const FourWeekChallengeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () =>
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return FourWeekChallengePage();
            })),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          decoration: BoxDecoration(
              //color: Colors.black.withOpacity(.1),
              image: DecorationImage(
                image: AssetImage("assets/home_cover/10.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(.5), BlendMode.hardLight),
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Four week challenge",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "Body focus 7 X 4 days challenges for growth of focused body mussels",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
