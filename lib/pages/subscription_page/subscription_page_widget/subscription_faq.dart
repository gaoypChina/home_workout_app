import 'package:flutter/material.dart';
import '../../../pages/main/setting_page/faq_page.dart';

class SubscriptionFAQ extends StatelessWidget {
  SubscriptionFAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textColor = Theme.of(context).textTheme.bodyMedium!.color!;
    bool isDark = Theme.of(context).textTheme.bodyLarge!.color == Colors.white;

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
      return ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          color: isDark ? Colors.grey.shade900 : Colors.white,
          child: Column(
            children: faqList
                .map((faq) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0),
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
                                  child: Text(
                                    faq.answer,
                                    style: TextStyle(letterSpacing: 1.5),
                                  ),
                                )
                              ],
                            ),
                          )),
                        ),
                        if (faqList.indexOf(faq) < faqList.length - 1)
                          Container(
                            height: 1,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: double.infinity,
                            color:Colors.grey.shade500.withOpacity(.15),
                          )
                      ],
                    ))
                .toList(),
          ),
        ),
      );
    }

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 18),
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
                  "Subscription FAQ",
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
            getFAQTile(),
            SizedBox(
              height: 30,
            ),
          ],
        ));
  }
}
