import 'dart:developer';

import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionHelper {
  static SpKey _spKey = SpKey();
  static SpHelper _spHelper = SpHelper();

  static const _apiKey = "goog_KCimKbWZceCgDURNizOVthdqVUi";

  static Future init() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup(_apiKey);
  }

  static Future<List<Offering>> fetchOffers() async {
    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;
      return current == null ? [] : [current];
    } catch (e) {
      log("fail to fetch offers : " + e.toString());
      return [];
    }
  }

  static Future<PurchaserInfo?> purchasePackage(Package package) async {
    try {
      PurchaserInfo info = await Purchases.purchasePackage(package,);
      return info;
    } catch (e) {
      return null;
    }
  }

  static Future savePurchaseDates(
      {required String firstDate, required String lastDate, required String price}) async {
    await _spHelper.saveString(_spKey.subscriptionFistDate, firstDate);
    await _spHelper.saveString(_spKey.subscriptionLastDate, lastDate);
    await _spHelper.saveString(_spKey.subscriptionPrice, price);

  }
}
