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
    bool isDark = Theme.of(context).textTheme.bodyLarge!.color == Colors.white;

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
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.color!
                            .withOpacity(.8)),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Offer end : ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.color!
                                .withOpacity(.8)),
                      ),
                      TimeRemaining(
                        onTimeOver: () {
                          setState(() {});
                        },
                        duration:
                            DateTime(today.year, today.month, today.day, 24)
                                .difference(DateTime.now()),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color:isDark? Colors.white: Colors.red.shade900),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
                onTap: () async {
                  setState(() {
                    showBanner = !showBanner;
                  });
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
