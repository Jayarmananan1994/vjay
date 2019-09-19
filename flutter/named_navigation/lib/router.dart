import 'package:flutter/material.dart';
import 'package:named_navigation/screens/home/home.dart';
import 'package:named_navigation/screens/movie-detail/movieDetail.dart';
import 'package:named_navigation/screens/peopleinfo/peopleinfo.dart';
import 'package:named_navigation/screens/search/searchpage.dart';
import 'package:named_navigation/watchlist/watchlist.dart';

import 'appcostat.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePage.PATH:
      return MaterialPageRoute(builder: (context) => HomePage());
    case WATCH_LIST:
      //return SlideNavRoute(builder: (context) => MovieList());
      return MaterialPageRoute(builder: (context) => WatchList());
    //case DOWLOAD_LIST:
    //  return MaterialPageRoute(builder: (context) => Downloads());
    // case SETTING:
    //   return MaterialPageRoute(builder: (context) => Settings());
    case SearchPage.PATH:
       return MaterialPageRoute(builder: (context) => SearchPage());
    case MovieDetail.PATH:
      var movie = settings.arguments;
      return MaterialPageRoute(builder: (context) => MovieDetail(movie: movie));
   case PeopleInfo.PATH:
       var cast = settings.arguments;
       return MaterialPageRoute(
          builder: (context) => PeopleInfo(
               cast: cast,
              ));
    default:
      return MaterialPageRoute(builder: (context) => HomePage());
  }
}
