import 'dart:io';

///todo : switch to true while app in production
bool isProduction = true;

class AdIdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      if (isProduction) {
        return "ca-app-pub-7026200685541671/3922608844";
      }
      return "ca-app-pub-3940256099942544/6300978111";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/2934735716";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerMediumAdUnitId {
    if (Platform.isAndroid) {
      if (isProduction) {
        return "ca-app-pub-7026200685541671/7670282166";
      }
      return "ca-app-pub-3940256099942544/6300978111";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/2934735716";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      if (isProduction) {
        return "ca-app-pub-7026200685541671/4852547131";
      }
      return "ca-app-pub-3940256099942544/8691691433";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/5135589807";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardAdUnitId {
    if (Platform.isAndroid) {
      if (isProduction) {
        return "ca-app-pub-7026200685541671/3674648099";
      }
      return "ca-app-pub-3940256099942544/5224354917";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/5224354917";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
