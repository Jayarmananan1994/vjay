import 'package:flutter/material.dart';
import 'package:named_navigation/common/service_locator.dart';
import 'package:named_navigation/screens/home/home.dart';

import 'appcostat.dart';
import 'router.dart' as router;

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      onGenerateRoute: router.generateRoute,
      initialRoute: HomePage.PATH,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(APP_BODY_COLOR),
          textTheme: TextTheme(
              headline: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto'),
              display1: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600),
              subhead: TextStyle(color: Colors.white, fontSize: 13.0,),
              body1: TextStyle(color: Colors.white, fontFamily: 'Roboto',fontSize: 15.0))),
    );
  }
}
