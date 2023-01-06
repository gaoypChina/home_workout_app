import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_my_app/rate_my_app.dart';

import '../../../constants/constant.dart';

class RateDialogPage extends StatefulWidget {
  final RateMyApp rateMyApp;

  const RateDialogPage({super.key, required this.rateMyApp});

  @override
  RateDialogPageState createState() => RateDialogPageState();
}

class RateDialogPageState extends State<RateDialogPage> {
  Constants constants = Constants();
  String comment = "";

  List<Widget> actionsBuilder(BuildContext context, double stars) {
    Widget buildRateButton(double starts) {
      return ElevatedButton(
          onPressed: () async {
            try{

              final launchAppStore = stars >= 4;
              const event = RateMyAppEventType.rateButtonPressed;
              await widget.rateMyApp.callEvent(event);
              if (launchAppStore) {
                constants.getToast(
                  "↓↓ Scroll down to rate us ↓↓",
                );
                widget.rateMyApp.launchStore();
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Theme.of(context).cardColor,
                        title: Text("Rate this App"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                        contentPadding: EdgeInsets.all(16),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RatingBar.builder(
                                initialRating: stars,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  size: 14,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  if(rating >= 4) {
                                    constants.getToast(
                                      "↓↓ Scroll down to rate us ↓↓",
                                    );
                                    widget.rateMyApp.launchStore();
                                    Navigator.of(context).pop();
                                  }

                                }


                            ),
                            SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                                maxLines: 5,
                                autofocus: true,
                                decoration: InputDecoration(
                                    hintText: 'Write your review....',
                                    contentPadding: EdgeInsets.all(8.0),
                                    border: OutlineInputBorder()),
                                onChanged: (comment) =>
                                    setState(() => this.comment = comment)),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel"),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                String toSend = "$comment\n\n";

                                final Email email = Email(
                                  body: toSend,
                                  subject: 'App Review (${stars.toInt()} Stars)',
                                  recipients: ['workoutfeedback@gmail.com'],
                                  isHTML: false,
                                );

                                Navigator.of(context).pop();
                                try {
                                  await FlutterEmailSender.send(email);
                                } catch (e) {
                                  constants.getToast(
                                    "Thanks for your Feedback",
                                  );
                                }
                              },
                              child: Text("Send")),
                        ],
                      );
                    });
              }

            }catch(e){
              log("Something went wrong");
            }
          },
          child: Text("Rate"));
    }

    return [
      RateMyAppNoButton(widget.rateMyApp, text: "Later"),
      buildRateButton(stars),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 0, top: 8),
      child: ElevatedButton.icon(
        icon: FaIcon(
          Icons.star,
          size: 28,
        ),
        onPressed: () async {
          widget.rateMyApp.showStarRateDialog(context,
              title: "Rate this App",
              dialogStyle: DialogStyle(
                  contentPadding: EdgeInsets.all(24),
                  dialogShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)))),
              message: "Do you like this app? Please leave a rating",
              starRatingOptions: StarRatingOptions(
                  initialRating: 3,
                  minRating: 1,
                  itemPadding: EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 2,
                  )), actionsBuilder: (context, stars) {
                return actionsBuilder(context, stars ?? 1);
              });
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff075E54),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(22))),
            minimumSize: Size(double.infinity, 50)),
        label: Text("Rate us on store ", style: TextStyle(fontSize: 15)),
      ),
    );
  }
}
