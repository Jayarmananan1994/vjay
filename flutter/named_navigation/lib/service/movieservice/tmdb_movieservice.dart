import 'package:named_navigation/model/MovieCast.dart';
import 'package:named_navigation/model/MovieInfo.dart';
import 'package:named_navigation/model/MovieList.dart';
import 'package:named_navigation/model/mymdb_movie.dart';
import 'package:named_navigation/model/peopledetails.dart';
import 'package:named_navigation/screens/peopleinfo/peopleinfo.dart';
import 'package:named_navigation/service/movieservice/movie_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TmdbMovieService implements MovieService {
  static const String TMDB_BASE_URL = 'https://api.themoviedb.org/3/';
  static const String TMDB_APIKEY = 'd25da87eb508f82f654cdee03507cdf3';
  static bool TMDB_SERVICE_DOWN = false;

  TmdbMovieService() {
    var configurl = TMDB_BASE_URL + 'configuration?api_key=' + TMDB_APIKEY;
    http.get(configurl).then((response) {
      loadTMDBCofig(response);
    });
  }
  @override
  Future<List<MyMDBMovie>> getClassicHits() async {
    //&primary_release_date.gte=2010&primary_release_date.lte=2010
    var classicMovieUrl = TMDB_BASE_URL +
        'discover/movie?api_key=' +
        TMDB_APIKEY +
        '&language=en-US&sort_by=vote_average.desc&include_adult=true&primary_release_date.lte=2010&vote_count.gte=1000&vote_average.gte=8';

    MovieList nowReleased = await fetchMovieFromTMDB(classicMovieUrl);
    List<MyMDBMovie> newReleaseList =
        covertMovieListToMyMdb(nowReleased.movies);

    return newReleaseList;
  }

  @override
  Future<List<MyMDBMovie>> getNewRelease() async {
    var nowReleasedUrl =
        '${TMDB_BASE_URL}movie/now_playing?api_key=$TMDB_APIKEY&language=en-US&page=1';
    MovieList nowReleased = await fetchMovieFromTMDB(nowReleasedUrl);
    List<MyMDBMovie> newReleaseList =
        covertMovieListToMyMdb(nowReleased.movies);
    return newReleaseList;
  }

  @override
  Future<List<MyMDBMovie>> getTrendingRelease() async {
    var url = TMDB_BASE_URL + 'trending/Movie/day?api_key=' + TMDB_APIKEY;
    MovieList movieList =
        await fetchMovieFromTMDB(url); //MovieList.fromJson(decodedJson);
    return covertMovieListToMyMdb(movieList.movies);
  }

  @override
  Future<MyMdbMovieDetail> getMovieDetail(int movieId) async {
    var url = TMDB_BASE_URL + 'movie/$movieId?api_key=' + TMDB_APIKEY;
    var resdata = await http.get(url);
    var decodedJson = jsonDecode(resdata.body);
    MovieInfo movieInfo = MovieInfo.fromJson(decodedJson);
    return convertToMyMDBMovieDetail(movieInfo);
  }

  loadTMDBCofig(http.Response response) {
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var imageConfig = jsonResponse['images'];
      TmdbConfig.baseUrl = imageConfig['base_url'];
      TmdbConfig.secureBaseUrl = imageConfig['secure_base_url'];
      TmdbConfig.backdropSizes = imageConfig['backdrop_sizes'];
      TmdbConfig.logoSizes = imageConfig['logo_sizes'];
      TmdbConfig.posterSizes = imageConfig['poster_sizes'];
      TmdbConfig.profileSizes = imageConfig['profile_sizes'];
      TmdbConfig.stillSizes = imageConfig['still_sizes'];
    } else {}
  }

  Future<MovieList> fetchMovieFromTMDB(String url) async {
    var resdata = await http.get(url);
    var decodedJson = jsonDecode(resdata.body);
    MovieList movieList = MovieList.fromJson(decodedJson);
    return movieList;
  }

  MyMdbMovieDetail convertToMyMDBMovieDetail(MovieInfo movieInfo) {
    MyMdbMovieDetail movieDetail = MyMdbMovieDetail();
    movieDetail.id = movieInfo.id;
    movieDetail.imdbId = movieInfo.imdbId;
    movieDetail.genres =
        movieInfo.genres.map((g) => Genre(id: g.id, name: g.name)).toList();
    movieDetail.overview = movieInfo.overview;
    movieDetail.tagline = movieInfo.tagline;
    movieDetail.posterImageUrl = movieInfo.posterPath;
    movieDetail.title = movieInfo.title;
    return movieDetail;
  }

  List<MyMDBMovie> covertMovieListToMyMdb(List<Movie> items) {
    List<MyMDBMovie> movieList = [];
    items.forEach((item) {
      MyMDBMovie movie = covertMovieToMyMdb(item);
      movieList.add(movie);
    });
    return movieList;
  }

  MyMDBMovie covertMovieToMyMdb(Movie item) {
    MyMDBMovie movie = new MyMDBMovie(
        id: item.id,
        title: item.title,
        adult: item.adult,
        releaseDate: item.releaseDate,
        overview: item.overview);

    movie.backdropImageUrl = (item.backdropPath != null)
        ? (TmdbConfig.baseUrl + 'w780' + item.backdropPath)
        : '';
    movie.posterImageUrl = (item.posterPath != null)
        ? (TmdbConfig.baseUrl + 'w780' + item.posterPath)
        : '';
    movie.myMDBType = MyMDBType.MOVIE;
    return movie;
  }

  @override
  Future<List<MyMDBMovie>> getNewTvSeries() async {
    var nowReleasedUrl =
        TMDB_BASE_URL + 'trending/tv/day?api_key=' + TMDB_APIKEY;
    MovieList nowReleased = await fetchMovieFromTMDB(nowReleasedUrl);
    List<MyMDBMovie> newReleaseList =
        covertMovieListToMyMdb(nowReleased.movies);
    newReleaseList.forEach((item) {
      item.myMDBType = MyMDBType.TVSERIES;
    });
    return newReleaseList;
  }

  @override
  Future<List<MyMDBMovie>> getOldPopularTvSeries() async {
    var url = TMDB_BASE_URL +
        'discover/tv?api_key=' +
        TMDB_APIKEY +
        '&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&vote_average.gte=8&vote_count.gte=999&include_null_first_air_dates=false';
    MovieList movieList =
        await fetchMovieFromTMDB(url); //MovieList.fromJson(decodedJson);
    var result = covertMovieListToMyMdb(movieList.movies);
    result.forEach((item) {
      item.myMDBType = MyMDBType.TVSERIES;
    });
    return result;
  }

  @override
  Future<List<MyMDBMovie>> getTrendingTvSeries() async {
    var url = TMDB_BASE_URL + 'trending/tv/day?api_key=' + TMDB_APIKEY;
    MovieList movieList = await fetchMovieFromTMDB(url);
    var result = covertMovieListToMyMdb(movieList.movies);
    result.forEach((item) {
      item.myMDBType = MyMDBType.TVSERIES;
    });
    return result;
  }

  @override
  Future<List<MyMDBCast>> getMovieCast(int movieId) async {
    var casturl =
        TMDB_BASE_URL + 'movie/$movieId/credits?api_key=' + TMDB_APIKEY;
    var castresdata = await http.get(casturl);
    var castdecodedJson = jsonDecode(castresdata.body);
    MovieCast castInfo = MovieCast.fromJson(castdecodedJson);
    List<MyMDBCast> moviecast = [];
    castInfo.cast.forEach((castitem) {
      if (castitem.profilePath != null && castitem.profilePath.trim() != '') {
        moviecast.add(covertToMyMDBCast(castitem));
      }
    });
    return moviecast;
  }

  MyMDBCast covertToMyMDBCast(Cast cast) {
    MyMDBCast castinfo = MyMDBCast();
    castinfo.character = cast.character;
    castinfo.creditId = cast.creditId;
    castinfo.name = cast.name;
    castinfo.id = cast.id;
    castinfo.profilePath =
        TmdbConfig.baseUrl + TmdbConfig.profileSizes[0] + cast.profilePath;
    var len=TmdbConfig.profileSizes.length;
    castinfo.profilePathLarge =
        TmdbConfig.baseUrl + TmdbConfig.profileSizes[len-2] + cast.profilePath;    
    return castinfo;
  }

  @override
  Future<List<MyMDBMovie>> getSimilarMovies(int movieId) async {
    var url = TMDB_BASE_URL + 'movie/$movieId/similar?api_key=' + TMDB_APIKEY;
    print('movie url ; $url');
    MovieList movieList = await fetchMovieFromTMDB(url);
    var result = covertMovieListToMyMdb(movieList.movies);
    return result;
  }

  @override
  Future<List<MyMDBMovie>> getSimilarTvseries(int tvId) async {
    var url = TMDB_BASE_URL + 'tv/$tvId/similar?api_key=' + TMDB_APIKEY;
    print('series url ; $url');
    MovieList movieList = await fetchMovieFromTMDB(url);
    var result = covertMovieListToMyMdb(movieList.movies);
    return result;
  }

  @override
  Future<MyMdbMovieDetail> getTvDetail(int movieId) async{
    var url = TMDB_BASE_URL + 'tv/$movieId?api_key=' + TMDB_APIKEY;
    var resdata = await http.get(url);
    var decodedJson = jsonDecode(resdata.body);
    MovieInfo movieInfo = MovieInfo.fromJson(decodedJson);
    return convertToMyMDBMovieDetail(movieInfo);
  }

  @override
  Future<List<MyMDBCast>> getTvCast(int movieId) async{
   var casturl =
        TMDB_BASE_URL + 'tv/$movieId/credits?api_key=' + TMDB_APIKEY;
    var castresdata = await http.get(casturl);
    var castdecodedJson = jsonDecode(castresdata.body);
    MovieCast castInfo = MovieCast.fromJson(castdecodedJson);
    List<MyMDBCast> moviecast = [];
    castInfo.cast.forEach((castitem) {
      if (castitem.profilePath != null && castitem.profilePath.trim() != '') {
        moviecast.add(covertToMyMDBCast(castitem));
      }
    });
    return moviecast;
  }

  @override
  Future<PeopleDetails> getPeopleDetail(int peopleId) async {
      var casturl =
        TMDB_BASE_URL + 'person/$peopleId?api_key=' + TMDB_APIKEY;
    var castresdata = await http.get(casturl);
    var castdecodedJson = jsonDecode(castresdata.body);
    PeopleDetails peopleDetails=PeopleDetails.fromJson(castdecodedJson);
    return peopleDetails;
  }
}

class TmdbConfig {
  static String baseUrl;
  static String secureBaseUrl;
  static List backdropSizes;
  static List logoSizes;
  static List posterSizes;
  static List profileSizes;
  static List stillSizes;
}
