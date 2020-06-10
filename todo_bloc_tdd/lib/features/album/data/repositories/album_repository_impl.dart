import 'package:dartz/dartz.dart';
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
    return Right(await albumRemoteDataSource.getAlbum(params));
  }

  Future<Either<Failure, List<entitie.Album>>> getAllAlbums() async {

    
    if (await networkInfo.isConnected) {
      try {
        final List<AlbumModel> albums = await albumRemoteDataSource.getAllAlbums();
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
    return Right(await albumRemoteDataSource.createAlbum(album));
  }

  @override
  Future<Either<Failure, AlbumModel>> deleteAlbum(int id) async {
    return Right(await albumRemoteDataSource.deleteAlbum(id));
  }

  @override
  Future<Either<Failure, AlbumModel>> updateAlbum(entitie.Album album) async {
    return Right(await albumRemoteDataSource.updateAlbum(album));
  }
}
