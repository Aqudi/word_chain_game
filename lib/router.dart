import 'package:flutter/material.dart';

import 'package:wordchaingame/constants.dart';
import 'package:wordchaingame/screens/screens.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case rootRoute:
        return _buildPageRoute(RootScreen());
      case homeRoute:
        return _buildPageRoute(HomeScreen());
      case gameRoute:
        return _buildPageRoute(GameScreen());
      case signupRoute:
        return _buildPageRoute(SignUpScreen());
      case loginRoute:
        return _buildPageRoute(LoginScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

MaterialPageRoute _buildPageRoute(screen) {
  return MaterialPageRoute(
    builder: (context) => screen,
  );
}
