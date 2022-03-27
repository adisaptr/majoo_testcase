import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../../data/models/users_model.dart';
import '../repositories/movies_repository.dart';

class RegistrationUseCase {
  final MoviesRepository repository;

  RegistrationUseCase(this.repository);
  Future<Either<Failure, String>> call(UsersModel users) async {
    return await repository.registration(users);
  }
}
