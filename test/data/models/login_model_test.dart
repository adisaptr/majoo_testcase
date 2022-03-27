import 'package:majootestcase/data/models/login_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:majootestcase/domain/entities/login.dart';

void main() {
  const tLogin = LoginModel(email: 'adi@gmail.com', password: 'Aa123456');
  const tLoginJson = {"email": 'adi@gmail.com', "password": 'Aa123456'};

  test('should be subclass of login entity', () async {
    expect(tLogin, isA<Login>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      //arrange
      const Map<String, dynamic> jsonMap = tLoginJson;
      //act
      final result = LoginModel.fromJson(jsonMap);
      //assert
      expect(result, equals(tLogin));
    });
  });
  group('toJson', () {
    test('should return a Json map containing the proper data', () async {
      //act
      final result = tLogin.toJson();
      //assert
      expect(result, tLoginJson);
    });
  });
}
