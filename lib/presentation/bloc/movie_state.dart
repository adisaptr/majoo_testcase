part of 'movie_cubit.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class Initial extends MovieState {}

class Loading extends MovieState {}

class Error extends MovieState {
  final String message;

  const Error({required this.message});
}

class LoadedMovies extends MovieState {
  final List<Movies> movies;

  LoadedMovies({required this.movies});
}

class LoggedIn extends MovieState {
  final String success;

  LoggedIn({required this.success});
}

class RegistrationSuccess extends MovieState {
  final String success;

  RegistrationSuccess({required this.success});
}
