import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:majootestcase/models/movie_model.dart';

import 'package:majootestcase/services/dio_config_service.dart' as dioConfig;

class ApiServices{

  Future<MovieModel> getMovieList() async {
    try {
      var dio = await dioConfig.dio();

      return MovieModel();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}