import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../provider/ads_provider.dart';
import '../provider/subscription_provider.dart';

class RegularBannerAd extends StatefulWidget {
  const RegularBannerAd({
    Key? key,
  }) : super(key: key);

  @override
  _MediumBannerAdState createState() => _MediumBannerAdState();
}

class _MediumBannerAdState extends State<RegularBannerAd> {
  bool isProUser = false;

  @override
  void initState() {
    super.initState();
    isProUser =
        Provider.of<SubscriptionProvider>(context, listen: false).isProUser;
    var provider = Provider.of<AdsProvider>(context, listen: false);
    provider.showBannerAd = false;
    if (isProUser) {
    } else {
      provider.disposeBannerAd();
      provider.createBottomBannerAd();
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AdsProvider>(context, listen: true);
    return isProUser
        ? Container(height: 0,)
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              (provider.showBannerAd && provider.bottomBannerAd != null)
                  ? Container(
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          height:
                              provider.bottomBannerAd!.size.height.toDouble(),
                          width: provider.bottomBannerAd!.size.width.toDouble(),
                          child: AdWidget(
                            ad: provider.bottomBannerAd!,
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          );
  }
}
