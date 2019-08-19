class TVSeriesList {
  int page;
  List<Results> results;
  int totalPages;
  int totalResults;

  TVSeriesList({this.page, this.results, this.totalPages, this.totalResults});

  TVSeriesList.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }
}

class Results {
  String originalName;
  int id;
  String name;
  int voteCount;
  int voteAverage;
  String firstAirDate;
  String posterPath;
  List<int> genreIds;
  String originalLanguage;
  String backdropPath;
  String overview;
  List<String> originCountry;
  double popularity;

  Results(
      {this.originalName,
      this.id,
      this.name,
      this.voteCount,
      this.voteAverage,
      this.firstAirDate,
      this.posterPath,
      this.genreIds,
      this.originalLanguage,
      this.backdropPath,
      this.overview,
      this.originCountry,
      this.popularity});

  Results.fromJson(Map<String, dynamic> json) {
    originalName = json['original_name'];
    id = json['id'];
    name = json['name'];
    voteCount = json['vote_count'];
    voteAverage = json['vote_average'];
    firstAirDate = json['first_air_date'];
    posterPath = json['poster_path'];
    genreIds = json['genre_ids'].cast<int>();
    originalLanguage = json['original_language'];
    backdropPath = json['backdrop_path'];
    overview = json['overview'];
    originCountry = json['origin_country'].cast<String>();
    popularity = json['popularity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['original_name'] = this.originalName;
    data['id'] = this.id;
    data['name'] = this.name;
    data['vote_count'] = this.voteCount;
    data['vote_average'] = this.voteAverage;
    data['first_air_date'] = this.firstAirDate;
    data['poster_path'] = this.posterPath;
    data['genre_ids'] = this.genreIds;
    data['original_language'] = this.originalLanguage;
    data['backdrop_path'] = this.backdropPath;
    data['overview'] = this.overview;
    data['origin_country'] = this.originCountry;
    data['popularity'] = this.popularity;
    return data;
  }
}