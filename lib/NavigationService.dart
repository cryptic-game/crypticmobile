import 'package:flutter/cupertino.dart';

class NavigationService {


  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  static Future<dynamic> pushNamed(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  static Future<dynamic> pushNamedReplacement(String routeName) {
    return navigatorKey.currentState.pushReplacementNamed(routeName);
  }
}
