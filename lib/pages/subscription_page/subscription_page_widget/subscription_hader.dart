import 'package:flutter/material.dart';

class SubscriptionHeader extends StatefulWidget {
  SubscriptionHeader({Key? key}) : super(key: key);

  @override
  _SubscriptionHeaderState createState() => _SubscriptionHeaderState();
}

class _SubscriptionHeaderState extends State<SubscriptionHeader> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<PremiumItem> premiumItemList = [
      PremiumItem(
          color: Colors.red.shade300,
          title: "Ad-Free",
          iconImage: "assets/other/ads.png",
          subTitle: "Unlimited Workout Without Ads"),
      PremiumItem(
          color: Colors.green.shade300,
          title: "Unlimited Workout",
          icon: Icons.article_outlined,
          subTitle: "Access Unlimited workout plans"),
      PremiumItem(
          color: Colors.red.shade300,
          title: "New Workouts",
          iconImage: "assets/other/dumbel.png",
          subTitle: "Add new workout constantly"),
      PremiumItem(
          color: Colors.blueGrey,
          title: "Unlimited Weight Log",
          iconImage: "assets/other/line-chart.png",
          subTitle: "Log unlimited workout record"),
      PremiumItem(
          color: Colors.brown.shade400,
          title: "100+ Workouts",
          iconImage: "assets/other/100.png",
          subTitle: "100+ workouts for your all fitness goals"),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Text(
            "Subscription benefit",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        SizedBox(
          height: 2,
        ),

        Column(
          children: [
            ...premiumItemList
                .map(
                  (item) => ListTile(
                    leading: CircleAvatar(
                      child: item.icon == null
                          ? Image.asset(
                              item.iconImage!,
                              height: 24,
                              color: Colors.white,
                            )
                          : Icon(
                              item.icon,
                              size: 24,
                              color: Colors.white,
                            ),
                      radius: 24,
                      backgroundColor: item.color.withOpacity(.8),
                    ),
                    subtitle: Text(
                      item.subTitle,
                      style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(.7),
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(.9),
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
                .toList()
          ],
        ),

        // CarouselSlider.builder(
        //   itemCount: premiumItemList.length,
        //   itemBuilder: (BuildContext context, int itemIndex, _) {
        //     PremiumItem item = premiumItemList[itemIndex];
        //     return ClipRRect(
        //       borderRadius: const BorderRadius.all(Radius.circular(16)),
        //       child: Stack(
        //         children: [
        //           Container(
        //             margin: EdgeInsets.only(
        //                 left: itemIndex == 0 ? 0 : 8,
        //                 right: itemIndex == premiumItemList.length - 1 ? 0 : 8),
        //             padding: const EdgeInsets.symmetric(
        //                 vertical: 12, horizontal: 38),
        //             decoration: BoxDecoration(
        //               color: item.color,
        //               // gradient: LinearGradient(
        //               //   begin: Alignment.topLeft,
        //               //   end: Alignment.bottomRight,
        //               //   colors: [
        //               //     item.color.withOpacity(.7),
        //               //     item.color,
        //               //   ],
        //               // ),
        //               borderRadius: const BorderRadius.all(Radius.circular(16)),
        //             ),
        //             width: double.infinity,
        //
        //             child: Column(
        //               mainAxisSize: MainAxisSize.min,
        //               children: [
        //                 CircleAvatar(
        //
        //
        //                   child: item.icon == null
        //                       ? Image.asset(
        //                           item.iconImage!,
        //                           height: 24,
        //                           color: item.color,
        //                         )
        //                       : Icon(
        //                           item.icon,
        //                           size: 24,
        //                           color: item.color,
        //                         ),
        //                   radius: 24,
        //                   backgroundColor: Colors.white,
        //                 ),
        //                 Spacer(),
        //                 Text(
        //                   item.title,
        //                   style: TextStyle(
        //                       color: Colors.white,
        //                       fontSize: 20,
        //                       fontWeight: FontWeight.w500),
        //                 ),
        //                 SizedBox(
        //                   height: 8,
        //                 ),
        //                 Text(
        //                   item.subTitle,
        //                   style: TextStyle(
        //                       color: Colors.white,
        //                       fontSize: 14,
        //                       fontWeight: FontWeight.w400,
        //                       letterSpacing: 1.8),
        //                   textAlign: TextAlign.center,
        //                 ),
        //                 SizedBox(
        //                   height: 8,
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     );
        //   },
        //   options: CarouselOptions(
        //       scrollPhysics: BouncingScrollPhysics(),
        //       initialPage: 0,
        //       enableInfiniteScroll: false,
        //       pageSnapping: true,
        //       // autoPlay: true,
        //       height: 150,
        //       viewportFraction: .90,
        //       onPageChanged: (index, _) {
        //         setState(() {
        //           activeIndex = index;
        //         });
        //       }),
        // ),
        // SizedBox(height: 10,),
        // Center(
        //   child: AnimatedSmoothIndicator(
        //     count: premiumItemList.length,
        //     effect:  WormEffect(
        //       dotHeight: 6,
        //       paintStyle: PaintingStyle.stroke,
        //       dotWidth: 6,
        //       dotColor: premiumItemList[activeIndex].color,
        //       strokeWidth: 1,
        //       activeDotColor: premiumItemList[activeIndex].color,
        //     ),
        //     // your preferred effect
        //     activeIndex: activeIndex,
        //   ),
        // ),
        // SizedBox(height: 10,),
      ],
    );
  }
}

class PremiumItem {
  final Color color;
  final String title;
  final String subTitle;
  IconData? icon;
  String? iconImage;

  PremiumItem({
    this.iconImage,
    this.icon,
    required this.color,
    required this.subTitle,
    required this.title,
  });
}
