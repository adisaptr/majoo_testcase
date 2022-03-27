import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:majootestcase/domain/entities/movies.dart';
import 'package:majootestcase/domain/repositories/movies_repository.dart';
import 'package:majootestcase/domain/usecase/get_movie.dart';
import 'package:mocktail/mocktail.dart';

class MockMoviesRepository extends Mock implements MoviesRepository {}

void main() {
  late GetMovieUseCase usecase;
  late MockMoviesRepository mockMoviesRepository;

  setUp(() {
    mockMoviesRepository = MockMoviesRepository();
    usecase = GetMovieUseCase(mockMoviesRepository);
  });

  final tMovies = [
    const Movies(
        backdropPath: "/1.jpg",
        firstAirDate: "2022-03-24",
        id: 1,
        voteCount: 19,
        originalLanguage: "en",
        overview: "nice",
        originalName: "Halo",
        posterPath: "/1.jpg",
        voteAverage: 8.2,
        genreIds: [1, 2],
        name: "Halo",
        popularity: 1.1,
        mediaType: "movie")
  ];
  test('should get list movies from repository', () async {
    //arrange
    when(() => mockMoviesRepository.getMovie())
        .thenAnswer((_) async => Right(tMovies));
    //act
    final result = await usecase();
    //assert
    expect(result, Right(tMovies));
    verify(() => mockMoviesRepository.getMovie());
    verifyNoMoreInteractions(mockMoviesRepository);
  });
}
