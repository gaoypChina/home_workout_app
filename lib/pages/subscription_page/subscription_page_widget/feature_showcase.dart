import 'package:flutter/material.dart';

class FeatureShowcaseSection extends StatelessWidget {
  const FeatureShowcaseSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<PremiumItem> premiumItemList = [
      PremiumItem(
          color: Colors.red.shade300,
          title: "Ad-Free",
          iconImage: "assets/subscription_icon/ads_free.png",
          subTitle: "Unlimited Workout Without Ads"),
      PremiumItem(
          color: Colors.green.shade300,
          title: "Unlimited Workout",
          iconImage: "assets/subscription_icon/creative.png",
          subTitle: "Access Unlimited workout plans"),
      PremiumItem(
          color: Colors.red.shade300,
          title: "New Workouts",
          iconImage: "assets/subscription_icon/endless.png",
          subTitle: "Add new workout constantly"),
      PremiumItem(
          color: Colors.blueGrey,
          title: "Unlimited Weight Log",
          iconImage: "assets/subscription_icon/book.png",
          subTitle: "Log unlimited workout record"),
      PremiumItem(
          color: Colors.brown.shade400,
          title: "100+ Workouts",
          iconImage: "assets/subscription_icon/unlock.png",
          subTitle: "100+ workouts for your all fitness goals"),
    ];
    return Column(
      children: [
        ...premiumItemList
            .map(
              (item) => ListTile(
                leading: Container(
                    width: 38,
                    height: 38,
                    child: Image.asset(item.iconImage ?? "")),
                subtitle: Text(
                  item.subTitle,
                  style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .color!
                        .withOpacity(.8),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                title: Text(
                  item.title,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            )
            .toList()
      ],
    );
  }
}

class PremiumItem {
  final Color color;
  final String title;
  final String subTitle;

  final String iconImage;

  PremiumItem({
    required this.iconImage,
    required this.color,
    required this.subTitle,
    required this.title,
  });
}
