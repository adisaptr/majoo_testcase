import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:majootestcase/common/exception.dart';
import 'package:majootestcase/common/failure.dart';
import 'package:majootestcase/data/datasources/movies_local_data_source.dart';
import 'package:majootestcase/data/datasources/movies_remote_data_source.dart';
import 'package:majootestcase/data/models/login_model.dart';
import 'package:majootestcase/data/models/movies_model.dart';
import 'package:majootestcase/data/models/users_model.dart';
import 'package:majootestcase/data/repositories/movies_repository_impl.dart';
import 'package:majootestcase/domain/entities/movies.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';

class MockMovieLocalDataSource extends Mock implements MovieLocalDataSource {}

class MockMovieRemoteDataSource extends Mock implements MovieRemoteDataSource {}

void main() {
  late MoviesRepositoryImpl repository;
  late MockMovieLocalDataSource mockMovieLocalDataSource;
  late MockMovieRemoteDataSource mockMovieRemoteDataSource;

  setUp(() {
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();
    mockMovieLocalDataSource = MockMovieLocalDataSource();
    repository = MoviesRepositoryImpl(
        movieRemoteDataSource: mockMovieRemoteDataSource,
        movieLocalDataSource: mockMovieLocalDataSource);
  });

  group('getMovies', () {
    var dataResult =
        json.decode((fixture('moviesarray.json')))['results'] as List;
    final tMovieModel =
        dataResult.map((tagJson) => MoviesModel.fromJson(tagJson)).toList();
    final List<Movies> tMovies = tMovieModel;
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      //arrange
      when(() => mockMovieRemoteDataSource.getMovie())
          .thenAnswer((_) async => tMovies);
      //act
      final result = await repository.getMovie();
      //assert
      verify(() => mockMovieRemoteDataSource.getMovie());
      expect(result, equals(Right(tMovies)));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(() => mockMovieRemoteDataSource.getMovie())
          .thenThrow(ServerException());
      //act
      final result = await repository.getMovie();
      //assert
      verify(() => mockMovieRemoteDataSource.getMovie());
      expect(result, equals(left(ServerFailure())));
    });
  });
  group('registration', () {
    const tUsers =
        UsersModel(email: 'adi@gmail', username: 'adi', password: 'Aa123456');
    test('should return success message when registration successful',
        () async {
      // arrange
      when(() => mockMovieLocalDataSource.registration(tUsers))
          .thenAnswer((_) async => 'Registration Success');
      // act
      final result = await repository.registration(tUsers);
      // assert
      expect(result, Right('Registration Success'));
    });

    test('should return DatabaseFailure when registration unsuccessful',
        () async {
      // arrange
      when(() => mockMovieLocalDataSource.registration(tUsers))
          .thenThrow(DatabaseException('Registration Failed'));
      // act
      final result = await repository.registration(tUsers);
      // assert
      expect(result, Left(DatabaseFailure('Registration Failed')));
    });
  });
  group('Login', () {
    const tLogin = LoginModel(email: 'adi@gmail.com', password: 'Aa123456');
    test('should return success message when user found', () async {
      // arrange
      when(() => mockMovieLocalDataSource.login(tLogin))
          .thenAnswer((_) async => 'User Found');
      // act
      final result = await repository.login(tLogin);
      // assert
      expect(result, const Right('User Found'));
    });

    test('should return not found when user not found', () async {
      // arrange
      when(() => mockMovieLocalDataSource.login(tLogin))
          .thenThrow(DatabaseException('Not Found'));
      // act
      final result = await repository.login(tLogin);
      // assert
      expect(result, Left(DatabaseFailure('Not Found')));
    });
  });
}
