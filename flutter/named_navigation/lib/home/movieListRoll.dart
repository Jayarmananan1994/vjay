import 'package:flutter/material.dart';
import 'package:named_navigation/appcostat.dart';
import 'package:named_navigation/model/MovieList.dart';
import 'package:named_navigation/tmdbconfig.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieListRoll extends StatelessWidget {
  final MovieList movieRollList;
  final String rollTitle;

  MovieListRoll({@required this.movieRollList, @required this.rollTitle});

  Material movieCard(Movie movie, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          print('card tapped ${movie.toJson()}');
          Navigator.pushNamed(context, MOVIE_DETAIL, arguments: movie);
        },
        child: Container(
          width: 150.0,
          child: Card(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Stack(
              children: <Widget>[
                //Image.network(imageUrl),
                faddingImage(movie.posterPath),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget faddingImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: url,
        //height: 300.0,
        fit: BoxFit.fill,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Movie> items = extractMovieList(movieRollList);
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
        child: Column(
          children: <Widget>[
            Align(
              child: Text(
                rollTitle,
                style: Theme.of(context).textTheme.headline,
              ),
              alignment: Alignment.topLeft,
            ),
            Container(
              height: 220.0,
              child: ListView.builder(
                itemCount: items.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, position) {
                  final item = items[position];
                  return movieCard(item, context);
                },
              ),
            )
          ],
        ));
  }

  List<Movie> extractMovieList(MovieList movieList) {
    int loopLen = movieList.movies.length;
    List<Movie> trendingMoviesList = new List();
    for (int i = 0; i < loopLen; i++) {
      Movie movie = movieList.movies[i];
      movie.posterPath = movie.posterPath.contains('w500')
          ? movie.posterPath
          : TmdbConfig.baseUrl + 'w500' + movieList.movies[i].posterPath;
      movie.backdropPath = movie.backdropPath.contains('w780')
          ? movie.backdropPath
          : TmdbConfig.baseUrl + 'w780' + movieList.movies[i].backdropPath;
      trendingMoviesList.add(movieList.movies[i]);
    }
    return trendingMoviesList;
  }
}
