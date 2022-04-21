import 'package:flutter/material.dart';
import 'package:full_workout/constants/constant.dart';
import 'package:full_workout/provider/subscription_provider.dart';
import 'package:provider/provider.dart';

class SubscriptionPrice extends StatefulWidget {
  const SubscriptionPrice({Key? key}) : super(key: key);

  @override
  State<SubscriptionPrice> createState() => _SubscriptionPriceState();
}

class _SubscriptionPriceState extends State<SubscriptionPrice> {



  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();
    double width = MediaQuery.of(context).size.width;

    var data = Provider.of<SubscriptionProvider>(context,listen: false);

    buildCard(PriceModel model, int index) {
      bool isSelected = index == data.offerIndex;
      return Stack(
        children: [
          InkWell(
            onTap: () {
              data.switchOffer(index: index);
            },
            child: Material(
              color: Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              elevation:isSelected? .5: 0,
              child: Container(
                width: width * .43,
                decoration: BoxDecoration(
                  border: Border.all( color:isSelected ? Colors.blue.shade700 : Colors.blue.withOpacity(.3),),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.shade700 : Colors.blue.withOpacity(.3),

                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          Text(
                            model.title,
                            style: TextStyle(
                                color: isSelected ? Colors.white : Theme.of(context).textTheme.bodyText1!.color,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          Text(
                            constants.getPrice(price: model.price) + "/m",
                            style: TextStyle(
                                color: isSelected ? Colors.white : Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8, bottom: 12, top: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${constants.getPrice(price: model.perMonth)}/m",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: isSelected? FontWeight.w500:FontWeight.w400),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Row(children: [
                            Icon(
                              Icons.verified_outlined,
                              color: Colors.green,
                              size: 14,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text("Total : "+constants.getPrice(price: model.disPrice) ,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
                          ]),
                          Row(
                            children: [
                              Icon(
                                Icons.star_outline,
                                color: Colors.orange,
                                size: 15,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(model.perDis.toString() + "% Discount",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),)
                            ],
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            Row(
              children: [
                buildCard(data.subscriptionList[0], 0),
                Spacer(),
                buildCard(data.subscriptionList[1], 1),
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              children: [
                buildCard(data.subscriptionList[2], 2),
                Spacer(),
                buildCard(data.subscriptionList[3], 3),
              ],
            )
          ],
        ));
  }
}

class PriceModel {
  final int price;
  final int disPrice;
  final int duration;
  final String recurDuration;
  final int perMonth;
  final String title;
  final int perDis;

  PriceModel(
      {required this.price,
      required this.duration,
      required this.disPrice,
      required this.recurDuration,
      required this.title,
      required this.perDis,
      required this.perMonth});
}
