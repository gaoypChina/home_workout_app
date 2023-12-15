import 'package:flutter/material.dart';

class StaticsSection extends StatelessWidget {
  const StaticsSection({Key? key}) : super(key: key);

  buildCard({required title, required subtitle, required String iconSrc}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(
        children: [
          Spacer(),
          Image.asset(iconSrc, height: 30),
          Spacer(),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          SizedBox(
            height: 8,
          ),
          Text(subtitle),
          Spacer(),
        ],
      ),
    );
  }

  buildDivider() {
    return Container(
      width: 12,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<MileStoneCardModel> milestoneList = [
      MileStoneCardModel(
          title: "Subscribed User",
          stat: "1000+",
          iconSrc: "assets/other/smile.png"),
      MileStoneCardModel(
          title: "User Seen Results",
          stat: "1000+",
          iconSrc: "assets/other/star.png"),
      MileStoneCardModel(
          title: "Active  Users",
          stat: "2000+",
          iconSrc: "assets/other/goal.png"),
      MileStoneCardModel(
          title: "5 Star Rating",
          stat: "3000+",
          iconSrc: "assets/other/medal.png"),
    ];
    var textColor = Theme.of(context).textTheme.bodyMedium!.color!;
    return Container(
        padding: EdgeInsets.symmetric(vertical: 28, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 18,
                  width: 6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Colors.blue.shade700),
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  "Our milestones",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 3/ 2.2),
              itemCount: milestoneList.length,
              itemBuilder: (BuildContext context, int index) {
                return buildCard(
                    title: milestoneList[index].stat,
                    subtitle: milestoneList[index].title,
                    iconSrc: milestoneList[index].iconSrc);
              },
            ),
          ],
        ));
  }
}

class MileStoneCardModel {
  final String title;
  final String stat;
  final String iconSrc;

  MileStoneCardModel(
      {required this.title, required this.stat, required this.iconSrc});
}
