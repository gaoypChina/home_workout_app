
  import 'package:flutter/material.dart';
import 'package:full_workout/pages/subscription_page_example/widget/feature_showcase.dart';

class SubscriptionPageExample extends StatelessWidget {
  const SubscriptionPageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16, top: 8),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              backgroundColor: Colors.blue.shade900,
              foregroundColor: Colors.white),
          child: Text("Buy now"),
        ),
      ),
      appBar: AppBar(
        title: Text("Get premium"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FeatureShowcaseSection(),
            SizedBox(
              height: 22,
            ),

            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                "Your subscription will renew automatically, charging your account at the beginning of each subscription period, unless you cancel it prior to the renewal date.",
                style: TextStyle(
                    color: Colors.black.withOpacity(.8), fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
