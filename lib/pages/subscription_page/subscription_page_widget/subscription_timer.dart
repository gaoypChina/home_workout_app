import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class SubscriptionTime extends StatelessWidget {
  SubscriptionTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardHeight = 140;
    double radius = 36;
    double vertical = 45;
    double horizontal = 28;
    DateTime tomorrow = DateTime.now().add(Duration(hours: 24));

    int endTime = DateTime.now().millisecondsSinceEpoch +
        DateTime(tomorrow.year, tomorrow.month, tomorrow.day)
            .toLocal()
            .difference(DateTime.now())
            .inMilliseconds;

    String getTime(int? time) {
      if (time == null) {
        return "00";
      } else if (time.toString().length == 1) {
        return "0$time";
      } else {
        return time.toString();
      }
    }

    var fgColor = Colors.white;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.amber.shade900,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
            height: cardHeight,
          ),
          Positioned(

              top: vertical,
               left: -1 * horizontal,
              child: Container(
            height: radius,
            width: radius,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          )),
          Positioned(
              top: vertical,
              right: -1 * horizontal,
              child: Container(
                height: radius,
                width: radius,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              )),
            Container(
            decoration: BoxDecoration(

                borderRadius: BorderRadius.all(Radius.circular(12))),
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 12, top: 12),
            child: Row(
              children: [
                // Image.asset(
                //   "assets/other/offer.png",
                //   height: 90,
                // ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New member pass",
                        style: TextStyle(
                            color: fgColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "For new members upto 50% off",
                        style: TextStyle(
                            color: fgColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                        SizedBox(height: 12,),
                      Text(
                        "Offer end in :",
                        style: TextStyle(
                            color: fgColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                        CountdownTimer(
                          endTime: endTime,
                          widgetBuilder: (_, CurrentRemainingTime? time) {
                            if (time == null) {
                              return Text(
                                'Sale Over',
                              style: TextStyle(color: fgColor, fontSize: 16),
                            );
                            }
                            return Row(
                              children: [

                                Text(
                                  '${getTime(time.days)}  :  \nDay',
                                style: TextStyle(color: fgColor),
                              ),
                                Text(
                                  "${getTime(time.hours)}  :  \nHrs",
                                style: TextStyle(color: fgColor),
                              ),
                                Text(
                                  "${getTime(time.min)}  :  \nMin",
                                style: TextStyle(color: fgColor),
                              ),
                                Text(
                                  "${getTime(time.sec)}   \nSec",
                                style: TextStyle(color: fgColor),
                              )
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
              ],
            ),

            )],
      ),
    );

  }
}
