import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../../data/models/login_model.dart';
import '../../data/models/users_model.dart';
import '../entities/movies.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<Movies>>> getMovie();
  Future<Either<Failure, String>> login(LoginModel login);
  Future<Either<Failure, String>> registration(UsersModel users);
}
