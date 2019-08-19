import 'package:flutter/material.dart';
import 'package:named_navigation/downloads/downloads.dart';
import 'package:named_navigation/home/home.dart';
import 'package:named_navigation/model/people.dart';
import 'package:named_navigation/movie-detail/movieDetail.dart';
import 'package:named_navigation/nav_util/SlideNavRoute.dart';
import 'package:named_navigation/peopleInfo/peopleInfo.dart';
import 'package:named_navigation/search/search.dart';
import 'package:named_navigation/settings/settings.dart';
import 'package:named_navigation/watchlist/watchlist.dart';
import 'appcostat.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HOME:
      return MaterialPageRoute(builder: (context) => HomePage());
    case WATCH_LIST:
      //return SlideNavRoute(builder: (context) => MovieList());
      return MaterialPageRoute(builder: (context) => WatchList());
    case DOWLOAD_LIST:
      return MaterialPageRoute(builder: (context) => Downloads());
    case SETTING:
      return MaterialPageRoute(builder: (context) => Settings());
    case SEARCH:
      return MaterialPageRoute(builder: (context) => SearchPage());
    case MOVIE_DETAIL:
      var movie = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => MovieDetail(
                movie: movie,
              ));
    case PEOPLE_DETAIL:
      var cast = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => PeopleInfo(
                cast: cast,
              ));
    default:
      return MaterialPageRoute(builder: (context) => HomePage());
  }
}
