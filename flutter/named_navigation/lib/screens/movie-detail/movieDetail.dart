import 'package:flutter/material.dart';
import 'package:named_navigation/common/service_locator.dart';
import 'package:named_navigation/common/uicomponent/chiptext.dart';
import 'package:named_navigation/common/uicomponent/footer.dart';
import 'package:named_navigation/common/uicomponent/header.dart';
import 'package:named_navigation/model/mymdb_movie.dart';
import 'package:named_navigation/screens/movie-detail/movieDetailTab.dart';
import 'package:named_navigation/service/movieservice/movie_service.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieDetail extends StatefulWidget {
  static const String PATH = '/moviedetail';
  final MyMDBMovie movie;
  MovieDetail({Key key, @required this.movie}) : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  MovieService movieService = locator<MovieService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppHeader.getHeader('MyMDB'),
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: <Widget>[moviePoster(), movieDetailContainer()],
      ),
      bottomNavigationBar: FooterNavBar(),
    );
  }

  Widget moviePoster() {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.transparent],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 230.0,
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: widget.movie.backdropImageUrl,
            fit: BoxFit.fill,
          )),
    );
  }

  get movieDetailContainer => () {
        var content = <Widget>[];
        content.add(Text(widget.movie.title,
            style: Theme.of(context).textTheme.display1));

        content.add(FutureBuilder(
          future: (widget.movie.myMDBType == MyMDBType.MOVIE)
              ? movieService.getMovieDetail(widget.movie.id)
              : movieService.getTvDetail(widget.movie.id),
          builder: (BuildContext context, AsyncSnapshot snapShot) {
            MyMdbMovieDetail movieDetail = snapShot.data;
            if (movieDetail == null) {
              return Container(
                  height: 100,
                  child: Center(child: CircularProgressIndicator()));
            } else {
              var movieDesc = <Widget>[];
              if (movieDetail.tagline != null &&
                  movieDetail.tagline.trim() != '') {
                movieDesc.add(Padding(
                    child: Text(movieDetail.tagline,
                        style: Theme.of(context).textTheme.subhead),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5)));
              }
              movieDesc.add(Padding(
                child: RichText(
                  textAlign: TextAlign.left,
                  softWrap: true,
                  text: TextSpan(
                      text: movieDetail.overview,
                      style: Theme.of(context).textTheme.body1),
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
              ));

              movieDesc.add(Wrap(
                  children: movieDetail.genres
                      .map((genre) => ChipText(
                            text: genre.name,
                          ))
                      .toList()));

              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: movieDesc);
            }
          },
        ));

        content.add(MovieDetailTab(
          movie: widget.movie,
        ));
        return Container(
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          child: Column(
            children: content,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        );
      };
}
