import 'package:dartz/dartz.dart';
import 'package:todo_bloc/core/error/failure.dart';
import 'package:todo_bloc/features/album/domain/entities/album.dart';
import 'package:todo_bloc/features/album/domain/usecases/getAlbum.dart';


abstract class AlbumRepository {
  Future<Either<Failure,List<Album>>> getAllAlbums();
  Future<Either<Failure,Album>> getAlbum(int id);
  Future<Either<Failure,Album>> updateAlbum(Album album);
  Future<Either<Failure,Album>> deleteAlbum(int id);
  Future<Either<Failure,Album>> createAlbum(Album album);
}