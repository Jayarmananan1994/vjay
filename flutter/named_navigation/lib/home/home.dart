import 'dart:async';

import 'package:flutter/material.dart';
import 'package:named_navigation/appcostat.dart';
import 'package:named_navigation/common/footer.dart';
import 'package:named_navigation/common/header.dart';
import 'package:named_navigation/home/movieHome.dart';
import 'package:http/http.dart' as http;
import 'package:named_navigation/home/tvseriesHome.dart';
import 'package:named_navigation/model/MovieList.dart';
import 'dart:convert';

import 'package:named_navigation/tmdbconfig.dart';

class HomePage extends StatefulWidget {
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
    var configurl = TMDB_BASE_URL + 'configuration?api_key=' + TMDB_APIKEY;
    http.get(configurl).then((response) {
      loadTMDBCofig(response);
    });

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
            TVSeriesHome(),
            Text('pAGE3'),
            Text('pAGE4'),
          ],
        ),
        bottomNavigationBar: FooterNavBar(),
      ),
    );
  }

  loadTMDBCofig(http.Response response) {
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var imageConfig = jsonResponse['images'];
      print("Config info loaded: $imageConfig.");
      TmdbConfig.setTmdbConfig(
          imageConfig['base_url'],
          imageConfig['secure_base_url'],
          imageConfig['backdrop_sizes'],
          imageConfig['logo_sizes'],
          imageConfig['poster_sizes'],
          imageConfig['profile_sizes'],
          imageConfig['still_sizes']);
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
  }

}
