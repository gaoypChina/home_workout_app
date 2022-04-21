import 'package:flutter/material.dart';
import 'package:full_workout/constants/constant.dart';
import 'package:full_workout/pages/main/setting_page/faq_page.dart';
import 'package:full_workout/pages/subscription_page/subscription_page_widget/subscription_faq.dart';
import 'package:full_workout/pages/subscription_page/subscription_page_widget/subscription_hader.dart';
import 'package:full_workout/pages/subscription_page/subscription_page_widget/subscription_price.dart';
import 'package:full_workout/pages/subscription_page/subscription_page_widget/subscription_timer.dart';
import 'package:full_workout/pages/subscription_page/subscription_page_widget/user_review.dart';
import 'package:full_workout/provider/subscription_provider.dart';
import 'package:provider/provider.dart';

class SubscriptionPage extends StatefulWidget {
  SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
   Constants constants = Constants();
    buildButton() {
      var data = Provider.of<SubscriptionProvider>(context,listen: true);

      return Column(
        children: [
          Spacer(),
          Container(
            color: Colors.grey,
            height: .2,
          ),
          Material(

            elevation: 10,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),

                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6.5),
                          color: Colors.blue.shade600,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                 constants.getPrice(price:  data.subscriptionList[data.offerIndex].disPrice),
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                ),
                                Text("only "+
                                  constants.getPrice(price:  data.subscriptionList[data.offerIndex].perMonth)+"/m",
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,color: Colors.amber),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 12),
                          color: Colors.blue.shade700,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "BUY",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 8,),
                                Icon(Icons.arrow_forward)
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  style:
                      ElevatedButton.styleFrom(primary: Colors.transparent,elevation: 0,padding: EdgeInsets.zero),
                )),
          ),
        ],
      );
    }

    buildDivider(){
      return Container(height: 12,color: Colors.blue.withOpacity(.1),);
    }

    return Scaffold(
      appBar: AppBar(

        //leading: IconButton(onPressed: (){Navigator.of(context).pop();},icon: Icon(Icons.arrow_back,color: Colors.white,),),
        title: Text(
          "Get Premium",

        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [


                SubscriptionHeader(),

                SizedBox(
                  height: 18,
                ),
                SubscriptionPrice(),

                SizedBox(
                  height: 28,
                ),

                UserReview(),
                SizedBox(
                  height: 28,
                ),
                buildDivider(),
                SubscriptionTime(),
                buildDivider(),
                SizedBox(
                  height: 28,
                ),
                SubscriptionFAQ(),

                // SizedBox(height: 280, child: buildFAQ()),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
            buildButton()
          ],
        ),
      ),
    );
  }
}
