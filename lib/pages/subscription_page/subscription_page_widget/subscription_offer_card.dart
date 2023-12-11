import 'package:flutter/material.dart';
import 'package:full_workout/helper/backup_helper.dart';
import 'package:full_workout/helper/mediaHelper.dart';
import 'package:slide_countdown/slide_countdown.dart';

class SubscriptionOfferCard extends StatefulWidget {
  const SubscriptionOfferCard({super.key});

  @override
  State<SubscriptionOfferCard> createState() => _SubscriptionOfferCardState();
}

class _SubscriptionOfferCardState extends State<SubscriptionOfferCard> {
  @override
  Widget build(BuildContext context) {
    buildTimer() {
      return SlideCountdownSeparated(
        duration: Duration(days: 2),

        durationTitle: DurationTitle(days: "Day", hours:"Hr",seconds: "sec" ,minutes: "min"),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          children: [
            Image.asset("assets/image.jpeg"),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              color: Colors.amber.shade900,
              child: Row(
                children: [
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Offer end in: ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    child: buildTimer(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

    // return
    //
    //
    //
    //   Container(
    //   margin: EdgeInsets.symmetric(horizontal: 16),
    //   padding: EdgeInsets.symmetric(horizontal: 18),
    //   decoration: BoxDecoration(
    //     color: Color(0xffff4532),
    //     borderRadius: BorderRadius.circular(12),
    //   ),
    //   child: Row(
    //     children: [
    //       Expanded(
    //         flex: 5,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             SizedBox(
    //               height: 20,
    //             ),
    //             Text(
    //               "Pro Member(Upto 50% off)",
    //               style: TextStyle(
    //                   fontWeight: FontWeight.w600,
    //                   fontSize: 18,
    //                   color: Colors.white),
    //             ),
    //             SizedBox(
    //               height: 4,
    //             ),
    //             buildTimer(),
    //             SizedBox(
    //               height: 4,
    //             ),
    //             Text(
    //               "All features unlocked!",
    //               style: TextStyle(
    //                   fontWeight: FontWeight.w400,
    //                   fontSize: 15,
    //                   color: Colors.white),
    //             ),
    //             SizedBox(
    //               height: 22,
    //             ),
    //             InkWell(
    //               onTap: () {
    //                 BackupHelper().getOffer();
    //               },
    //               child: Container(
    //                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(12),
    //                     color: Colors.white),
    //                 child: const Text(
    //                   "Subscribe now",
    //                   style: TextStyle(
    //                       fontWeight: FontWeight.w600, color: Colors.black),
    //                 ),
    //               ),
    //             ),
    //             SizedBox(
    //               height: 20,
    //             )
    //           ],
    //         ),
    //       ),
    //       Expanded(
    //         flex: 2,
    //         child: Image.network(
    //             "https://cdn-icons-png.flaticon.com/128/10737/10737457.png"),
    //       )
    //     ],
    //   ),
    // );
  }
}
