import 'package:flutter/material.dart';
import 'package:full_workout/pages/main/setting_page/faq_page.dart';


class SubscriptionFAQ extends StatelessWidget {
   SubscriptionFAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<FAQ> faqList = [
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

    Widget getFAQTile() {
      return Column(
        children: faqList
            .map((faq) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                           bottom: 0),
                      child: Container(

                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              initiallyExpanded: false,
                              title: Text(
                                faq.question,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 15),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18.0, right: 18, bottom: 18),
                                  child: Text(faq.answer,style: TextStyle(letterSpacing: 1.5),),
                                )
                              ],
                            ),
                          )),
                    ),
                    Divider(),

                  ],
                ))
            .toList(),
      );
    }

    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18.0, bottom: 12),
          child: Text(
            "Some Frequently Asked Questions",
           style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,letterSpacing: 1.2),
          ),
        ),
        getFAQTile(),
      ],
    ));
  }
}
