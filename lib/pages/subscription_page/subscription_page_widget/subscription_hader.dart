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
          title: "Ad-Free",
          icon: Icons.zoom_out_map,
          subTitle: "Unlimited Workout Without Ads"),
      PremiumItem(
          color: Colors.teal,
          title: "Unlimited Workout",
          icon: Icons.article,
          subTitle: "Access Unlimited workout plans"),
      PremiumItem(
          color: Colors.grey,
          title: "300+ Workouts",
          icon: Icons.add,
          subTitle: "300+ workouts for your all fitness goals"),
      PremiumItem(
          color: Colors.lightBlue,
          title: "New Workouts",
          icon: Icons.verified_outlined,
          subTitle: "Add new workout constantly")
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 18,),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Text("Subscribe prime and get",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,letterSpacing: 1.5),),
        ),
        SizedBox(height: 10,),
        CarouselSlider.builder(
          itemCount: premiumItemList.length,
          itemBuilder: (BuildContext context, int itemIndex, _) {
            PremiumItem item = premiumItemList[itemIndex];
            return ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(18)),
              child: Stack(
                children: [

                  Container(

                    margin: EdgeInsets.only(left:itemIndex==0?0: 8,right:itemIndex==premiumItemList.length-1?0: 8),
                    padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 38),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue.shade700,item.color,],
                      ),
            borderRadius: const BorderRadius.all(Radius.circular(18)),
                    ),
                    width: double.infinity,

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Get Prime",style: TextStyle(
                           color: Colors.white,
                            fontSize: 22,fontWeight: FontWeight.w600),),
                        Spacer(),
                        CircleAvatar(
                          child: Icon(
                            item.icon,
                            size: 24,
                            color: item.color,
                          ),
                          radius: 24,
                          backgroundColor: Colors.white,
                        ),
                        Spacer(),
                        Text(item.title,style: TextStyle(
                           color: Colors.white,
                            fontSize: 20,fontWeight: FontWeight.w500),),
SizedBox(height: 8,),
                        Text(item.subTitle,style: TextStyle(
                            color: Colors.white,
                          fontSize: 14,fontWeight: FontWeight.w400,letterSpacing: 1.8),textAlign: TextAlign.center,)
                      ,  SizedBox(height: 8,),

                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          options: CarouselOptions(scrollPhysics: BouncingScrollPhysics(),
              initialPage: 0,
              enableInfiniteScroll: false,
              pageSnapping: true,
             // autoPlay: true,
              height: 200,
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
  final IconData icon;

  PremiumItem({
    required this.icon,
    required this.color,
    required this.subTitle,
    required this.title,
  });
}

