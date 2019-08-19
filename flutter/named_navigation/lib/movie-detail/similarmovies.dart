import 'package:flutter/material.dart';
import 'package:named_navigation/appcostat.dart';
import 'package:named_navigation/model/MovieList.dart';
import 'package:named_navigation/tmdbconfig.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SimilarMovies extends StatefulWidget {
  final int movieId;
  SimilarMovies({@required this.movieId});
  @override
  _SimilarMoviesState createState() => _SimilarMoviesState();
}

class _SimilarMoviesState extends State<SimilarMovies> with AutomaticKeepAliveClientMixin<SimilarMovies>{

  Future<List<Movie>> _loadingDeals;

@override
bool get wantKeepAlive => true;

@override
void initState() {
  _loadingDeals = getSimilarMovies(); // only create the future once.
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: _loadingDeals,
      builder: (BuildContext context, AsyncSnapshot snapShot) {
        List<Movie> similarMovies = snapShot.data;
        print('similarMovies i got $similarMovies');
        if (similarMovies == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return GridView.count(
            crossAxisCount: 2,
            children: similarMovies
                .map((Movie item) => movieCard(item, context))
                .toList(),
          );
        }
      },
    );
  }

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

  Future<List<Movie>> getSimilarMovies() async {
    var url = TMDB_BASE_URL +
        'movie/${widget.movieId}/similar?api_key=' +
        TMDB_APIKEY;
    var resdata = await http.get(url);
    var decodedJson = jsonDecode(resdata.body);
    MovieList movieInfo = MovieList.fromJson(decodedJson);
    List<Movie> movieList = [];
    movieInfo.movies.forEach((value) {
      if (value.id != widget.movieId) {
        value.posterPath = value.posterPath.contains('w500')
            ? value.posterPath
            : TmdbConfig.baseUrl + 'w500' + value.posterPath;
        value.backdropPath = value.backdropPath.contains('w780')
            ? value.backdropPath
            : TmdbConfig.baseUrl + 'w780' + value.backdropPath;
        movieList.add(value);
      }
    });
    return movieList;
  }
}
