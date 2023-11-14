import 'dart:developer';

import '../../helper/sp_helper.dart';
import '../../helper/sp_key_helper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionHelper {
  static SpKey _spKey = SpKey();
  static SpHelper _spHelper = SpHelper();

  static const _apiKey = "goog_uNuJkHhSxcJWwpEoHdVNLvmDUiB";

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

  static Future<CustomerInfo?> purchasePackage(Package package) async {
    try {
      CustomerInfo info = await Purchases.purchasePackage(
        package,
      );
      return info;
    } catch (e) {
      return null;
    }
  }

  static Future savePurchaseDates(
      {required CustomerInfo info, String? price}) async {
    String identifier = info.activeSubscriptions.first;
    String firstDate = info.allPurchaseDates[identifier]!;
    String lastDate = info.allExpirationDates[identifier]!;

    await _spHelper.saveString(_spKey.subscriptionIdentifier, identifier);
    await _spHelper.saveString(_spKey.subscriptionFistDate, firstDate);
    await _spHelper.saveString(_spKey.subscriptionLastDate, lastDate);
    await _spHelper.saveString(_spKey.subscriptionPrice, price ?? "0");
  }
}
