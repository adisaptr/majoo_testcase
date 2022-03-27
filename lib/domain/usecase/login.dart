import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../../data/models/login_model.dart';
import '../repositories/movies_repository.dart';

class LoginUseCase {
  final MoviesRepository repository;

  LoginUseCase(this.repository);
  Future<Either<Failure, String>> call(LoginModel login) async {
    return await repository.login(login);
  }
}
