import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:full_workout/pages/workout_page/report_page.dart';
import 'package:rate_my_app/rate_my_app.dart';

import '../main/setting_page/setting_screen.dart';

class RateDialogPage extends StatefulWidget {
  final RateMyApp rateMyApp;

  RateDialogPage({@required this.rateMyApp});

  @override
  _RateDialogPageState createState() => _RateDialogPageState();
}

class _RateDialogPageState extends State<RateDialogPage> {
  String comment = "";

  List<Widget> actionsBuilder(BuildContext context, double stars, bool isDark) {
    Widget buildRateButton(double starts) {
      return TextButton(
          onPressed: () async {
            final launchAppStore = stars >= 4;
            final event = RateMyAppEventType.rateButtonPressed;
            await widget.rateMyApp.callEvent(event);
            if (launchAppStore) {
              widget.rateMyApp.launchStore();
            } else {
              Navigator.of(context).pop();
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Rate this App"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      contentPadding: EdgeInsets.all(16),
                      content: TextFormField(
                          maxLines: 5,
                          autofocus: true,
                          decoration: InputDecoration(
                              hintText: 'Write your review....',
                              contentPadding: EdgeInsets.all(8.0),
                              border: OutlineInputBorder()),
                          onChanged: (comment) =>
                              setState(() => this.comment = comment)),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              String toSend = "$comment\n\n";

                              final Email email = Email(
                                body: toSend,
                                subject: 'App Review',
                                recipients: ['workoutfeedback@gmail.com'],
                                isHTML: false,
                              );

                              try {
                                await FlutterEmailSender.send(email);
                              } catch (e) {
                                constants.getToast(
                                    "Thanks for your Feedback", isDark);
                              }
                            },
                            child: Text("Ok")),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel"),
                        )
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
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return CustomTile(
      color: Colors.green,
      icon: Icons.star,
      title: "Rate my App",
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: 16,
      ),
      onPress: () {
        widget.rateMyApp.showStarRateDialog(context,
            title: "Rate this App",
            message: "Do you like this app? Please leave a rating",
            starRatingOptions: StarRatingOptions(initialRating: 4),
            actionsBuilder: (context, stars) {
          return actionsBuilder(context, stars, isDark);
        });
        // showDialog(context: context, builder: (context)=>
        // RateDialogPage(rateMyApp: rateMyApp,));
      },
    );
  }
}
