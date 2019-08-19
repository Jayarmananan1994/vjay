import 'package:flutter/material.dart';
import 'package:named_navigation/home/carouselWithIndicator.dart';

import 'package:named_navigation/model/MovieList.dart';
import 'package:named_navigation/tmdbconfig.dart';

class TopTrendRoll extends StatelessWidget {
  final MovieList movieList;

  TopTrendRoll({@required this.movieList});
  @override
  Widget build(BuildContext context) {
    List<CarouselModel> trendingMoviesList = extractMovieList(movieList);
    return CarouselWithIndicator( trendingMoviesList: trendingMoviesList,);
  }

  List<CarouselModel> extractMovieList(MovieList movieList) {
    int loopLen = movieList.movies.length > 10 ? 10 : movieList.movies.length;
    List<CarouselModel> trendingMoviesList = new List();
    for (int i = 0; i < loopLen; i++) {
      CarouselModel model = new CarouselModel();
      model.imagePath = TmdbConfig.baseUrl + 'w780' + movieList.movies[i].backdropPath;
      model.title = (movieList.movies[i].title == null) ? movieList.movies[i].originalTitle : movieList.movies[i].title;
      trendingMoviesList.add(model);
    }
    return trendingMoviesList;
  }
}
