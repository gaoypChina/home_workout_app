import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/constants/constant.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/widgets/connection_error_page.dart';
import 'package:full_workout/provider/backup_provider.dart';
import 'package:full_workout/widgets/dialogs/subscription_successful_dialog.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/subscription_helper.dart';
import '../models/subscription_date_model.dart';
import '../widgets/dialogs/subscription_error_dialog.dart';
import 'connectivity_provider.dart';

class SubscriptionProvider with ChangeNotifier {
  bool isBuyBtnLoading = false;
  bool isLoading = true;
  PurchaserInfo? pInfo;

  List<Package> packageList = [];
  int offerIndex = 0;
  SubscriptionDetail? subscriptionDetail;

  init({required BuildContext context}) async {
    isLoading = true;
    try {
      await checkConnection(context: context);
      fetchOffers();
    } catch (e) {
      log(e.toString());
    }
  }

  bool get isProUser {
 //   return false;
    if (subscriptionDetail == null) {
      return false;
    } else {
      DateTime lastDate = subscriptionDetail!.lastDate;
      if (lastDate.difference(DateTime.now().toUtc()).isNegative) {
        return false;
      } else {
        return true;
      }
    }
  }

  fetchOffers() async {
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

      // PurchaserInfo? info = await Purchases.getPurchaserInfo();

      PurchaserInfo? info=  await SubscriptionHelper.purchasePackage(packageList[offerIndex]);
      if (info == null) {
        return;
      }

      String price = packageList[offerIndex].product.priceString;
      List<String> durationDiscount =
          packageList[offerIndex].product.description.split(" ");
      DateTime today = DateTime.now();
      String firstDate = today.toUtc().toIso8601String();

      String lastDate = DateTime(today.year,
              today.month + int.parse(durationDiscount[0]), today.day)
          .toIso8601String();
      if (info.entitlements.all["all_workout"]?.expirationDate != null) {
        lastDate =
            info.entitlements.all["all_workout"]!.expirationDate.toString();
      }

      SubscriptionHelper.savePurchaseDates(
          lastDate: lastDate, firstDate: firstDate, price: price);

      await Provider.of<BackupProvider>(context, listen: false)
          .setProUser(user: user);
      setSubscriptionDetails();

      showDialog(
          context: context,
          builder: (builder) => SubscriptionSuccessfulDialog());
      pInfo = info;
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
      Constants().getToast(
          "Something went wrong...");
      return;
    }

    try {

      PurchaserInfo info = await Purchases.getPurchaserInfo();
      log(info.toString());

      String getPrice(String? identifier) {
        Package? pack;
      for(var package in packageList) {
        log(package.product.identifier + " and " + identifier.toString() );

        if (package.identifier == identifier) {

          return package.product.priceString;
        }
      }
        return"";
      }



      String lastDate = info.requestDate.toString();
      String firstDate = info.latestExpirationDate.toString();
      String price = getPrice(info.activeSubscriptions.first);

      log("Last date : $lastDate, first date : $firstDate, price : $price");


    } catch (e) {
      log(e.toString());
    } finally {}
  }

  setSubscriptionDetails() async {
    SpHelper _spHelper = SpHelper();
    SpKey _spKey = SpKey();
    String? lastDate = await _spHelper.loadString(_spKey.subscriptionLastDate);
    String? firstDate = await _spHelper.loadString(_spKey.subscriptionFistDate);
    String? price = await _spHelper.loadString(_spKey.subscriptionPrice);
    if (lastDate == null || firstDate == null || price == null) {
      return;
    }
    subscriptionDetail = SubscriptionDetail(
        price: price,
        lastDate: DateTime.parse(lastDate),
        firstDate: DateTime.parse(firstDate));
    notifyListeners();
  }

  checkConnection({required BuildContext context}) async {
    bool isConnected =
        await Provider.of<ConnectivityProvider>(context, listen: false)
            .isNetworkConnected;

    if (!isConnected) {
      Navigator.pop(context);
      Navigator.of(context).pushNamed(ConnectionErrorPage.routeName);
    }
  }
}
