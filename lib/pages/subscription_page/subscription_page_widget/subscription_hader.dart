import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
          color: Colors.blueGrey,
          title: "New Workouts",
          iconImage: "assets/other/dumbel.png",
          subTitle: "Add new workout constantly"),
      PremiumItem(
          color: Colors.teal,
          title: "Ad-Free",
          iconImage: "assets/other/ads.png",
          subTitle: "Unlimited Workout Without Ads"),
      PremiumItem(
          color: Colors.red.shade300,
          title: "Unlimited Workout",
          icon: Icons.article_outlined,
          subTitle: "Access Unlimited workout plans"),
      PremiumItem(
          color: Colors.blueGrey,
          title: "Unlimited Weight Log",
          iconImage:"assets/other/line-chart.png" ,
          subTitle: "Log unlimited workout record"),
      PremiumItem(
          color: Colors.teal,
          title: "100+ Workouts",
          iconImage: "assets/other/100.png",
          subTitle: "100+ workouts for your all fitness goals"),
      PremiumItem(
          color: Colors.red.shade300,
          title: "Support developers",
          icon: Icons.favorite_border_outlined,

          subTitle: "You little contribution supports us to continue good work"),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 18,),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Text(
            "Subscription Benefit",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.5),
          ),
        ),
        SizedBox(height: 10,),
        CarouselSlider.builder(
          itemCount: premiumItemList.length,
          itemBuilder: (BuildContext context, int itemIndex, _) {
            PremiumItem item = premiumItemList[itemIndex];
            return ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: Stack(
                children: [

                  Container(

                    margin: EdgeInsets.only(
                        left: itemIndex == 0 ? 0 : 8,
                        right: itemIndex == premiumItemList.length - 1 ? 0 : 8),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 38),
                    decoration: BoxDecoration(
                      color: item.color.withOpacity(.05),
                      // gradient: LinearGradient(
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      //   colors: [
                      //     item.color.withOpacity(.7),
                      //     item.color,
                      //   ],
                      // ),
                      border: Border.all(color:item.color.withOpacity(.2),width: 1,),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    width: double.infinity,

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(


                          child: item.icon == null
                              ? Image.asset(item.iconImage!,height: 24,color: Colors.white,)
                              : Icon(
                                  item.icon,
                                  size: 24,
                                  color: Colors.white,
                                ),
                          radius: 24,
                          backgroundColor: item.color,
                        ),
                        Spacer(),
                        Text(item.title,style: TextStyle(
                           color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: 20,fontWeight: FontWeight.w500),),
SizedBox(height: 8,),
                        Text(item.subTitle,style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          fontSize: 14,fontWeight: FontWeight.w400,letterSpacing: 1.8),textAlign: TextAlign.center,)
                      ,  SizedBox(height: 8,),

                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          options: CarouselOptions(
              scrollPhysics: BouncingScrollPhysics(),
              initialPage: 0,
              enableInfiniteScroll: false,
              pageSnapping: true,
              // autoPlay: true,
              height: 150,
              viewportFraction: .90,
              onPageChanged: (index, _) {
                setState(() {
                  activeIndex = index;
                });
              }),
        ),
        SizedBox(height: 10,),
        Center(
          child: AnimatedSmoothIndicator(
            count: premiumItemList.length,
            effect:  WormEffect(
              dotHeight: 6,
              paintStyle: PaintingStyle.stroke,
              dotWidth: 6,
              dotColor: premiumItemList[activeIndex].color,
              strokeWidth: 1,
              activeDotColor: premiumItemList[activeIndex].color,
            ),
            // your preferred effect
            activeIndex: activeIndex,
          ),
        ),
        SizedBox(height: 10,),

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

