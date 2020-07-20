import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_bloc/core/error/exception.dart';
import 'package:todo_bloc/core/error/failure.dart';
import 'package:todo_bloc/core/platform/network_info.dart';
import 'package:todo_bloc/features/album/data/datasources/album_local_datasource.dart';
import 'package:todo_bloc/features/album/data/datasources/album_remote_datasource.dart';
import 'package:todo_bloc/features/album/data/models/album.dart';
import 'package:todo_bloc/features/album/data/repositories/album_repository_impl.dart';
import 'package:todo_bloc/features/album/domain/entities/album.dart';

class MockRemoteDataSource extends Mock implements AlbumRemoteDataSource {}

class MockLocalDataSource extends Mock implements AlbumLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  AlbumRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AlbumRepositoryImpl(
      albumRemoteDataSource: mockRemoteDataSource,
      albumLocalDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('get Albums', () {
    final tAlbumsModel = [
      AlbumModel(id: 1, title: "test 1", userId: 1),
      AlbumModel(id: 2, title: "test 2", userId: 2),
      AlbumModel(id: 3, title: "test 3", userId: 3),
    ];
    final List<Album> tAlbums = tAlbumsModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getAllAlbums();
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getAllAlbums())
              .thenAnswer((_) async => tAlbumsModel);
          // act
          final result = await repository.getAllAlbums();
          // assert
          verify(mockRemoteDataSource.getAllAlbums());
          expect(result, equals(Right(tAlbums)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getAllAlbums())
              .thenAnswer((_) async => tAlbumsModel);
          // act
          await repository.getAllAlbums();
          // assert
          verify(mockRemoteDataSource.getAllAlbums());
          verify(mockLocalDataSource.cacheAlbums(tAlbumsModel));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getAllAlbums())
              .thenThrow(ServerException("error when loading albums"));
          // act
          final result = await repository.getAllAlbums();
          // assert
          verify(mockRemoteDataSource.getAllAlbums());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastAlbums())
              .thenAnswer((_) async => tAlbumsModel);
          // act
          final result = await repository.getAllAlbums();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastAlbums());
          expect(result, equals(Right(tAlbums)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastAlbums())
              .thenThrow(CacheException("error when cache albums"));
          // act
          final result = await repository.getAllAlbums();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastAlbums());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
