import 'package:flutter/material.dart';

import '../../pages/main_page.dart';

class SubscriptionSuccessfulDialog extends StatefulWidget {
  const SubscriptionSuccessfulDialog({Key? key}) : super(key: key);

  @override
  State<SubscriptionSuccessfulDialog> createState() =>
      _SubscriptionSuccessfulDialogState();
}

class _SubscriptionSuccessfulDialogState
    extends State<SubscriptionSuccessfulDialog> {
  double imgHeight = 50;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(microseconds: 300)).then((value) => setState(() {
          imgHeight = MediaQuery.of(context).size.height * .35;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(
                      index: 0,
                    )));

        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),

                Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Home ".toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: 22)),
                    TextSpan(
                        text: "Workout".toUpperCase(),
                        style: TextStyle(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            //     color: Theme.of(context).primaryColor,
                            fontSize: 22)),
                    TextSpan(
                        text: " Pro".toUpperCase(),
                        style: TextStyle(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor,
                            fontSize: 22)),
                  ])),
                ),

                Spacer(
                  flex: 2,
                ),
                AnimatedContainer(
                  height: imgHeight,
                  decoration: BoxDecoration(),
                  duration: Duration(milliseconds: 300),
                  child: Image.asset(
                    "assets/other/premium_success.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Spacer(
                  flex: 3,
                ),
                // Image.network(
                //     "https://cdn-icons-png.flaticon.com/128/1054/1054436.png"),
                Text(
                  "Congratulations",
                  style: TextStyle(fontSize: 28),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Enjoy all premium workout without any Interruption, which helps you to achieve your fitness goals.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 1.2,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(.8)),
                ),
                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage(
                                        index: 0,
                                      )));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          "Continue".toUpperCase(),
                          style: TextStyle(fontSize: 16),
                        ))),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
