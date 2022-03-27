import 'package:shared_preferences/shared_preferences.dart';

import '../../common/exception.dart';
import '../models/login_model.dart';
import '../models/users_model.dart';
import 'db/database_helper.dart';

abstract class MovieLocalDataSource {
  Future<String> registration(UsersModel users);
  Future<String> login(LoginModel login);
}

class MovieLocalDataSourceImpl extends MovieLocalDataSource {
  final SharedPreferences sharedPreferences;
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl(
      {required this.sharedPreferences, required this.databaseHelper});
  @override
  Future<String> registration(UsersModel users) async {
    try {
      await databaseHelper.insertUsers(users);
      return 'Registration Success';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> login(LoginModel login) async {
    final result = await databaseHelper.getLogin(login.email, login.password);
    if (result != null) {
      sharedPreferences.setString(
        'user_value',
        result,
      );
      return 'User Found';
    } else {
      throw DatabaseException('Not Found');
    }
  }
}
