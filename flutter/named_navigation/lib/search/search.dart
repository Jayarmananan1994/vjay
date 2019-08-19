import 'package:flutter/material.dart';
import 'package:named_navigation/appcostat.dart';
import 'package:named_navigation/common/footer.dart';
import 'package:named_navigation/common/header.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppHeader.getHeader('Search'),
        backgroundColor: Color(APP_BODY_COLOR),
        body: Center(
          child: Card(
            child: Text('here comes the search content'),
          ),
        ),
        bottomNavigationBar: FooterNavBar(),
      );
  }
}