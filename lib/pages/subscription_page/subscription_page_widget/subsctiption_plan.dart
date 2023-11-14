import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constant.dart';
import '../../../provider/subscription_provider.dart';

class SubscriptionPlan extends StatelessWidget {
  const SubscriptionPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionProvider>(builder: (context, provider, _) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Text(provider.info!.toString()),
        Padding(
          padding: const EdgeInsets.only(left: 18.0, bottom: 16),
          child: Text(
            "Select your plan",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        ...provider.packageList.map((package) {
          var product = package.storeProduct;
          List<String> durationDiscount = product.description.split(" ");
          int? duration = int.tryParse(durationDiscount[0]);
          int? discount = int.tryParse(durationDiscount[1]);
          if (duration == null || discount == null) {
            return Container();
          }

          String packName = product.title.split("(")[0];
          int currIdx = provider.packageList.indexOf(package);
          bool isSelected = currIdx == provider.offerIndex;
          return Padding(
            padding: EdgeInsets.only(left: 18, right: 18, bottom: 12),
            child: InkWell(
              onTap: () => provider.switchOffer(index: currIdx),
              child: Material(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                elevation: 0,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: double.infinity,
                      padding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          border: Border.all(
                              width: 2,
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).primaryColor.withOpacity(.2))),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  packName.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: isSelected
                                          ? Colors.white
                                          : Theme.of(context)
                                          .textTheme
                                          .bodyLarge!.color!.withOpacity(.8),
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${Constants()
                                      .getPerMonthPrice(product: product)} Per Month",
                                  style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Total : ${product.priceString}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: isSelected
                                            ? Colors.white
                                            : Theme.of(context)
                                            .textTheme
                                            .bodyLarge!.color!.withOpacity(.8),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: isSelected
                                  ? Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              )
                                  : Icon(
                                Icons.circle,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!.color!.withOpacity(.2),
                              )),
                        ],
                      ),
                    ),
                    if (discount != 1)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(8)),
                            color:  Colors.amber.shade700,
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: Text(
                            discount.toString() + "% OFF",
                            style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        })
      ]);
    });
  }
}
