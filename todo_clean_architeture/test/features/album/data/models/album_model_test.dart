import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_bloc/features/album/data/models/album.dart';
import 'package:todo_bloc/features/album/domain/entities/album.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  final tNumberTriviaModel = AlbumModel(id: 1, title: "test", userId: 1);

  test(
    'should be a subclass of Album entity',
    () async {
      // assert
      expect(tNumberTriviaModel, isA<Album>());
    },
  );
  group('fromJson', () {
    test(
      'should return a valid model when the JSON is not null',
      () async {
        // arrange

        final albumJson = (json.decode(fixture('albums.json')) as List);

        // act

        List<AlbumModel> result =
            albumJson.map((i) => AlbumModel.fromJson(i)).toList();

        // assert
        expect(result != null, true);
      },
    );
  });
  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tNumberTriviaModel.toJson();
        // assert
        final expectedJsonMap = {"title": "test", "userId": 1, "id": 1};
        expect(result, expectedJsonMap);
      },
    );
  });
}
