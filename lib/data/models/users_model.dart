import '../../domain/entities/users.dart';

class UsersModel extends Users {
  const UsersModel(
      {required String email,
      required String username,
      required String password})
      : super(email, username, password);

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
        email: json['email'],
        username: json['username'],
        password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'password': password,
    };
  }
}
