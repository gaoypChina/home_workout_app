import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_remaining/time_remaining.dart';

class SubscriptionCountdown extends StatefulWidget {
  const SubscriptionCountdown({super.key});

  @override
  State<SubscriptionCountdown> createState() => _SubscriptionCountdownState();
}

class _SubscriptionCountdownState extends State<SubscriptionCountdown> {
  bool showBanner = true;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    return Visibility(
      visible: showBanner,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        color: Colors.amber.withOpacity(.5),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "For new members upto 50% off",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.color!
                            .withOpacity(.7)),
                  ),
                  Row(
                    children: [
                      Text(
                        "Offer end: ",
                        style: TextStyle(fontSize: 16),
                      ),
                      TimeRemaining(
                        duration:
                            DateTime(today.year, today.month, today.day, 24)
                                .difference(DateTime.now()),
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Colors.red.shade900),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
                onTap: () async {
                  bool? res = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Container(
                            child: Text(""),
                          ),
                          title: Text("Are you sure?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: Text("Yes")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: Text("No")),
                          ],
                        );
                      });

                  if (res == true) {
                    setState(() {
                      showBanner = !showBanner;
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8).copyWith(left: 8),
                  child: Icon(Icons.close_rounded),
                ))
          ],
        ),
      ),
    );
  }
}
