import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../constants/constant.dart';
import '../../../provider/subscription_provider.dart';

class PriceCardSection extends StatefulWidget {
  const PriceCardSection({super.key});

  @override
  State<PriceCardSection> createState() => _PriceCardSectionState();
}

class _PriceCardSectionState extends State<PriceCardSection> {
  int selectedPlanId = 0;

  List<SubscriptionCardModal> subscriptionList = [];

  @override
  void initState() {
    var provider = Provider.of<SubscriptionProvider>(context,listen: false);
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
          colors: [Colors.red, Colors.purple],
          perMonth:
              "${Constants().getPerMonthPrice(product: product)}",
          price: product.priceString));
    });
    setState(() {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = 200;
    double radius = 12;

    buildCard({required SubscriptionCardModal offer}) {
      int currentIdx = subscriptionList.indexOf(offer);
      bool isSelected = currentIdx == selectedPlanId;
      return Padding(
        padding: const EdgeInsets.only(right: 16.0, top: 6, bottom: 6),
        child: InkWell(
          onTap: () {
            setState(() {
              selectedPlanId = currentIdx;
            });
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                width: width * .4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: isSelected
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [...offer.colors])
                      : null,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(-3, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    isSelected
                        ? Text(
                            offer.title,
                            style:
                                TextStyle(fontSize: 28.0, color: Colors.white),
                          )
                        : GradientText(offer.title,
                            style: TextStyle(
                              fontSize: 28.0,
                            ),
                            colors: offer.colors),
                    Text(
                      offer.duration,
                      style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Pay ${offer.perMonth} per month",
                      style: TextStyle(
                          fontSize: 15,
                          color: isSelected
                              ? Colors.white
                              : Colors.black.withOpacity(.8)),
                    ),
                    SizedBox(
                      height: 12,
                    )
                  ],
                ),
              ),
              Positioned(
                  top: -5,
                  left: 10,
                  child: Icon(
                    Icons.bookmark,
                    color: offer.colors[1].withOpacity(.6),
                  ))
            ],
          ),
        ),
      );
    }

    buildCard1({required SubscriptionCardModal offer}) {
      int currentIdx = subscriptionList.indexOf(offer);
      bool isSelected = currentIdx == selectedPlanId;
      return Padding(
        padding: const EdgeInsets.only(right: 16.0, top: 6, bottom: 6),
        child: InkWell(
          onTap: () {
            setState(() {
              selectedPlanId = currentIdx;
            });
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: width * .35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: isSelected
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [...offer.colors])
                      : null,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(-3, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radius),
                                topRight: Radius.circular(radius))),
                        child: Text(
                          offer.duration,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black.withOpacity(.7),
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
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
                                        : Colors.black.withOpacity(.7),
                                    fontSize: 24,
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
                                      : Colors.black.withOpacity(.8)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                  top: -5,
                  left: 10,
                  child: Icon(
                    Icons.bookmark,
                    color: offer.colors[1].withOpacity(.6),
                  ))
            ],
          ),
        ),
      );
    }

    return Container(
      height: height,
      child: ListView(
        scrollDirection: Axis.horizontal,
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

  SubscriptionCardModal(
      {required this.title,
      required this.duration,
      required this.colors,
      required this.price,
      required this.perMonth});
}
