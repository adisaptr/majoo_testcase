import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/db/database_helper.dart';
import 'data/datasources/movies_local_data_source.dart';
import 'data/datasources/movies_remote_data_source.dart';
import 'data/repositories/movies_repository_impl.dart';
import 'domain/repositories/movies_repository.dart';
import 'domain/usecase/get_movie.dart';
import 'domain/usecase/login.dart';
import 'domain/usecase/registration.dart';
import 'presentation/bloc/movie_cubit.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //! Features
  //Bloc
  sl.registerFactory(
    () => MovieCubit(
      getMovieUseCase: sl(),
      loginUseCase: sl(),
      registrationUseCase: sl(),
    ),
  );

  // Usecase
  sl.registerLazySingleton(() => GetMovieUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegistrationUseCase(sl()));

  //Repository
  sl.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(
      movieRemoteDataSource: sl(),
      movieLocalDataSource: sl(),
    ),
  );

  // Data Source
  sl.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(
      sharedPreferences: sl(),
      databaseHelper: sl(),
    ),
  );
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  // helper
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
}
