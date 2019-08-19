class MovieList {
  int page;
  List<Movie> movies;
  int totalPages;
  int totalResults;

  MovieList({this.page, this.movies, this.totalPages, this.totalResults});

  MovieList.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      movies = new List<Movie>();
      json['results'].forEach((v) {
        movies.add(new Movie.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.movies != null) {
      data['results'] = this.movies.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }
}

class Movie {
  int id;
  bool video;
  int voteCount;
  double voteAverage;
  String title;
  String releaseDate;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String posterPath;
  double popularity;

  Movie(
      {this.id,
      this.video,
      this.voteCount,
      this.voteAverage,
      this.title,
      this.releaseDate,
      this.originalLanguage,
      this.originalTitle,
      this.genreIds,
      this.backdropPath,
      this.adult,
      this.overview,
      this.posterPath,
      this.popularity});

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    video = json['video'];
    voteCount = json['vote_count'];
    voteAverage = (json['vote_average'] is int) ? json['vote_average'].toDouble() : json['vote_average'];
    title = (json['title'] != null ) ? json['title'] : json['name'];
    releaseDate = (json['release_date'] != null ) ? json['release_date'] : json['first_air_date'];
    originalLanguage = json['original_language'];
    originalTitle = (json['original_title'] != null ) ? json['original_title'] : json['original_name'];
    genreIds = json['genre_ids'].cast<int>();
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    popularity = json['popularity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['video'] = this.video;
    data['vote_count'] = this.voteCount;
    data['vote_average'] = this.voteAverage;
    data['title'] = this.title;
    data['release_date'] = this.releaseDate;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['genre_ids'] = this.genreIds;
    data['backdrop_path'] = this.backdropPath;
    data['adult'] = this.adult;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    data['popularity'] = this.popularity;
    return data;
  }
}