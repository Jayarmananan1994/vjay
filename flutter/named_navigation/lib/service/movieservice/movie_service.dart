import 'package:named_navigation/model/mymdb_movie.dart';
import 'package:named_navigation/model/peopledetails.dart';
import 'package:named_navigation/screens/peopleinfo/peopleinfo.dart';

abstract class MovieService{

  Future<List<MyMDBMovie>> getNewRelease();

  Future<List<MyMDBMovie>> getTrendingRelease();

  Future<List<MyMDBMovie>> getClassicHits();

  Future<List<MyMDBMovie>> getNewTvSeries();

  Future<List<MyMDBMovie>> getTrendingTvSeries();

  Future<List<MyMDBMovie>> getOldPopularTvSeries();

  Future<MyMdbMovieDetail> getMovieDetail(int movieId);

  Future<MyMdbMovieDetail> getTvDetail(int movieId);

  Future<List<MyMDBCast>> getMovieCast(int movieId);

  Future<List<MyMDBCast>> getTvCast(int movieId);

  Future<List<MyMDBMovie>> getSimilarMovies(int movieId);
  
  Future<List<MyMDBMovie>> getSimilarTvseries(int tvId);

  Future<PeopleDetails> getPeopleDetail(int peopleId);
}