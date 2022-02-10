import 'package:flutter/material.dart';

class FadeTransitionPageRouteBuilder extends PageRouteBuilder {
  final Widget page;
  FadeTransitionPageRouteBuilder({required this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    opaque:false,
    barrierColor:null,
    barrierLabel:null,
    maintainState:true,
    transitionDuration:Duration(milliseconds: 100),
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
  );
}

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  Future<dynamic> navigate(String path,{required Object args}) {
    return navigatorKey.currentState!.pushNamed(path,arguments: args);
  }

  Future<dynamic> navigateAndReplace(String path,{required Object args}) {
    return navigatorKey.currentState!.pushReplacementNamed(path,arguments: args);
  }

  Future<dynamic> navigateAndRemoveUntil(String path) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(path,(Route<dynamic> route) => false);
  }

  goBack() {
    return navigatorKey.currentState!.pop();
  }

}