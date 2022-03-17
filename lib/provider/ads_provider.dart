import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:full_workout/helper/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const int maxFailedLoadAttempts = 3;

class AdsProvider with ChangeNotifier {
  late BannerAd bottomBannerAd;
  InterstitialAd? interstitialAd;

  int _interstitialLoadAttempts = 0;

  bool isLoaded = false;

  void createBottomBannerAd() {

    bottomBannerAd = BannerAd(
        adUnitId: AdIdHelper.bannerAdUnitId,
        size: AdSize.banner,
        request: AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (_) {
            log("loading.....");
            isLoaded = true;
            notifyListeners();
          },
          onAdFailedToLoad: (ad, error) {
            log("message " +
                error.message +
                " response " +
                error.responseInfo.toString() +
                " error code " +
                error.code.toString());
            log("fail to load .....");
            ad.dispose();
          },
        ));
    bottomBannerAd.load();
  }

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdIdHelper.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback:
            InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
          _interstitialLoadAttempts = 0;
          interstitialAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
              log("message : " + error.message + " error code : " + error.code.toString());
          _interstitialLoadAttempts += 1;
          interstitialAd = null;
          if (_interstitialLoadAttempts <= maxFailedLoadAttempts) {
            createInterstitialAd();
          }
        }));
  }


  void disposeBannerAd() {
    log("bottom");
    log("bottom ad : " + bottomBannerAd.toString());

      bottomBannerAd.dispose();

  }

  void disposeInterstitialAd() {
    if (interstitialAd != null) {
      interstitialAd!.dispose();
    }
  }
}
