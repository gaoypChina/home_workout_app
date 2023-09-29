import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  static const routeName = "FAQ-page";

  @override
  Widget build(BuildContext context) {
    buildFAQCard({required List faqItems}) {
      return Container(
        color: Colors.blue.withOpacity(.08),
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(children: [
          ...faqItems.map((faq) {
            return Column(
              children: [
                Container(
                    child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: false,
                    title: Text(
                      faq.question,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15.5,
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(.7)),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16, bottom: 12),
                        child: Text(
                          faq.answer,
                          style: TextStyle(
                              letterSpacing: 1.5,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.color
                                  ?.withOpacity(.7)),
                        ),
                      )
                    ],
                  ),
                )),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  margin: EdgeInsets.only(top: 8),
                  height: 1,
                ),
              ],
            );
          })
        ]),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Subscription FAQs",
              style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            buildFAQCard(faqItems: subscriptionFaq),
            SizedBox(
              height: 22,
            ),
            Text(
              "General FAQs",
              style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            buildFAQCard(faqItems: generalFaq),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class FAQ {
  String question;
  String answer;

  FAQ({required this.question, required this.answer});
}

List<FAQ> subscriptionFaq = [
  FAQ(
      question: "What does Home workout Pro include?",
      answer:
          "Home Workout Pro includes full access to all Pro features. unlimited access to all workout without any Ads"),
  FAQ(
      question:
          "Is Home Workout Pro is a one-time payment or will it renew automatically?",
      answer:
          "The Home Workout Pro plans are subscriptions that renew automatically at the end of your subscription term to avoid any interruption to your service. If you cancel your subscription, you will continue to have access to Home Workout Pro until your subscription expires."),
  FAQ(
      question: "Can I Cancel my subscription anytime?",
      answer:
          "Yes, you can cancel your Home Workout Pro subscription whenever you want! You will continue to have access to Home Workout Pro until your subscription expires."),
  FAQ(
      question: "How do I Cancel subscription?",
      answer:
          "Google Play -> Find Home Workout -> Manage Subscriptions -> Cancel Subscription")
];

List<FAQ> generalFaq = [
  FAQ(
      question: "What is the home workout app?",
      answer:
          "Home Workouts provides daily workout routines for all your main muscle groups. In just a few minutes a day, you can build muscles and keep fitness at home without having to go to the gym. No equipment or coach needed, all exercises can be performed with just your body weight."),
  FAQ(
      question: "Is it effective to workout at home?",
      answer:
          "Providing you are prepared to put a little time and effort into your workout at home, it can be just as effective as a gym workout. However for others, the prospect of going into a gym is daunting and therefore exercising in the comfort of their own home is much more appealing."),
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
