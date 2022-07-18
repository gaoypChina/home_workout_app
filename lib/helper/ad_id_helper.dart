import 'dart:io';

bool isProduction = false;
class AdIdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      if(isProduction){
        return "ca-app-pub-6411653236715435/8096929282";
      }
      return "ca-app-pub-3940256099942544/6300978111";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/2934735716";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerMediumAdUnitId{
    if (Platform.isAndroid) {
      if(isProduction){
        return "ca-app-pub-6411653236715435/5279194252";
      }
      return "ca-app-pub-3940256099942544/6300978111";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/2934735716";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId{
    if (Platform.isAndroid) {
      if(isProduction){
        return "ca-app-pub-6411653236715435/1503600778";
      }
      return "ca-app-pub-3940256099942544/8691691433";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/5135589807";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardAdUnitId{
    if (Platform.isAndroid) {
      if(isProduction){
        return "ca-app-pub-6411653236715435/3582969205";
      }
      return "ca-app-pub-3940256099942544/5224354917";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/5224354917";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
