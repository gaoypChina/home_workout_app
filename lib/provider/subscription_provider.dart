import 'package:flutter/cupertino.dart';
import 'package:full_workout/pages/subscription_page/subscription_page_widget/subscription_price.dart';

class SubscriptionProvider with ChangeNotifier{
  List<PriceModel> subscriptionList = [
    PriceModel(
        title: "12 Months",
        price: 7188,
        disPrice: 1188,
        duration: 12,
        recurDuration: "Year",
        perMonth: 99,
        perDis: 83),
    PriceModel(
        title: "6 Months",
        price: 3594,
        disPrice: 894,
        duration: 6,
        recurDuration: "6 Month",
        perMonth: 149,
        perDis: 75),
    PriceModel(
        title: "3 Months",
        price: 3594,
        disPrice: 894,
        duration: 6,
        recurDuration: "3 Month",
        perMonth: 149,
        perDis: 50),
    PriceModel(
        title: "1 Month",
        price: 599,
        disPrice: 199,
        duration: 1,
        recurDuration: "Month",
        perMonth: 199,
        perDis: 25),
  ];

  int offerIndex = 0;

  switchOffer({required int index}){
    offerIndex = index;
    notifyListeners();
  }
}