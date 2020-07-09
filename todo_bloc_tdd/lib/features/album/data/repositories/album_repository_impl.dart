import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_bloc/core/error/failure.dart';
import 'package:todo_bloc/core/platform/network_info.dart';
import 'package:todo_bloc/features/album/data/datasources/album_local_datasource.dart';
import 'package:todo_bloc/features/album/data/datasources/album_remote_datasource.dart';
import 'package:todo_bloc/features/album/data/models/album.dart';
import 'package:todo_bloc/features/album/domain/entities/album.dart' as entitie;
import 'package:todo_bloc/features/album/domain/repositories/album_repository.dart';
import 'package:todo_bloc/core/error/exception.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final AlbumRemoteDataSource albumRemoteDataSource;
  final AlbumLocalDataSource albumLocalDataSource;
  final NetworkInfo networkInfo;

  AlbumRepositoryImpl({
    @required this.albumRemoteDataSource,
    @required this.albumLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, entitie.Album>> getAlbum(int params) async {
    if (await networkInfo.isConnected) {
      return Right(await albumRemoteDataSource.getAlbum(params));
    }
    return null;
  }

  Future<Either<Failure, List<entitie.Album>>> getAllAlbums() async {
    if (await networkInfo.isConnected) {
      try {
        final List<AlbumModel> albums =
            await albumRemoteDataSource.getAllAlbums();
        albumLocalDataSource.cacheAlbums(albums);
        return Right(albums);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localAlbums = await albumLocalDataSource.getLastAlbums();
        return Right(localAlbums);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, entitie.Album>> createAlbum(
      entitie.Album album) async {
    if (await networkInfo.isConnected) {
      final albumReceived = await albumRemoteDataSource.createAlbum(album);
      return Right(albumReceived);
    }
    return null;
  }

  @override
  Future<Either<Failure, AlbumModel>> deleteAlbum(int id) async {
    if (await networkInfo.isConnected) {
      return Right(await albumRemoteDataSource.deleteAlbum(id));
    }
    return null;
  }

  @override
  Future<Either<Failure, AlbumModel>> updateAlbum(entitie.Album album) async {
    if (await networkInfo.isConnected) {
      return Right(await albumRemoteDataSource.updateAlbum(album));
    }
    return null;
  }
}
