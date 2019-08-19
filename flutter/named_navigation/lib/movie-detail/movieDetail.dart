import 'package:flutter/material.dart';
import 'package:named_navigation/appcostat.dart';
import 'package:named_navigation/common/footer.dart';
import 'package:named_navigation/common/header.dart';
import 'package:named_navigation/model/MovieCast.dart';
import 'package:named_navigation/model/MovieInfo.dart';
import 'package:named_navigation/model/MovieList.dart';
import 'package:named_navigation/movie-detail/movieDetailTab.dart';
import 'package:named_navigation/movie-detail/similarmovies.dart';
import 'package:named_navigation/tmdbconfig.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:named_navigation/home/profileImage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieDetail extends StatefulWidget {
  final Movie movie;
  MovieDetail({Key key, @required this.movie}) : super(key: key);
  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    //final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: MyAppHeader.getHeader('MyMDB'),
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder(
        future: getMovieDetail(),
        builder: (BuildContext context, AsyncSnapshot snapShot) {
          Map result = snapShot.data;
          print('moviedetail i got $result');
          return constructMovieDetail(result);
        },
      ),
      bottomNavigationBar: FooterNavBar(),
    );
  }

  Future<Map> getMovieDetail() async {
    var url = TMDB_BASE_URL + 'movie/${widget.movie.id}?api_key=' + TMDB_APIKEY;
    var resdata = await http.get(url);
    var decodedJson = jsonDecode(resdata.body);
    MovieInfo movieInfo = MovieInfo.fromJson(decodedJson);

    /*var casturl = TMDB_BASE_URL +
        'movie/${widget.movie.id}/credits?api_key=' +
        TMDB_APIKEY;
    
    var castresdata = await http.get(casturl);
    var castdecodedJson = jsonDecode(castresdata.body);
    MovieCast castInfo = MovieCast.fromJson(castdecodedJson);
    List<Cast> castList = new List();
    castInfo.cast.forEach((item) {
      if (item.profilePath != null) {
        item.profilePath = (item.profilePath.contains('w185'))
            ? item.profilePath
            : TmdbConfig.baseUrl + 'w185' + item.profilePath;
        castList.add(item);
      }
    });*/

    Map finalMap = new Map();
    finalMap['movieInfo'] = movieInfo;
    //finalMap['castList'] = castList;
    return finalMap;
  }

  SizedBox moviePoster() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 230.0,
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: widget.movie.backdropPath,
          fit: BoxFit.fill,
        ));
  }

  Text movieTitle() {
    return Text(
      '${widget.movie.title} (${widget.movie.releaseDate.substring(0, 4)}) ',
      style: TextStyle(
          color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
    );
  }

  List<Widget> movieInfoWidget(MovieInfo movieInfo) {
    List<Widget> widgetList = [];
    var defaultGap = SizedBox(height: 20);
    widgetList.add(movieTitle());
    if (movieInfo != null && movieInfo.tagline != null) {
      widgetList.add(SizedBox(height: 10));
      widgetList.add(Text(movieInfo.tagline,
          style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.normal)));
      widgetList.add(defaultGap);
    } else {
      widgetList.add(defaultGap);
    }
    if (movieInfo != null && movieInfo.overview != null) {
      widgetList.add(RichText(
        textAlign: TextAlign.left,
        softWrap: true,
        text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: movieInfo.overview, style: TextStyle(color: Colors.white)),
        ]),
      ));
      widgetList.add(SizedBox(height: 40));
      widgetList.add(MovieDetailTab(movieInfo: movieInfo,));
    } else {
      widgetList.add(Center(
        child: CircularProgressIndicator(),
      ));
    }
    return widgetList;
  }

  ListView constructMovieDetail(Map result) {
    MovieInfo movieInfo = (result != null) ? result['movieInfo'] : null;
    //List<Cast> castList = (result != null) ? result['castList'] : null;
    var movieDetailContaier = Container(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: movieInfoWidget(movieInfo)),
    );
    return ListView(
      children: <Widget>[moviePoster(), movieDetailContaier],
    );
  }
}
