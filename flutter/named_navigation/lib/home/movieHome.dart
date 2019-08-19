import 'package:flutter/material.dart';
import 'package:named_navigation/appcostat.dart';
import 'package:named_navigation/home/movieListRoll.dart';
import 'package:named_navigation/home/toptrentRoll.dart';
import 'package:named_navigation/model/MovieList.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieHome extends StatefulWidget {
  @override
  _MovieHomeState createState() => _MovieHomeState();
}

class _MovieHomeState extends State<MovieHome>
    with AutomaticKeepAliveClientMixin<MovieHome> {
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
          MovieList nowReleased = result['nowReleased'];
          MovieList movieList = result['trendingMovie'];
          MovieList classicsList = result['classics'];
          return ListView(children: <Widget>[
            TopTrendRoll(
              movieList: nowReleased,
            ),
            MovieListRoll(
              movieRollList: movieList,
              rollTitle: 'New Arrival',
            ),
            MovieListRoll(
              movieRollList: classicsList,
              rollTitle: 'Classic hits for you',
            )
          ]);
        }
      },
    );
  }

  Future<Map> fetchMovieList() async {
    var nowReleasedUrl = '${TMDB_BASE_URL}movie/now_playing?api_key=$TMDB_APIKEY&language=en-US&page=1';
    var resData = await  http.get(nowReleasedUrl);
     var decodedJson3 = jsonDecode(resData.body);
    MovieList nowReleased = MovieList.fromJson(decodedJson3);

    var url = TMDB_BASE_URL + 'trending/Movie/day?api_key=' + TMDB_APIKEY;
    var resdata = await http.get(url);
    var decodedJson = jsonDecode(resdata.body);
    MovieList movieList = MovieList.fromJson(decodedJson);
    var classicMovieUrl = TMDB_BASE_URL +
        'discover/movie?api_key=' +
        TMDB_APIKEY +
        '&language=en-US&sort_by=vote_average.desc&include_adult=true&primary_release_date.gte=1995&primary_release_date.lte=2010&vote_count.gte=1000&vote_average.gte=8';

    var resClassicData = await http.get(classicMovieUrl).catchError((error) {
      print('error in classics;' + error);
    });
    var decodedJson2 = jsonDecode(resClassicData.body);
    MovieList classics = MovieList.fromJson(decodedJson2);
    Map finalMap = new Map();
    finalMap['nowReleased'] = nowReleased;
    finalMap['trendingMovie'] = movieList;
    finalMap['classics'] = classics;
    return finalMap;
  }
}
