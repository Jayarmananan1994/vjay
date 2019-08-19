import 'package:flutter/material.dart';
import 'package:named_navigation/appcostat.dart';
import 'package:named_navigation/home/movieListRoll.dart';
import 'package:named_navigation/home/toptrentRoll.dart';
import 'package:named_navigation/model/MovieList.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TVSeriesHome extends StatefulWidget {
  @override
  _TVSeriesHomeState createState() => _TVSeriesHomeState();
}

class _TVSeriesHomeState extends State<TVSeriesHome>
    with AutomaticKeepAliveClientMixin<TVSeriesHome> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchMovieList(),
      builder: (BuildContext context, AsyncSnapshot snapShot) {
        Map result = snapShot.data;
        if (result == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          MovieList movieList = result['trendingMovie'];
          MovieList classicsList = result['classics'];
          return ListView(children: <Widget>[
            TopTrendRoll(
              movieList: movieList,
            ),
            MovieListRoll(
              movieRollList: movieList,
              rollTitle: 'New Arrival',
            ),
            MovieListRoll(
              movieRollList: classicsList,
              rollTitle: 'Series worth binge watching',
            )
          ]);
        }
      },
    );
  }

  Future<Map> fetchMovieList() async {
    var url = TMDB_BASE_URL + 'trending/tv/day?api_key=' + TMDB_APIKEY;
    var resdata = await http.get(url);
    var decodedJson = jsonDecode(resdata.body);
    MovieList movieList = MovieList.fromJson(decodedJson);
    var classicMovieUrl = TMDB_BASE_URL +
        'discover/tv?api_key=' +
        TMDB_APIKEY +
        '&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&vote_average.gte=8&vote_count.gte=999&include_null_first_air_dates=false';
    var resClassicData = await http.get(classicMovieUrl).catchError((error) {
      print('error in classics;' + error);
    });
    var decodedJson2 = jsonDecode(resClassicData.body);
    MovieList classics = MovieList.fromJson(decodedJson2);
    Map finalMap = new Map();
    finalMap['trendingMovie'] = movieList;
    finalMap['classics'] = classics;
    return finalMap;
  }
}
