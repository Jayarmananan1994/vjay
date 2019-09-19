import 'package:flutter/material.dart';
import 'package:named_navigation/common/service_locator.dart';
import 'package:named_navigation/model/mymdb_movie.dart';
import 'package:named_navigation/screens/movie-detail/movieDetail.dart';
import 'package:named_navigation/service/movieservice/movie_service.dart';
import 'package:transparent_image/transparent_image.dart';

class SimilarMovies extends StatefulWidget {
  final int movieId;
  final MyMDBType type;
  SimilarMovies({@required this.movieId, @required this.type});
  @override
  _SimilarMoviesState createState() => _SimilarMoviesState();
}

class _SimilarMoviesState extends State<SimilarMovies>
    with AutomaticKeepAliveClientMixin<SimilarMovies> {
  Future<List<MyMDBMovie>> _loadingDeals;

  @override
  bool get wantKeepAlive => true;

  MovieService service = locator<MovieService>();

  @override
  void initState() {
    // _loadingDeals =  // only create the future once.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: (widget.type == MyMDBType.MOVIE)
          ? service.getSimilarMovies(widget.movieId)
          : service.getSimilarTvseries(widget.movieId),
      builder: (BuildContext context, AsyncSnapshot snapShot) {
        List<MyMDBMovie> similarMovies = snapShot.data;
        print('recieved movies $similarMovies');
        if (similarMovies == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return GridView.builder(
            itemCount: similarMovies.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 3),
            itemBuilder: (BuildContext context, int index) {
              return movieCard(similarMovies[index], context);
            },
          );
        }
      },
    );
  }

  Widget movieCard(MyMDBMovie movie, BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        faddingImage(movie.posterImageUrl),
        ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, MovieDetail.PATH,
                      arguments: movie);
                },
                child: Container(width: 130),
              ),
            ))
      ],
    );
  }

  Widget faddingImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: url,
        width: 130,
        fit: BoxFit.fill,
      ),
    );
  }
}
