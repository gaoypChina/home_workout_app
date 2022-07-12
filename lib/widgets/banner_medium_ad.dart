import 'package:flutter/material.dart';
import 'package:full_workout/constants/constant.dart';
import 'package:full_workout/provider/subscription_provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../provider/ads_provider.dart';

class MediumBannerAd extends StatefulWidget {
  final bool showDivider;
  final Color bgColor;

  const MediumBannerAd({
    Key? key,
    required this.showDivider,
    required this.bgColor,
  }) : super(key: key);

  @override
  _MediumBannerAdState createState() => _MediumBannerAdState();
}

class _MediumBannerAdState extends State<MediumBannerAd> {

  bool isProUser = false;

  @override
  void initState() {
    super.initState();
    isProUser = Provider.of<SubscriptionProvider>(context,listen: false).isProUser;
    if(isProUser){
      var provider = Provider.of<AdsProvider>(context, listen: false);
      provider.showBannerAd = false;
      provider.createMediumBannerAd();
    }

  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();
    var provider = Provider.of<AdsProvider>(context, listen: true);
    return isProUser? Container(): Column(
      children: [
        !provider.showBannerAd
            ? Container(height: 0)
            : Container(
                color: widget.bgColor,
                child: Column(
                  children: [
                    if (widget.showDivider) SizedBox(height: 10),
                    Center(
                      child: Container(

                        alignment: Alignment.center,
                        height: provider.bottomBannerAd.size.height.toDouble(),
                        width: provider.bottomBannerAd.size.width.toDouble(),
                        child: AdWidget(
                          ad: provider.bottomBannerAd,
                        ),
                      ),
                    ),
                    if (widget.showDivider) SizedBox(height: 10),
                    if (widget.showDivider)
                      constants.getDivider(context: context),
                  ],
                ),
              )
      ],
    );
  }
}
