import 'package:flutter/material.dart';
import 'package:named_navigation/tmdbconfig.dart';
import 'router.dart' as router;
import 'appcostat.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      onGenerateRoute: router.generateRoute,
      initialRoute: HOME,
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
                  color: Colors.white, fontSize: 17.0, fontFamily: 'Roboto', fontWeight: FontWeight.w600))),
    );
  }
}
