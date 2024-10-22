import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordchaingame/providers/firebase_auth_provider.dart';
import 'package:wordchaingame/screens/home_screen.dart';
import 'package:wordchaingame/screens/login_screen.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  FirebaseAuthProvider _auth;
  Widget _currentScreen;

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<FirebaseAuthProvider>(context);

    print("Auth loggedIn : ${_auth.status}");
    switch (_auth.status) {
      case AuthStatus.LOGGED_IN:
        print("logged in");
        _currentScreen = HomeScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        print("not logged in");
        _currentScreen = LoginScreen();
        break;
      default:
        print("logged in");
        _currentScreen = Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
    }

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: _currentScreen,
    );
  }
}
