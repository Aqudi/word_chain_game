import 'package:flutter/material.dart';

import 'package:wordchaingame/constants.dart';
import 'package:wordchaingame/screens/screens.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case rootRoute:
        return MaterialPageRoute(builder: (_) => RootScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case authRoute:
        return MaterialPageRoute(builder: (_) => AuthScreen());
      default:
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
