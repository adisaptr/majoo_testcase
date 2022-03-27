import 'package:flutter_test/flutter_test.dart';
import 'package:majootestcase/common/exception.dart';
import 'package:majootestcase/data/datasources/db/database_helper.dart';
import 'package:majootestcase/data/datasources/movies_local_data_source.dart';
import 'package:majootestcase/data/models/login_model.dart';
import 'package:majootestcase/data/models/users_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MovieLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;
  late MockSharedPreferences mockSharedPreferences;
  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    mockSharedPreferences = MockSharedPreferences();
    dataSource = MovieLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences,
        databaseHelper: mockDatabaseHelper);
  });

  group('registration', () {
    const tUsers =
        UsersModel(email: 'adi@gmail', username: 'adi', password: 'Aa123456');
    test(
        'should return success message when insert registration data to database is success',
        () async {
      // arrange
      when(() => mockDatabaseHelper.insertUsers(tUsers))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.registration(tUsers);
      // assert
      expect(result, 'Registration Success');
    });

    test(
        'should throw DatabaseException when registration data insert to database is failed',
        () async {
      // arrange
      when(() => mockDatabaseHelper.insertUsers(tUsers)).thenThrow(Exception());
      // act
      final call = dataSource.registration(tUsers);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Login', () {
    const tUser = {
      'id': 1,
      'username': 'adi',
      'email': 'adi@gmail.com',
      'password': 'Aa123456'
    };
    const tLogin = LoginModel(email: 'adi@gmail.com', password: 'Aa123456');

    test('should return success when user is found', () async {
      // arrange
      when(() => mockDatabaseHelper.getLogin('adi@gmail.com', 'Aa123456'))
          .thenAnswer((_) async => tUser.toString());
      // act
      final result = await dataSource.login(tLogin);
      // assert
      expect(result, 'User Found');
    });

    test('should throw DatabaseException when login data is not found',
        () async {
      // arrange
      when(() => mockDatabaseHelper.getLogin('adi@gmail.com', 'Aa123456'))
          .thenAnswer((_) async => null);
      // act
      final call = dataSource.login(tLogin);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });
}
