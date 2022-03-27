import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:majootestcase/common/failure.dart';
import 'package:majootestcase/data/models/login_model.dart';
import 'package:majootestcase/data/models/users_model.dart';
import 'package:majootestcase/domain/usecase/get_movie.dart';
import 'package:majootestcase/domain/usecase/login.dart';
import 'package:majootestcase/domain/usecase/registration.dart';
import 'package:majootestcase/presentation/bloc/movie_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../fixtures/fixture_reader.dart';

class MockGetMovieUseCase extends Mock implements GetMovieUseCase {}

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockRegistrationUseCase extends Mock implements RegistrationUseCase {}

void main() {
  late MovieCubit bloc;
  late MockGetMovieUseCase mockGetMovieUseCase;
  late MockLoginUseCase mockLoginUseCase;
  late MockRegistrationUseCase mockRegistrationUseCase;

  setUp(() {
    mockGetMovieUseCase = MockGetMovieUseCase();
    mockLoginUseCase = MockLoginUseCase();
    mockRegistrationUseCase = MockRegistrationUseCase();
    bloc = MovieCubit(
        getMovieUseCase: mockGetMovieUseCase,
        loginUseCase: mockLoginUseCase,
        registrationUseCase: mockRegistrationUseCase);
  });

  group('Registration', () {
    const tUsers = UsersModel(
        email: 'adi@gmail.com', username: 'adi', password: 'Aa123456');

    test('should get data from the registration use case', () async {
      //arrange
      when(() => mockRegistrationUseCase(tUsers))
          .thenAnswer((_) async => Right('Registration Success'));
      //act
      bloc.registration(tUsers);
      await untilCalled(() => mockRegistrationUseCase(tUsers));
      //assert
      verify(() => mockRegistrationUseCase(tUsers));
    });

    test('should emit [loading, loaded] when data is gotten successfully',
        () async {
      //arrange
      when(() => mockRegistrationUseCase(tUsers))
          .thenAnswer((_) async => Right('Registration Success'));
      //assert later
      final expected = [
        Loading(),
        RegistrationSuccess(success: 'Registration Success')
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.registration(tUsers);
    });

    test('should emit [loading, loaded] when getting data fails', () async {
      //arrange
      when(() => mockRegistrationUseCase(tUsers))
          .thenAnswer((_) async => Left(DatabaseFailure('error')));
      //assert later
      final expected = [
        Loading(),
        Error(message: 'Database Failure'),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.registration(tUsers);
    });
  });
  group('Login', () {
    const tLogin = LoginModel(email: 'adi@gmail.com', password: 'Aa123456');

    test('should get data from the login use case', () async {
      //arrange
      when(() => mockLoginUseCase(tLogin))
          .thenAnswer((_) async => Right('User Found'));
      //act
      bloc.login(tLogin);
      await untilCalled(() => mockLoginUseCase(tLogin));
      //assert
      verify(() => mockLoginUseCase(tLogin));
    });

    test('should emit [loading, loaded] when data is gotten successfully',
        () async {
      //arrange
      when(() => mockLoginUseCase(tLogin))
          .thenAnswer((_) async => Right('User Found'));
      //assert later
      final expected = [Loading(), LoggedIn(success: 'User Found')];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.login(tLogin);
    });

    test('should emit [loading, loaded] when getting data fails', () async {
      //arrange
      when(() => mockLoginUseCase(tLogin))
          .thenAnswer((_) async => Left(DatabaseFailure('Not Found')));
      //assert later
      final expected = [
        Loading(),
        Error(message: 'Database Failure'),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.login(tLogin);
    });
  });
}
