import 'package:flutter/material.dart';
import '../../../../pages/main/explore_page/four_week_challenges_page/four_week_challenge_page.dart';

class FourWeekChallengeCard extends StatelessWidget {
  const FourWeekChallengeCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "7 X 4 Days Challenge",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 8,
          ),
          InkWell(
              onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return FourWeekChallengePage();
                  })),
              child: Container(
                height: 160,
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(12, 0, 12, 16),
                decoration: BoxDecoration(
                    //color: Colors.black.withOpacity(.1),
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/home_cover/6.jpg",
                      ),
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(.3), BlendMode.hardLight),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text(
                      "The 7 X 4 Day Challenge is a four-week workout program designed by us to achieve your fitness goal.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          height: 1.2,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
