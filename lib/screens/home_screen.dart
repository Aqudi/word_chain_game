import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordchaingame/constants.dart';
import 'package:wordchaingame/providers/firebase_auth_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuthProvider _auth;

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<FirebaseAuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("대기방"),
          centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text("로그아웃", style: TextStyle(color: Colors.black),),
            onPressed: () => _auth.signOut(),
          ),
          Text("Hello"),
        ],
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          child:Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.blueGrey,
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              onPressed: () => Navigator.pushNamed(context, gameRoute),
              child: Text("게임하러가기",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
