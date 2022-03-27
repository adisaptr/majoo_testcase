import 'package:equatable/equatable.dart';

class Users extends Equatable {
  final String username;
  final String email;
  final String password;

  const Users(this.email, this.username, this.password);

  @override
  List<Object?> get props => [email, username, password];
}
