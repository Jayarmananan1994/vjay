import 'dart:async';

import 'package:flutter/material.dart';
import 'package:named_navigation/common/uicomponent/footer.dart';
import 'package:named_navigation/common/uicomponent/header.dart';
import 'package:named_navigation/screens/movies/movieHome.dart';

import 'package:named_navigation/model/MovieList.dart';
import 'package:named_navigation/screens/tvseries/tvseriesHome.dart';

class HomePage extends StatefulWidget {
  static const String PATH = '/';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  Future<MovieList> movieList;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // need to call super method.
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: MyAppHeader.getTabHeader('MyMDB'),
        backgroundColor: Theme.of(context).primaryColor,
        body: TabBarView(
          children: <Widget>[
            MovieHome(),
            TvSeriesHome(),
            Text('pAGE3'),
            Text('pAGE4'),
          ],
        ),
        bottomNavigationBar: FooterNavBar(),
      ),
    );
  }
}
