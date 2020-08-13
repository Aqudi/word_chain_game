import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordchaingame/constants.dart';
import 'package:wordchaingame/providers/firebase_auth_provider.dart';
import 'package:wordchaingame/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseAuthProvider>(
          create: (context) => FirebaseAuthProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Word chain game',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: Colors.white,
            textTheme: TextTheme(
              headline6: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        onGenerateRoute: Router.generateRoute,
        initialRoute: rootRoute,
      ),
    );
  }
}
