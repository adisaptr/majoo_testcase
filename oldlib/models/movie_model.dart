class MovieModel {
  int page;
  List<Results> results;
  int totalPages;
  int totalResults;

  MovieModel({this.page, this.results, this.totalPages, this.totalResults});

  MovieModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
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
  double voteAverage;
  String overview;
  String releaseDate;
  bool adult;
  String backdropPath;
  int voteCount;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String posterPath;
  String title;
  bool video;
  double popularity;
  String mediaType;
  String name;
  String originalName;
  List<String> originCountry;
  String firstAirDate;

  Results(
      {this.voteAverage,
        this.overview,
        this.releaseDate,
        this.adult,
        this.backdropPath,
        this.voteCount,
        this.genreIds,
        this.id,
        this.originalLanguage,
        this.originalTitle,
        this.posterPath,
        this.title,
        this.video,
        this.popularity,
        this.mediaType,
        this.name,
        this.originalName,
        this.originCountry,
        this.firstAirDate});

  Results.fromJson(Map<String, dynamic> json) {
    voteAverage = json['vote_average'];
    overview = json['overview'];
    releaseDate = json['release_date'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    voteCount = json['vote_count'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    posterPath = json['poster_path'];
    title = json['title'];
    video = json['video'];
    popularity = json['popularity'];
    mediaType = json['media_type'];
    name = json['name'];
    originalName = json['original_name'];
    originCountry = json['origin_country'].cast<String>();
    firstAirDate = json['first_air_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vote_average'] = this.voteAverage;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['vote_count'] = this.voteCount;
    data['genre_ids'] = this.genreIds;
    data['id'] = this.id;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['poster_path'] = this.posterPath;
    data['title'] = this.title;
    data['video'] = this.video;
    data['popularity'] = this.popularity;
    data['media_type'] = this.mediaType;
    data['name'] = this.name;
    data['original_name'] = this.originalName;
    data['origin_country'] = this.originCountry;
    data['first_air_date'] = this.firstAirDate;
    return data;
  }
}