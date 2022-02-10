import 'package:flutter/material.dart';
import 'package:full_workout/pages/main/setting_page/faq_page.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> featuresList = [
      "Remove Ads",
      "Unlimited workout plans",
      "300+ workouts for your all fitness goal",
      "Add new workout constantly"
    ];

    List<FAQ> faqList = [
      FAQ(
          question: "Is home workout no equipment good?",
          answer:
          "While most of us don't have round-the-clock access to a full gym stocked with weights and machines, the truth is that you really can work your entire body without them. Of course, equipment can help and is great for progressing and diversifying a workout program."),
      FAQ(
          question: "What is the 28 day workout challenge?",
          answer:
          "There are 5 exercises in this workout. You'll do each exercise for 30 seconds, rest for 20 seconds and then move onto the next exercise. When you've completed the entire circuit, take a 60-second rest and then repeat the entire circuit again four more times. You do the circuit five times in total."),
      FAQ(
          question: "How long should a beginner workout?",
          answer:
          "Try starting with short workouts that are 30 minutes or less. As you feel your strength building, add a couple more minutes every week. The American Heart Association recommends 75-150 minutes of aerobic activity, as well as two strength-training sessions, per week."),
      FAQ(
          question: "Can you see results from working out in 4 weeks?",
          answer:
          "Surely you've wondered when you will start seeing the results of your workouts: Generally you can expect to notice results after two weeks. Your posture will improve and you'll feel more muscle tone. It takes three to four months for the muscles to grow."),
      FAQ(
          question: "Can you transform your body in 4 weeks?",
          answer:
          "Yes, absolutely! How much of a transformation depends on how restrictive you are with your food and how much effort you put in. It involves a combination of healthy eating, resistance exercise and cardiovascular exercise")

    ];

    List<PriceModel> subscriptionList = [
      PriceModel(
          title: "12 Months",
          price: 7188,
          disPrice: 1188,
          duration: 12,
          isDay: false,
          perMonth: 99,
          perDis: 83),
      PriceModel(
          title: "6 Months",
          price: 3594,
          disPrice: 894,
          duration: 6,
          isDay: false,
          perMonth: 149,
          perDis: 75),

      PriceModel(
          title: "1 Month",
          price: 599,
          disPrice: 199,
          duration: 1,
          isDay: false,
          perMonth: 199,
          perDis: 25),

    ];
    buildFeatureCard() {
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
              color: Color(0xff2B3558),
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: Column(children: [
            SizedBox(
              height: 8,
            ),
            Text(
              "GO Premium".toUpperCase(),
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 12,
            ),
            ...featuresList
                .map((feature) =>
                Container(

                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 8,
                        child: Icon(
                          Icons.check,
                          color: Color(0xff2B3558),
                          size: 14,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Flexible(child: Text(feature, style: TextStyle(
                          color: Colors.white),))
                    ],
                  ),
                ))
                .toList(),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Get Now",
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(20, 38),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)))),
            )
          ]));
    }

    buildPriceCard() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: subscriptionList.map((item) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18))),

              child: Container(

                decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.all(Radius.circular(18))),
                //  padding: EdgeInsets.only(top: 8,bottom: 8,left: 8,right: 8),
                //  margin: EdgeInsets.only(bottom: 18),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            color: Color(0xff2B3558),
                            child: Column(
                              children: [
                                Text(
                                  "only",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "₹${item.perMonth}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 34,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "/month",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8,),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Text(item.title, style: TextStyle(fontSize: 24),),
                            Text("₹${item.disPrice}"),
                            Text("₹${item.price}", style: TextStyle(
                                decorationStyle: TextDecorationStyle.dashed,
                                decoration: TextDecoration.lineThrough),),
                            Text("Billed & recurring yearly cancel anytime"),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    }

    buildFAQ() {
      return ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          ...faqList.map((faq) {
            return Padding(
            padding:  EdgeInsets.only(left: 18),
              child: Stack(
                children: [
                  Container(
                    decoration:BoxDecoration( color: Color(0xff2B3558),borderRadius: BorderRadius.all(Radius.circular(8))),
                   

                    padding: EdgeInsets.only(left: 12,right: 12,top: 12,bottom: 6),

                    width: MediaQuery
                      .of(context)
                      .size
                      .width / 1.5,
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                      Text(faq.question, style: TextStyle(fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                      SizedBox(height: 8,),
                      Text(faq.answer, style: TextStyle(fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),)
                      ],
                    ),),
                  Container(
                    child: Text((faqList.indexOf(faq)+1).toString(),style: TextStyle(color: Colors.black),),
                    padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),

                    decoration: BoxDecoration(  color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomRight: Radius.circular(4))
                    ),
                  )

                ],
              ),
            );
          })
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 18,),
            buildFeatureCard(),
            SizedBox(
              height: 18,
            ),
            buildPriceCard(),
            SizedBox(
              height: 18,
            ),
            SizedBox(
              height: 260,
                child: buildFAQ()),
            SizedBox(
              height: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class PriceModel {
  final int price;
  final int disPrice;
  final int duration;
  final bool isDay;
  final int perMonth;
  final String title;
  final int perDis;

  PriceModel({required this.price,
    required this.duration,
    required this.disPrice,
    required this.isDay,
    required this.title,
    required this.perDis,
    required this.perMonth});
}
