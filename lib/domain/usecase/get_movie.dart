import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/movies.dart';
import '../repositories/movies_repository.dart';

class GetMovieUseCase {
  final MoviesRepository repository;

  GetMovieUseCase(this.repository);
  Future<Either<Failure, List<Movies>>> call() async {
    return await repository.getMovie();
  }
}
