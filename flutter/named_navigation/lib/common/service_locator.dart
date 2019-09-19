import 'package:get_it/get_it.dart';
import 'package:named_navigation/service/movieservice/movie_service.dart';
import 'package:named_navigation/service/movieservice/tmdb_movieservice.dart';
GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerSingleton<MovieService>(TmdbMovieService());
}
