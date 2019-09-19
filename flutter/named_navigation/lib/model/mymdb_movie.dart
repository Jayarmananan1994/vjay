class MyMDBMovie {
  int id;
  String title;
  String posterImageUrl;
  String backdropImageUrl;
  List<String> genre;
  bool adult;
  String releaseDate;
  String overview;
  MyMDBType myMDBType;
  MyMDBMovie(
      {this.id,
      this.title,
      this.posterImageUrl,
      this.backdropImageUrl,
      this.genre,
      this.adult,
      this.releaseDate,
      this.overview,
      this.myMDBType});

  static MyMDBMovie getEmptyMovie() {
    return MyMDBMovie(
        myMDBType: MyMDBType.EMPTY, backdropImageUrl: '', posterImageUrl: '');
  }
}

enum MyMDBType { MOVIE, TVSERIES, EMPTY }

class MyMdbMovieDetail {
  int id;
  String imdbId;
  List<Genre> genres;
  String overview;
  String title;
  String tagline;
  String posterImageUrl;
}

class Genre {
  int id;
  String name;
  Genre({this.id,this.name});
}

class MyMDBCast {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;
   String profilePathLarge;

}