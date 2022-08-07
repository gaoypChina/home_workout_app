import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../pages/workout_page/report_page.dart';
import 'package:rate_my_app/rate_my_app.dart';

import '../main/setting_page/setting_screen.dart';

class RateDialogPage extends StatefulWidget {
  final RateMyApp rateMyApp;

  RateDialogPage({required this.rateMyApp});

  @override
  _RateDialogPageState createState() => _RateDialogPageState();
}

class _RateDialogPageState extends State<RateDialogPage> {
  String comment = "";

  List<Widget> actionsBuilder(BuildContext context, double stars) {
    Widget buildRateButton(double starts) {
      return TextButton(
          onPressed: () async {
            final launchAppStore = stars >= 4;
            final event = RateMyAppEventType.rateButtonPressed;
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
                              print(rating);
                            },
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
                        TextButton(
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
                            child: Text("Ok")),
                      ],
                    );
                  });
            }
          },
          child: Text("Rate"));
    }

    if (stars == null) {
      return [RateMyAppNoButton(widget.rateMyApp, text: "Later")];
    } else {
      return [
        RateMyAppNoButton(widget.rateMyApp, text: "Later"),
        buildRateButton(stars),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTile(
      icon: Icons.star_border_outlined,
      title: "Rate This App",
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.8),
        size: 16,
      ),
      onPress: () {
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
        // showDialog(context: context, builder: (context)=>
        // RateDialogPage(rateMyApp: rateMyApp,));
      },
    );
  }
}
