import 'package:flutter/material.dart';
import 'package:named_navigation/appcostat.dart';
import 'package:named_navigation/common/uicomponent/footer.dart';
import 'package:named_navigation/common/uicomponent/header.dart';

class WatchList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppHeader.getHeader('Watch List'),
        backgroundColor: Color(APP_BODY_COLOR),
        body: Center(
          child: Card(
            child: Text('here comes the watch list'),
          ),
        ),
        bottomNavigationBar: FooterNavBar(),
      );
  }
}