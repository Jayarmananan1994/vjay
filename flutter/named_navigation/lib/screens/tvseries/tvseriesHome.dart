import 'package:flutter/material.dart';
import 'package:named_navigation/common/service_locator.dart';
import 'package:named_navigation/common/uicomponent/movieListRoll.dart';
import 'package:named_navigation/common/uicomponent/toptrentRoll.dart';
import 'package:named_navigation/model/mymdb_movie.dart';
import 'package:named_navigation/service/movieservice/movie_service.dart';

class TvSeriesHome extends StatefulWidget {
  @override
  _TvSeriesHomeState createState() => _TvSeriesHomeState();
}

class _TvSeriesHomeState extends State<TvSeriesHome>
    with AutomaticKeepAliveClientMixin<TvSeriesHome> {
  @override
  bool get wantKeepAlive => true;

  MovieService movieService = locator<MovieService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(children: <Widget>[
      newReleaseCarousol(),
      trendingMoviesScroll(),
      classicMoviesScroll()
    ]);
  }

  get newReleaseCarousol => () {
        return FutureBuilder(
          future: movieService.getTrendingTvSeries(),
          builder: (BuildContext context, AsyncSnapshot snapShot) {
            List<MyMDBMovie> result = snapShot.data;
            List<MyMDBMovie> nowReleased =
                result ?? [MyMDBMovie.getEmptyMovie()];
            return TopTrendRoll(movieList: nowReleased);
          },
        );
      };

  get trendingMoviesScroll => () {
        return FutureBuilder(
          future: movieService.getNewTvSeries(),
          builder: (BuildContext context, AsyncSnapshot snapShot) {
            List<MyMDBMovie> result = snapShot.data;
            return MovieListRoll(
              movieRollList: result,
              rollTitle: 'New Arrival',
              isEmptySlot: (result == null),
            );
          },
        );
      };

  get classicMoviesScroll => () {
        return FutureBuilder(
          future: movieService.getOldPopularTvSeries(),
          builder: (BuildContext context, AsyncSnapshot snapShot) {
            List<MyMDBMovie> result = snapShot.data;
            return MovieListRoll(
              movieRollList: result,
              rollTitle: 'Series worth binge watching',
              isEmptySlot: (result == null),
            );
          },
        );
      };
}
