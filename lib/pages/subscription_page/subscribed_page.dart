import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:full_workout/pages/subscription_page/subscription_page_widget/subscription_detail.dart';
import 'package:full_workout/provider/subscription_provider.dart';
import 'package:provider/provider.dart';

import '../main/setting_page/faq_page.dart';

class SubscribedPage extends StatefulWidget {
  const SubscribedPage({Key? key}) : super(key: key);

  @override
  State<SubscribedPage> createState() => _SubscribedPageState();
}

class _SubscribedPageState extends State<SubscribedPage> {
  bool isLoading = true;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) => initData());
    super.initState();
  }

  initData() async {
    var subscriptionProvider =
        Provider.of<SubscriptionProvider>(context, listen: false);
    if (subscriptionProvider.isProUser && subscriptionProvider.subscriptionDetail == null) {
      await subscriptionProvider.restoreSubscription(context: context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var subscriptionProvider =
    Provider.of<SubscriptionProvider>(context, listen: false);
    buildCancelBtn() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 1,
            color:
                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.1),
          ),
          Container(
            color: Theme.of(context).cardColor.withOpacity(.5),
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 12, top: 12),
            child: OutlinedButton(
              onPressed: () {
                Provider.of<SubscriptionProvider>(context, listen: false)
                    .cancelSubscription();
              },
              child: Text(
                "Manage Subscription",
                style: TextStyle(
                    color: Theme.of(context).primaryColor.withOpacity(.9),
                    fontWeight: FontWeight.w500),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                side: BorderSide(
                    width: 1.0,
                    color: Theme.of(context).primaryColor.withOpacity(.9)),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      bottomNavigationBar: isLoading?null:buildCancelBtn(),
      appBar: AppBar(
        title: Text("Subscription Settings"),
        elevation: .5,
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(),):SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            if(subscriptionProvider.subscriptionDetail != null )   SizedBox(
              height: 20,
            ),

        if(subscriptionProvider.subscriptionDetail != null )   SubscriptionDetail(),
            SizedBox(
              height: 24,
            ),
            SubscribedFAQ(),
            SizedBox(
              height: 20,
            ),
            //     buildCancelBtn(),
          ],
        ),
      ),
    );
  }
}

class SubscribedFAQ extends StatelessWidget {
  SubscribedFAQ({Key? key}) : super(key: key);

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
                    Container(
                        child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        initiallyExpanded: false,
                        title: Text(
                          faq.question,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15,     color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!.withOpacity(.9)),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0, right: 18, bottom: 18),
                            child: Text(
                              faq.answer,
                              style: TextStyle(
                                  letterSpacing: 1.5,
                             ),
                            ),
                          )
                        ],
                      ),
                    )),
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      margin: EdgeInsets.only(top: 16),
                      height: 1,
                    ),
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
            "Frequently Asked Questions",
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.w500, letterSpacing: 1.2),
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.blue.withOpacity(.1),
            child: getFAQTile()),
      ],
    ));
  }
}
