import 'package:flutter/material.dart';
import 'package:named_navigation/model/mymdb_movie.dart';
import 'package:named_navigation/screens/movie-detail/CastList.dart';
import 'package:named_navigation/screens/movie-detail/similarmovies.dart';


class MovieDetailTab extends StatefulWidget {
  final MyMDBMovie movie;
  MovieDetailTab({Key key,@required this.movie}): super(key: key);
  @override
  _MovieDetailTabState createState() => _MovieDetailTabState();
}

class _MovieDetailTabState extends State<MovieDetailTab> with AutomaticKeepAliveClientMixin<MovieDetailTab>{

   @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
     super.build(context);
    return  DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Column(
            children: [
              TabBar(
                  indicatorColor: Colors.white,
                  tabs: [Tab(text: 'Cast Information'), Tab(text: 'You might like this too')]),
              Container(
                  height: 300.0,
                  child: TabBarView(
                    children: [
                    CastList(movieId: widget.movie.id,type: widget.movie.myMDBType),
                     SimilarMovies(movieId: widget.movie.id,type: widget.movie.myMDBType),
                    ],
                  ))
            ],
          ));
  }
}
