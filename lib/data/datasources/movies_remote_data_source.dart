import 'package:dio/dio.dart';

import '../../common/exception.dart';
import '../../domain/entities/movies.dart';
import '../models/movies_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<Movies>> getMovie();
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final Dio client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Movies>> getMovie() async {
    try {
      var response = await client.get(
          'https://api.themoviedb.org/3/trending/all/day?api_key=0bc9e6490f0a9aa230bd01e268411e10');
      if (response.statusCode == 200) {
        var dataResult = response.data['results'] as List;
        List<Movies> result =
            dataResult.map((json) => MoviesModel.fromJson(json)).toList();
        return result;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
