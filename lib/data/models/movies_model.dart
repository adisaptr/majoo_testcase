import '../../domain/entities/movies.dart';

class MoviesModel extends Movies {
  const MoviesModel(
      {required String backdropPath,
      required String firstAirDate,
      required int id,
      required int voteCount,
      required String originalLanguage,
      required String overview,
      required String originalName,
      required String posterPath,
      required double voteAverage,
      required List<dynamic> genreIds,
      required String name,
      required double popularity,
      required String mediaType})
      : super(
            backdropPath: backdropPath,
            firstAirDate: firstAirDate,
            id: id,
            voteCount: voteCount,
            originalLanguage: originalLanguage,
            overview: overview,
            originalName: originalName,
            posterPath: posterPath,
            voteAverage: voteAverage,
            genreIds: genreIds,
            name: name,
            popularity: popularity,
            mediaType: mediaType);
  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
        backdropPath: json['backdrop_path'],
        firstAirDate: json['first_air_date'] ?? json['release_date'],
        id: json['id'],
        voteCount: json['vote_count'],
        originalLanguage: json['original_language'],
        overview: json['overview'],
        originalName: json['original_name'] ?? json['original_title'],
        posterPath: json['poster_path'],
        voteAverage: json['vote_average'],
        genreIds: json['genre_ids'],
        name: json['name'] ?? json['title'],
        popularity: json['popularity'],
        mediaType: json['media_type']);
  }
}
