import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:full_workout/helper/ad_id_helper.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/provider/subscription_provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../helper/ad_helper.dart';

const int maxFailedLoadAttempts = 3;

class AdsProvider with ChangeNotifier {

  InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;
  BannerAd? bottomBannerAd;
  BannerAd? bannerMediumAd;

  int _interstitialLoadAttempts = 0;
  int _rewardLoadAttempts = 0;
  bool isLoading = false;
  bool showBannerAd = false;
  bool loadingError = false;
  bool isRewarded = false;

  void createBottomBannerAd() {
    bottomBannerAd = BannerAd(
        adUnitId: AdIdHelper.bannerAdUnitId,
        size: AdSize.banner,
        request: AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (_) {
            log("ad loaded");
            showBannerAd = true;
            notifyListeners();
          },
          onAdFailedToLoad: (ad, error) {
            showBannerAd = false;
            notifyListeners();
            ad.dispose();
          },
        ));
    bottomBannerAd!.load();
  }

  void createMediumBannerAd() {
    bannerMediumAd = BannerAd(
        adUnitId: AdIdHelper.bannerMediumAdUnitId,
        size: AdSize.mediumRectangle,
        request: AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (_) {
            showBannerAd = true;
            notifyListeners();
          },
          onAdFailedToLoad: (ad, error) {
            showBannerAd = false;
            notifyListeners();
            ad.dispose();
          },
        ));
    bannerMediumAd!.load();
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
          log("message : " +
              error.message +
              " error code : " +
              error.code.toString());
          _interstitialLoadAttempts += 1;
          interstitialAd = null;
          if (_interstitialLoadAttempts <= maxFailedLoadAttempts) {
            createInterstitialAd();
          }
        }));
  }

  createRewardAd({required BuildContext context, required String key}) async {
    loadingError = false;
    isLoading = true;
    notifyListeners();
    await RewardedAd.load(
        adUnitId: AdIdHelper.rewardAdUnitId,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdFailedToLoad: (LoadAdError error) {
            _rewardLoadAttempts += 1;
            log(_rewardLoadAttempts.toString());
            rewardedAd = null;

            if (_rewardLoadAttempts < maxFailedLoadAttempts) {
              createRewardAd(context: context,key: key);
            }
            if (_rewardLoadAttempts == maxFailedLoadAttempts) {
              _rewardLoadAttempts = 0;
              loadingError = true;
              isLoading = false;
              notifyListeners();
            }
          },
          onAdLoaded: (RewardedAd ad) {
            _rewardLoadAttempts = 0;
            rewardedAd = ad;
            AdHelper().showRewardAd(context: context, key: key);
            isLoading = false;
            notifyListeners();
          },
        ));
  }

  void disposeBannerAd() {
    if(bottomBannerAd != null){
      bottomBannerAd!.dispose();
    }
  }

  void disposeBannerMediumAd() {
    if(bannerMediumAd != null){
      bannerMediumAd!.dispose();
    }
  }

  void disposeInterstitialAd() {
    if (interstitialAd != null) {
      interstitialAd!.dispose();
    }
  }

  void disposeRewardAd() {
    if (rewardedAd != null) {
      rewardedAd!.dispose();
    }
  }

  onRewardLoaded(){
    isRewarded = true;
    notifyListeners();
  }

  Future<bool> isUnlocked({required String key,required BuildContext context}) async {
    if (Provider.of<SubscriptionProvider>(context,listen: false).isProUser) {
      return true;
    } else {
      String? date = await SpHelper().loadString(key);
      if (date == null) {
        return false;
      } else {
        DateTime parsedTime = DateTime.parse(date);
        return DateTime.now().difference(parsedTime).inHours <= 12;
      }
    }
  }

}
