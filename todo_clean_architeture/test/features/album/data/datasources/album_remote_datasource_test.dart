import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_bloc/core/error/exception.dart';
import 'package:todo_bloc/features/album/data/datasources/album_remote_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:todo_bloc/features/album/data/models/album.dart';

import '../../../../fixtures/fixtures_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  AlbumRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = AlbumRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('album.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getAlbum', () {
    final id = 1;
    final albumModel = AlbumModel.fromJson(json.decode(fixture('album.json')));

    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        await dataSource.getAlbum(id);
        // assert
        verify(mockHttpClient.get(
          'https://jsonplaceholder.typicode.com/albums/$id',
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getAlbum(id);
        // assert
        expect(result, equals(albumModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getAlbum;
        // assert
        expect(() => call(id), throwsA(ServerException));
      },
    );
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        AlbumModel.fromJson(json.decode(fixture('album.json')));

    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getAllAlbums();

        // assert
        verifyNever(mockHttpClient.get(
          'https://jsonplaceholder.typicode.com/albums',
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getAllAlbums();
        // assert
        expect(result != null, true);
        expect(result.length > 0, true);
      },
    );
  });
}
