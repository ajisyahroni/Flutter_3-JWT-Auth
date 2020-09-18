import 'package:flutter/material.dart';
/**
 * -----------------------
 * screens
 * -----------------------
 */
import 'package:TweetMe/screens/Dashboard/Dashboard.dart';
import 'package:TweetMe/screens/Profile/ProfileScreen.dart';
import 'package:TweetMe/screens/Login.dart';

/**
 * -----------------------
 * END screens
 * -----------------------
 */

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TweetMe App',
      initialRoute: '/Login',
      routes: <String, WidgetBuilder>{
        '/Login': (BuildContext ctx) => Login(),
        'Dashboard': (BuildContext ctx) => Dashboard(),
        'Profile': (BuildContext cxt) => ProfileScreen(),
      },
    );
  }
}
