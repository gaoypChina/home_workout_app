import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class SubscriptionTime extends StatelessWidget {
  SubscriptionTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    var timeStyle = TextStyle(color: Colors.white);
    return Container(
      padding: EdgeInsets.only(left: 8,right: 8,bottom: 12),
      color: Colors.grey.shade800,
      child: Row(
        children: [
          Image.asset(
            "assets/other/offer.png",
            height: 90,
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            child: Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "For new members: 50% off".toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  CountdownTimer(
                    endTime: endTime,
                    widgetBuilder: (_, CurrentRemainingTime? time) {
                      if (time == null) {
                        return Text('Sale Over',style: TextStyle(color: Colors.white,fontSize: 16),);
                      }
                      return Row(
                        children: [
                          DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(4),
                            color:  Colors.white70,
                            padding: EdgeInsets.all(4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              child: Container(
                                child: Text("UPTO : 50% OFF",style: TextStyle(color: Colors.white70),),

                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            '${getTime(time.days)}  :  \nDay',
                            style: timeStyle,
                          ),
                          Text(
                            "${getTime(time.hours)}  :  \nHrs",
                            style: timeStyle,
                          ),
                          Text(
                            "${getTime(time.min)}  :  \nMin",
                            style: timeStyle,
                          ),
                          Text(
                            "${getTime(time.sec)}   \nSec",
                            style: timeStyle,
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
