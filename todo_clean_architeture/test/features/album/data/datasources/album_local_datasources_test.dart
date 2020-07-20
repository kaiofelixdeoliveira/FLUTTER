import 'dart:convert';
import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_bloc/core/database/repository_database.dart';
import 'package:todo_bloc/core/error/exception.dart';
import 'package:todo_bloc/core/platform/network_info.dart';
import 'package:todo_bloc/features/album/data/datasources/album_local_datasource.dart';
import 'package:todo_bloc/features/album/data/datasources/album_remote_datasource.dart';
import 'package:todo_bloc/features/album/data/models/album.dart';
import 'package:todo_bloc/features/album/data/repositories/album_repository_impl.dart';

import '../../../../fixtures/fixtures_reader.dart';

class MockLocalDataSource extends Mock implements AlbumLocalDataSourceImpl {}

class MockRemoteDataSource extends Mock implements AlbumRemoteDataSourceImpl {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  //Future<Database> database = DatabaseHelper.instance.database;
  MockLocalDataSource mockLocalDataSource;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;
  AlbumRepositoryImpl mockRepository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockRepository = AlbumRepositoryImpl(
        albumLocalDataSource: mockLocalDataSource,
        albumRemoteDataSource: mockRemoteDataSource,
        networkInfo: mockNetworkInfo);
  });

  group('getLastAlbums', () {
    final albumJson = (json.decode(fixture('albums.json')) as List);

    List<AlbumModel> tAlbumModel =
        albumJson.map((i) => AlbumModel.fromJson(i)).toList();

    test(
      'should return Albums when there is one in the cache',
      () async {
        // arrange
        when(mockLocalDataSource.getLastAlbums())
            .thenAnswer((_) async => tAlbumModel);

        // act
        final result = await mockLocalDataSource.getLastAlbums();

        // assert
        verify(await mockLocalDataSource.getLastAlbums());
        expect(result, equals(tAlbumModel));
      },
    );

    test(
      'should throw a CacheExeption when there is not a cached value',
      () async {
        // arrange
        when(mockLocalDataSource.getLastAlbums()).thenThrow(CacheException);
        // act

        // assert

        expect(
            () => mockLocalDataSource.getLastAlbums(), throwsA(CacheException));
      },
    );
  });
}
