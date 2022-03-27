import 'package:dartz/dartz.dart';
import 'package:majootestcase/data/models/users_model.dart';
import 'package:majootestcase/domain/repositories/movies_repository.dart';
import 'package:majootestcase/domain/usecase/registration.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMoviesRepository extends Mock implements MoviesRepository {}

void main() {
  late RegistrationUseCase usecase;
  late MockMoviesRepository mockMoviesRepository;

  setUp(() {
    mockMoviesRepository = MockMoviesRepository();
    usecase = RegistrationUseCase(mockMoviesRepository);
  });

  const tUsers =
      UsersModel(email: 'adi@gmail.com', username: 'adi', password: 'Aa123456');

  test('should regis from repository', () async {
    //arrange
    when(() => mockMoviesRepository.registration(tUsers))
        .thenAnswer((_) async => const Right('Registration Success'));
    //act
    final result = await usecase(tUsers);
    //assert
    expect(result, const Right('Registration Success'));
    verify(() => mockMoviesRepository.registration(tUsers));
    verifyNoMoreInteractions(mockMoviesRepository);
  });
}
