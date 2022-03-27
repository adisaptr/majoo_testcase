import 'dart:async';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio dioInstance;
createInstance() async {

  var option = BaseOptions(
    baseUrl: "https://api.themoviedb.org/3/trending/all/day?api_key=0bc9e6490f0a9aa230bd01e268411e10",
    connectTimeout: 10000,
    receiveTimeout: 10000
  );


  dioInstance = new Dio(option);
  dioInstance.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90));

}

Future<Dio> dio() async {
  await createInstance();
  dioInstance.options.baseUrl = "https://api.themoviedb.org/3/trending/all/day?api_key=0bc9e6490f0a9aa230bd01e268411e10";
  return dioInstance;
}

