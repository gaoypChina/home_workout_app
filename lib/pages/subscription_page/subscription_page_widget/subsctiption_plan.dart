import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../constants/constant.dart';
import '../../../provider/subscription_provider.dart';

class SubscriptionPlan extends StatefulWidget {
  const SubscriptionPlan({super.key});

  @override
  State<SubscriptionPlan> createState() => _SubscriptionPlanState();
}

class _SubscriptionPlanState extends State<SubscriptionPlan> {
  List<SubscriptionCardModal> subscriptionList = [];

  @override
  void initState() {
    var provider = Provider.of<SubscriptionProvider>(context, listen: false);
    provider.packageList.forEach((package) {
      var product = package.storeProduct;
      List<String> durationDiscount = product.description.split(" ");
      int? duration = int.tryParse(durationDiscount[0]);
      int? discount = int.tryParse(durationDiscount[1]);
      if (duration == null || discount == null) {
        return;
      }

      String packName = product.title.split("(")[0];
      subscriptionList.add(SubscriptionCardModal(
          title: "Go Pro",
          duration: "$duration \nMonth",
          colors: [Colors.red, Colors.blue.shade900],
          perMonth: "${Constants().getPerMonthPrice(product: product)}",
          price: product.priceString,
          discount: discount));
    });
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).textTheme.bodyMedium!.color == Colors.white;
    var themeColor = Theme.of(context).textTheme.bodyMedium!.color!;
    double width = MediaQuery.of(context).size.width;
    double height = 220;
    double radius = 12;
    var provider = Provider.of<SubscriptionProvider>(context, listen: false);

    buildCard1({required SubscriptionCardModal offer}) {
      int currentIdx = subscriptionList.indexOf(offer);
      bool isSelected = currentIdx == provider.offerIndex;
      return Padding(
        padding: const EdgeInsets.only(right: 16.0, top: 6, bottom: 6),
        child: InkWell(
          onTap: () {
            provider.switchOffer(index: currentIdx);
          },
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            fit: StackFit.loose,
            children: [
              Column(
                children: [
                  offer.discount != 1
                      ? Container(
                          child: Text(
                            offer.discount.toString() + "% OFF",
                            style: TextStyle(
                                color: isSelected ? Colors.white : null,
                                fontWeight: FontWeight.w500),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: isSelected
                                      ? Colors.blue.shade900
                                      : Colors.white.withOpacity(.1)),
                              gradient: isSelected
                                  ? LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [...offer.colors])
                                  : null,
                              color: isSelected
                                  ? Colors.blue.shade900
                                  : isDark
                                      ? Colors.grey.shade800.withOpacity(.15)
                                      : Colors.grey.withOpacity(.2),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12))),
                        )
                      : SizedBox(
                          height: 33,
                        ),
                  Expanded(
                    child: AnimatedContainer(
                      width: width * .35,
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.grey.shade900.withOpacity(.8)
                            : Colors.white,
                        border: Border.all(
                            color: isSelected
                                ? Colors.blue.shade900
                                : Colors.white.withOpacity(.1)),
                        gradient: isSelected
                            ? LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [...offer.colors])
                            : null,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.blue.withOpacity(.08)
                                : Colors.grey.withOpacity(0.15),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(-3, 3),
                          ),
                        ],
                      ),
                      duration: Duration(milliseconds: 400),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.grey.shade800.withOpacity(.15)
                                      : Colors.grey.shade100,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(radius),
                                      topRight: Radius.circular(radius))),
                              child: Text(
                                offer.duration,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: themeColor.withOpacity(.7),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Container(height: 1,color: Colors.transparent,),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(radius),
                                      bottomRight: Radius.circular(radius))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      "${offer.price}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : isDark
                                                  ? Colors.white.withOpacity(.8)
                                                  : Colors.black
                                                      .withOpacity(.7),
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Text(
                                    "${offer.perMonth}/ month",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: isSelected
                                            ? Colors.white
                                            : isDark
                                                ? Colors.white.withOpacity(.8)
                                                : Colors.black.withOpacity(.8)),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      height: height,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            width: 18,
          ),
          ...subscriptionList.map((offer) => buildCard1(offer: offer))
        ],
      ),
    );
  }
}

class SubscriptionCardModal {
  final String title;
  final String duration;
  final List<Color> colors;
  final String perMonth;
  final String price;
  final int discount;

  SubscriptionCardModal(
      {required this.title,
      required this.duration,
      required this.colors,
      required this.price,
      required this.perMonth,
      required this.discount});
}
