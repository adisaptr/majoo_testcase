import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);
}

class ServerFailure extends Failure {
  @override
  List<Object> get props => [];
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => [];
}

class DatabaseFailure extends Failure {
  final String message;

  const DatabaseFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class ConnectionFailure extends Failure {
  final String message;

  const ConnectionFailure(this.message);

  @override
  List<Object?> get props => [message];
}
