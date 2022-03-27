import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:majootestcase/data/models/login_model.dart';
import 'package:majootestcase/domain/repositories/movies_repository.dart';
import 'package:majootestcase/domain/usecase/login.dart';
import 'package:mocktail/mocktail.dart';

class MockMoviesRepository extends Mock implements MoviesRepository {}

void main() {
  late LoginUseCase usecase;
  late MockMoviesRepository mockMoviesRepository;

  setUp(() {
    mockMoviesRepository = MockMoviesRepository();
    usecase = LoginUseCase(mockMoviesRepository);
  });

  const tLogin = LoginModel(email: 'adi@gmail.com', password: 'Aa123456');

  test('should login from repository', () async {
    //arrange
    when(() => mockMoviesRepository.login(tLogin))
        .thenAnswer((_) async => const Right('User Found'));
    //act
    final result = await usecase(tLogin);
    //assert
    expect(result, const Right('User Found'));
    verify(() => mockMoviesRepository.login(tLogin));
    verifyNoMoreInteractions(mockMoviesRepository);
  });
}
