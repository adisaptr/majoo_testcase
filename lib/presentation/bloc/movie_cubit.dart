import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/login_model.dart';
import '../../data/models/users_model.dart';
import '../../domain/entities/movies.dart';
import '../../domain/usecase/get_movie.dart';
import '../../domain/usecase/login.dart';
import '../../domain/usecase/registration.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final GetMovieUseCase getMovieUseCase;
  final LoginUseCase loginUseCase;
  final RegistrationUseCase registrationUseCase;
  MovieCubit(
      {required this.getMovieUseCase,
      required this.loginUseCase,
      required this.registrationUseCase})
      : super(Initial());

  void login(LoginModel login) async {
    emit(Loading());
    final failureOrSuccess = await loginUseCase(login);
    failureOrSuccess.fold((failure) {
      emit(Error(message: 'error'));
    }, (success) {
      emit(LoggedIn(success: success));
    });
  }

  void registration(UsersModel users) async {
    emit(Loading());
    final failureOrSuccess = await registrationUseCase(users);
    failureOrSuccess.fold((failure) {
      emit(Error(message: 'error'));
    }, (success) {
      emit(RegistrationSuccess(success: success));
    });
  }

  void getMovie() async {
    emit(Loading());
    final failureOrSuccess = await getMovieUseCase();
    failureOrSuccess.fold((failure) {
      emit(Error(message: failure.toString()));
    }, (success) {
      emit(LoadedMovies(movies: success));
    });
  }
}
