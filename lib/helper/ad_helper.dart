import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import '../../helper/sp_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../provider/ads_provider.dart';

class AdHelper {
  showRewardAd({required BuildContext context, required String key}) {
    var provider = Provider.of<AdsProvider>(context, listen: false);
    if (provider.rewardedAd != null) {
      provider.rewardedAd!.fullScreenContentCallback =
          FullScreenContentCallback(

              //         onAdDismissedFullScreenContent: (RewardedAd ad) {
              //
              //   _showFailMessage(
              //       context: context,
              //       content: "Watch complete AD to generate reward");
              // ad.dispose();
              // },

              onAdFailedToShowFullScreenContent:
                  (RewardedAd ad, AdError error) {
        _showFailMessage(
            context: context,
            content: "Something went wrong please retry after sometime");
        ad.dispose();
      });
      provider.rewardedAd!.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        _showSuccessMessage(context: context, key: key);
      });
    }
  }

  _showFailMessage({required BuildContext context, required String content}) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Fail to load reward',
      desc: content,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    )..show();
  }

  _showSuccessMessage(
      {required BuildContext context, required String key}) async {
    SpHelper().saveString(key, DateTime.now().toIso8601String());

    Provider.of<AdsProvider>(context, listen: false).onRewardLoaded();
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Reward generated successfully',
      btnOkText: "Continue",
      btnOkOnPress: () {
        Navigator.of(context).pop();
      },
    )..show();
  }
}
