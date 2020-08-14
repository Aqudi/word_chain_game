import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordchaingame/providers/firebase_auth_provider.dart';
import 'package:wordchaingame/screens/auth_screen.dart';
import 'package:wordchaingame/screens/home_screen.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  FirebaseAuthProvider _auth;

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<FirebaseAuthProvider>(context);
    print(_auth.loggedIn);
    if (_auth.loggedIn) {
      return HomeScreen();
    }
    return AuthScreen();
  }
}
