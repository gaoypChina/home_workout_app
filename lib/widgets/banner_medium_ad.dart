import 'package:flutter/material.dart';
import '../../provider/subscription_provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../provider/ads_provider.dart';

class MediumBannerAd extends StatefulWidget {
  const MediumBannerAd({
    Key? key,
  }) : super(key: key);

  @override
  _MediumBannerAdState createState() => _MediumBannerAdState();
}

class _MediumBannerAdState extends State<MediumBannerAd> {
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
      provider.disposeBannerMediumAd();
      provider.createMediumBannerAd();
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AdsProvider>(context, listen: true);
    return isProUser
        ? Container()
        : Column(
            children: [
              (provider.showBannerAd && provider.bannerMediumAd != null)
                  ? Container(
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          height:
                              provider.bannerMediumAd!.size.height.toDouble(),
                          width: provider.bannerMediumAd!.size.width.toDouble(),
                          child: AdWidget(
                            ad: provider.bannerMediumAd!,
                          ),
                        ),
                      ),
                    )
                  : Container(height: 0)
            ],
          );
  }
}
