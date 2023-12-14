import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:screenshot/screenshot.dart';
import '../../../constants/constant.dart';
import '../../../pages/subscription_page/subscription_page_widget/statics_section.dart';
import '../../../pages/subscription_page/subscription_page_widget/subscription_faq.dart';
import '../../../pages/subscription_page/subscription_page_widget/subscription_hader.dart';
import '../../../pages/subscription_page/subscription_page_widget/subsctiption_plan.dart';
import '../../../pages/subscription_page/subscription_page_widget/user_review.dart';
import '../../../provider/subscription_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/loading_indicator.dart';
import '../subscription_page_example/widget/feature_showcase.dart';

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
    Constants constants = Constants();
    buildButton() {
      return Column(
        children: [
          Spacer(),
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
                child: ElevatedButton(
                  onPressed: data.isBuyBtnLoading
                      ? null
                      : () => data.onBuyBtnClick(context: context),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          data.packageList[data.offerIndex].storeProduct
                              .priceString,
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Colors.blue.shade900,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "BUY",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(Icons.arrow_forward),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      padding: EdgeInsets.zero),
                )),
          ),
        ],
      );
    }

    buildDivider() {
      return Container(
          padding: EdgeInsets.only(top: 8, bottom: 16),
          child: Constants().getDivider(context: context));
    }

    return Stack(
      children: [
        Scaffold(
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
                      padding: EdgeInsets.only(right: 12, top: 10, bottom: 10),
                      child: OutlinedButton(
                        onPressed: () {
                          data.restoreSubscription(context: context);
                        },
                        child: Row(
                          children: [
                            Text(
                              "Restore",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).primaryColor.withOpacity(.8),
                          side: BorderSide(
                              width: 1.5,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.7)),
                        ),
                      ),
                    ),
            ],
          ),
          body: data.isLoading
              ? Center(child: CircularProgressIndicator())
              : data.packageList.isEmpty
                  ? Center(
                      child: Text("Something went wrong..."),
                    )
                  : SafeArea(
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                decoration: BoxDecoration(
                                    color: Colors.amber.withOpacity(.3)),
                                child: Text(
                                  "Offer end in: 12:12:00",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ),
                              Expanded(
                                child: ListView(
                                  //      physics: BouncingScrollPhysics(),
                                  children: [
                                    SizedBox(
                                      height: 12,
                                    ),
                                    FeatureShowcaseSection(),
                                    SizedBox(
                                      height: 22,
                                    ),
                                    SubscriptionPlan(),
                                    SizedBox(
                                      height: 22,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(.1),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(18),topRight: Radius.circular(18))),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 18,
                                          ),
                                          UserReview(),
                                          SizedBox(
                                            height: 28,
                                          ),

                                          StaticsSection(),
                                          // SizedBox(height: 280, child: buildFAQ()),
                                          SizedBox(
                                            height: 60,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          buildButton()
                        ],
                      ),
                    ),
        ),
        if (data.isBuyBtnLoading)
          CustomLoadingIndicator(
            msg: "Loading...",
          )
      ],
    );
  }
}
