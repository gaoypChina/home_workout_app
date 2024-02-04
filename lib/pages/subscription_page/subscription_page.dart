import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:full_workout/pages/subscription_page/subscription_page_widget/subscription_countdown.dart';
import 'package:full_workout/pages/subscription_page/subscription_page_widget/subscription_faq.dart';
import 'package:full_workout/pages/subscription_page/subscription_page_widget/subscription_loading_page.dart';
import '../../../pages/subscription_page/subscription_page_widget/statics_section.dart';
import '../../../pages/subscription_page/subscription_page_widget/subsctiption_plan.dart';
import '../../../pages/subscription_page/subscription_page_widget/user_review.dart';
import '../../../provider/subscription_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/constant.dart';
import '../../widgets/loading_indicator.dart';
import 'subscription_page_widget/feature_showcase.dart';

class SubscriptionPage extends StatefulWidget {
  final bool showCrossButton;

  static const routeName = "subscription-page";

  SubscriptionPage({Key? key, required this.showCrossButton}) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  void initState() {
    var data = Provider.of<SubscriptionProvider>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) => data.fetchOffers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<SubscriptionProvider>(context, listen: true);
    buildButton() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.grey,
            height: .2,
          ),
          Material(
            elevation: 5,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                width: double.infinity,
                height: 65,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            data.packageList[data.offerIndex].storeProduct
                                .priceString,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "${Constants().getPerMonthPrice(product: data.packageList[data.offerIndex].storeProduct)}/ Month",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color!
                                    .withOpacity(.8),
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(28),
                        onTap: data.isBuyBtnLoading
                            ? null
                            : () => data.onBuyBtnClick(context: context),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Colors.blue.shade900,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "BUY",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          data.isLoading
              ? SubscriptionLoadingPage()
              : data.packageList.isEmpty
                  ? Center(
                      child: Text("Something went wrong..."),
                    )
                  : Scaffold(
                      bottomNavigationBar: buildButton(),
                      appBar: AppBar(
                        leading: widget.showCrossButton
                            ? IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(Icons.close))
                            : null,
                        title: Text(
                          "Get Premium",
                        ),
                        actions: [
                          data.isLoading
                              ? Container()
                              : Padding(
                                  padding: EdgeInsets.only(
                                      right: 12, top: 10, bottom: 10),
                                  child: OutlinedButton(
                                    onPressed: () {
                                      data.restoreSubscription(
                                          context: context);
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "Restore",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor:
                                          Theme.of(context).primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(28)),
                                      side: BorderSide(
                                          width: 1.5,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      body: SafeArea(
                        child: ListView(
                          //      physics: BouncingScrollPhysics(),
                          children: [
                            SubscriptionCountdown(),
                            SizedBox(
                              height: 12,
                            ),
                            FeatureShowcaseSection(),
                            SizedBox(
                              height: 12,
                            ),
                            SubscriptionPlan(),
                            SizedBox(
                              height: 22,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.1),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18),
                                      topRight: Radius.circular(18))),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 22,
                                  ),
                                  UserReview(),
                                  SizedBox(
                                    height: 8,
                                  ),

                                  StaticsSection(),
                                  // SizedBox(height: 280, child: buildFAQ()),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  SubscriptionFAQ()


                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
          if (data.isBuyBtnLoading)
            CustomLoadingIndicator(
              msg: "Loading...",
            )
        ],
      ),
    );
  }
}



