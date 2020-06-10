import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_bloc/core/error/failure.dart';
import 'package:todo_bloc/features/album/domain/entities/album.dart' as entitie;
import 'package:todo_bloc/features/album/domain/repositories/album_repository.dart';

class GetAlbums {
  final AlbumRepository repository;

GetAlbums({@required this.repository});

  Future<Either<Failure, List<entitie.Album>>> getAllAlbums(
      entitie.Album params) async {
    return await repository.getAllAlbums();
  }
}
