import 'package:equatable/equatable.dart';

class Movies extends Equatable {
  final String backdropPath;
  final String firstAirDate;
  final int id;
  final int voteCount;
  final String originalLanguage;
  final String overview;
  final String originalName;
  final String posterPath;
  final double voteAverage;
  final List<dynamic> genreIds;
  final String name;
  final double popularity;
  final String mediaType;

  const Movies(
      {required this.backdropPath,
      required this.firstAirDate,
      required this.id,
      required this.voteCount,
      required this.originalLanguage,
      required this.overview,
      required this.originalName,
      required this.posterPath,
      required this.voteAverage,
      required this.genreIds,
      required this.name,
      required this.popularity,
      required this.mediaType});

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        id,
        voteCount,
        originalLanguage,
        overview,
        originalName,
        posterPath,
        voteAverage,
        genreIds,
        name,
        popularity,
        mediaType
      ];
}
