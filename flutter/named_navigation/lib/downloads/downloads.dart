import 'package:flutter/material.dart';
import 'package:named_navigation/common/footer.dart';
import 'package:named_navigation/common/header.dart';

class Downloads extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppHeader.getHeader('Downloads'),
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Card(
            child: Text('here comes the watch list'),
          ),
        ),
        bottomNavigationBar: FooterNavBar(),
      );
  }
}