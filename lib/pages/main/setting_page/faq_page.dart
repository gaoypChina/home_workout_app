import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:full_workout/constants/constant.dart';


class FAQPage extends StatelessWidget {
  static const routeName = "FAQ-page";

  @override
  Widget build(BuildContext context) {
double width = MediaQuery.of(context).size.width;

    buildFAQCard() {
      return Column(children: [
        ...faqList.map((faq) {
          return ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(faq.question),
            ),
            children: [
              Container(
                color: Colors.blue.withOpacity(.0),
                child: Column(
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        child: Text(faq.answer)),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              )
            ],
          );
        })
      ]);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(0),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [


            Container(
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 22),
              color: Colors.green.withOpacity(.04),
              child: SvgPicture.asset(
                'assets/other/faq.svg',

                alignment: Alignment.center,

                width: width -20,
              ),
            ),

            Container(
              height: 20,
              color: Colors.blue.withOpacity(.15),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: buildFAQCard(),
            ),
            SizedBox(height: 18,)
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

List<FAQ> faqList = [
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