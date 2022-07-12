import 'dart:developer';

import 'package:flutter/cupertino.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider with ChangeNotifier {
  bool isOnline = true;
  final Connectivity _connectivity = Connectivity();

  Future<bool> get isNetworkConnected async {
    Connectivity _connectivity = Connectivity();
    var status = await _connectivity.checkConnectivity();

    if (status == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> checkConnection() async {
    _connectivity.onConnectivityChanged.listen((result) async {
      if (result == ConnectivityResult.none) {
        isOnline = false;
        notifyListeners();
      } else {
        isOnline = true;
        notifyListeners();
      }
    });
    return isOnline;
  }

}
