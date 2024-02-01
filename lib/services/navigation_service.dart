 import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NavigationService {
  static push({required Widget page}) {
    return navigatorKey.currentState
        ?.push(MaterialPageRoute(builder: (builder) {
      return page;
    }));
  }

  static pushName(
      {required String routeName, Map<String, dynamic>? arguments}) {
    return navigatorKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  static pushReplacement({required Widget newPage}) {
    return navigatorKey.currentState
        ?.pushReplacement(MaterialPageRoute(builder: (builder) {
      return newPage;
    }));
  }

  static pushReplacementName({required String routeName}) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  static pushAndRemoveUntil({required Widget page}) {
    return navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (builder) {
          return page;
        }), (route) => route.isFirst);
  }

  static pop() {
    return navigatorKey.currentState?.pop();
  }
}