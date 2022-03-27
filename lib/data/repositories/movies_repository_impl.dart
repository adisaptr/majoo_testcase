import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../common/error_helper.dart';
import '../../common/exception.dart';
import '../../common/failure.dart';
import '../../domain/entities/movies.dart';
import '../../domain/repositories/movies_repository.dart';
import '../datasources/movies_local_data_source.dart';
import '../datasources/movies_remote_data_source.dart';
import '../models/login_model.dart';
import '../models/users_model.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MovieRemoteDataSource movieRemoteDataSource;
  final MovieLocalDataSource movieLocalDataSource;

  MoviesRepositoryImpl(
      {required this.movieRemoteDataSource,
      required this.movieLocalDataSource});
  @override
  Future<Either<Failure, List<Movies>>> getMovie() async {
    try {
      final remote = await movieRemoteDataSource.getMovie();
      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    } on SocketException catch (e) {
      return Left(ConnectionFailure(ErrorHelper.extractApiError(e)));
    }
  }

  @override
  Future<Either<Failure, String>> login(LoginModel login) async {
    try {
      final result = await movieLocalDataSource.login(login);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> registration(UsersModel users) async {
    try {
      final result = await movieLocalDataSource.registration(users);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }
}
