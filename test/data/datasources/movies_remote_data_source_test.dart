import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:majootestcase/common/exception.dart';
import 'package:majootestcase/data/datasources/movies_remote_data_source.dart';
import 'package:majootestcase/data/models/movies_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MovieRemoteDataSourceImpl dataSource;
  late Dio mockDio;
  const url =
      'https://api.themoviedb.org/3/trending/all/day?api_key=0bc9e6490f0a9aa230bd01e268411e10';

  setUp(() {
    mockDio = MockDio();
    dataSource = MovieRemoteDataSourceImpl(client: mockDio);
  });

  void setMockDioSuccess200(String json) {
    when(() => mockDio.get(url)).thenAnswer(
      (_) async => Response(
        data: fixture(json),
        statusCode: 200,
        requestOptions: RequestOptions(
          path: url,
        ),
      ),
    );
  }

  void setMockDioFailure404() {
    when(() => mockDio.get(url)).thenAnswer(
      (_) async => Response(
        data: 'Something When Wrong',
        statusCode: 404,
        requestOptions: RequestOptions(
          path: url,
        ),
      ),
    );
  }

  group('getMovies', () {
    var dataResult =
        json.decode((fixture('moviesarray.json')))['results'] as List;
    final tMovieModel =
        dataResult.map((tagJson) => MoviesModel.fromJson(tagJson)).toList();
    test('should perform Get request on URL', () async {
      //arrange
      setMockDioSuccess200('moviesarray.json');
      //act
      dataSource.getMovie();
      //assert
      verify(() => mockDio.get(url));
    });
    test('should return response when the response is 200(success)', () async {
      //arrange
      setMockDioSuccess200('moviesarray.json');
      //act
      final result = await dataSource.getMovie();
      //assert
      expect(result, equals(tMovieModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      setMockDioFailure404();
      //act
      final call = dataSource.getMovie();
      //assert
      expect(() => call, throwsA(isInstanceOf<ServerException>()));
    });
  });
}
