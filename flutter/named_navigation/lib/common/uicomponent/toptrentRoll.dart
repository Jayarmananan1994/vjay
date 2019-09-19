import 'package:flutter/material.dart';
import 'package:named_navigation/util/carouselWithIndicator.dart';
import 'package:named_navigation/model/mymdb_movie.dart';

class TopTrendRoll extends StatelessWidget {
  final List<MyMDBMovie> movieList;
  //final MovieList movieList;

  TopTrendRoll({@required this.movieList});
  @override
  Widget build(BuildContext context) {
    List<CarouselModel> trendingMoviesList = extractMovieList(movieList);
    return CarouselWithIndicator( trendingMoviesList: trendingMoviesList,);
  }

  List<CarouselModel> extractMovieList(List<MyMDBMovie> movieList) {
    int loopLen = movieList.length > 10 ? 10 : movieList.length;
    List<CarouselModel> trendingMoviesList = new List();
    for (int i = 0; i < loopLen; i++) {
      CarouselModel model = new CarouselModel();
      model.imagePath = movieList[i].backdropImageUrl;
      model.title =  movieList[i].title;
      trendingMoviesList.add(model);
    }
    return trendingMoviesList;
  }
}
