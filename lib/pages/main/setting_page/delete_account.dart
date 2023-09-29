import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:provider/provider.dart';

import '../../../provider/subscription_provider.dart';

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({Key? key}) : super(key: key);

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  bool isHidden = false;

  @override
  Widget build(BuildContext context) {
    buildDetail(String detail) {
      return Row(
        children: [
          Icon(
            Icons.circle,
            size: 8,
          ),
          SizedBox(
            width: 12,
          ),
          Text(detail),
        ],
      );
    }

    buildCancelSubscription() {
      return RichText(
          text: TextSpan(children: [
            TextSpan(
                text:
                "NOTE: If you have subscribed to any workout plan then you have to ",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(.7),
                    fontSize: 14)),
            WidgetSpan(
                child: InkWell(
                  onTap: () => Provider.of<SubscriptionProvider>(context, listen: false)
                      .cancelSubscription(),
                  child: Text(
                    "Cancel subscription".toUpperCase(),
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )),
            TextSpan(
                text:
                " manually otherwise you will be charged at the end of billing cycle.",
                style: TextStyle(
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(.7),
                    fontSize: 14)),
          ]));
    }

    return AlertDialog(
      title: Text("Delete Account"),
      actions: [
        CountdownTimer(
          endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 30,
          widgetBuilder: (_, CurrentRemainingTime? time) {
            if (time == null) {
              return TextButton(
                  onPressed: () {

                    Navigator.pop(context, true);
                  },
                  child: Text(
                    "Delete".toUpperCase(),
                    style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),
                  ));
            }
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'DELETE (${time.sec}s)',
                  style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(.8),
                      fontWeight: FontWeight.w600),
                ),
              ],
            );
          },
        ),
        SizedBox(width: 4,),
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel")),
        SizedBox(width: 4,)
      ],
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Depending on your usage of our services your data get deleted. After deletion of your account You can't restore following data:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 4,
            ),
            buildDetail("Your workout history."),
            buildDetail("Your profile details."),
            buildDetail("Identity details."),
            SizedBox(
              height: 12,
            ),
            buildCancelSubscription(),
          ],
        ),
      ),
    );
  }
}
