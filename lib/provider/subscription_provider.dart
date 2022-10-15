import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import '../../../constants/constant.dart';
import '../../../helper/sp_helper.dart';
import '../../../helper/sp_key_helper.dart';
import '../../../widgets/dialogs/subscription_successful_dialog.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/subscription_helper.dart';
import '../models/subscription_date_model.dart';
import '../widgets/dialogs/subscription_error_dialog.dart';

class SubscriptionProvider with ChangeNotifier {
  bool isBuyBtnLoading = false;
  bool isLoading = true;
  bool isProUser = false;

  List<Package> packageList = [];
  int offerIndex = 0;
  SubscriptionDetail? subscriptionDetail;
  Constants _constants = Constants();

  fetchOffers() async {
    isLoading = true;
    notifyListeners();
    try {
      await SubscriptionHelper.init();
      final offerings = await SubscriptionHelper.fetchOffers();
      packageList = offerings
          .map((offer) => offer.availablePackages)
          .expand((pair) => pair)
          .toList();

      packageList.sort((p1, p2) {
        return Comparable.compare(
          p2.product.price,
          p1.product.price,
        );
      });
    } catch (e) {
      log("subscriptions fetching error : ${e.toString()}");
      packageList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  switchOffer({required int index}) {
    offerIndex = index;
    notifyListeners();
  }

  onBuyBtnClick({required BuildContext context}) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Constants().getToast("Something went wrong");
      return;
    }
    try {
      isBuyBtnLoading = true;
      notifyListeners();
      PurchaserInfo? info =
          await SubscriptionHelper.purchasePackage(packageList[offerIndex]);
      if (info == null) {
        throw "subscription info is calling on null";
      }
      String price = packageList[offerIndex].product.priceString;
      await SubscriptionHelper.savePurchaseDates(info: info, price: price);
      await setSubscriptionDetails();
      showDialog(
          context: context,
          builder: (builder) => SubscriptionSuccessfulDialog());
    } catch (e) {
      showDialog(
          context: context, builder: (context) => SubscriptionErrorDialog());
    } finally {
      isBuyBtnLoading = false;
      notifyListeners();
    }
  }

  cancelSubscription() async {
    String _url = "https://play.google.com/store/account/subscriptions";
    try {
      await launchUrl(Uri.parse(_url), mode: LaunchMode.externalApplication);
    } catch (e) {
      Constants().getToast(
          "Not able to open subscription setting, you can cancel subscription manually from play store");
    }
  }

  restoreSubscription({required BuildContext context}) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _constants.getToast("Something went wrong");
      return;
    }
    try {
      PurchaserInfo info = await Purchases.getPurchaserInfo();
      if (info.activeSubscriptions.isEmpty) {
        _constants.getToast("No subscription found!");
        return;
      }
      await fetchOffers();
      String key = info.activeSubscriptions.first;
      int start = 0;
      for (start = 0; start < packageList.length; start++) {
        if (packageList[start].product.identifier == key) {
          break;
        }
      }

      String price = packageList[start].product.priceString;

      SubscriptionHelper.savePurchaseDates(info: info, price: price);
      await setSubscriptionDetails();
    } catch (e) {
      _constants.getToast("Something went wrong");
    } finally {
      notifyListeners();
    }
  }

  Future<void> setSubscriptionDetails() async {

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      log("user is not logged in");
      return;
    }
    try {
      await SubscriptionHelper.init();

      PurchaserInfo info = await Purchases.getPurchaserInfo();
      if (info.activeSubscriptions.isNotEmpty) {
        isProUser = true;
      }
      log("premium user : $isProUser");
      SpHelper _spHelper = SpHelper();
      SpKey _spKey = SpKey();
      String? lastDate =
          await _spHelper.loadString(_spKey.subscriptionLastDate);
      String? firstDate =
          await _spHelper.loadString(_spKey.subscriptionFistDate);
      String? price = await _spHelper.loadString(_spKey.subscriptionPrice);
      String? identifier =
          await _spHelper.loadString(_spKey.subscriptionIdentifier);

      if (lastDate == null ||
          firstDate == null ||
          price == null ||
          identifier == null) {
        log("no subscription found");
        return;
      }
      log("identifier: $identifier, price: $price, last date: $lastDate, first date: $firstDate");
      subscriptionDetail = SubscriptionDetail(
          identifier: identifier,
          price: price,
          lastDate: DateTime.parse(lastDate),
          firstDate: DateTime.parse(firstDate));
    } catch (e) {
      log("error : ${e.toString()}");
    } finally {
      notifyListeners();
    }
  }


}
