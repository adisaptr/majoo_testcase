import 'package:majootestcase/data/models/movies_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:majootestcase/domain/entities/movies.dart';
import 'dart:convert';

import '../../fixtures/fixture_reader.dart';

void main() {
  const tModel = MoviesModel(
      backdropPath: "/1.jpg",
      firstAirDate: "2022-03-24",
      id: 1,
      voteCount: 19,
      originalLanguage: "en",
      overview: "nice",
      originalName: "Halo",
      posterPath: "/1.jpg",
      voteAverage: 8.2,
      genreIds: [1, 2],
      name: "Halo",
      popularity: 1.1,
      mediaType: "movie");
  test('should be subclass of movies entity', () async {
    expect(tModel, isA<Movies>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('movies.json'))[1];
      //act
      final result = MoviesModel.fromJson(jsonMap);
      //assert
      expect(result, equals(tModel));
    });
  });
}
