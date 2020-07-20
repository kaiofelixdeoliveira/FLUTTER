import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_bloc/core/error/failure.dart';
import 'package:todo_bloc/features/album/domain/entities/album.dart' as entitie;
import 'package:todo_bloc/features/album/domain/repositories/album_repository.dart';

class CreateAlbum {
  final AlbumRepository repository;

  CreateAlbum({@required this.repository});

  Future<Either<Failure, entitie.Album>> call(entitie.Album album) async {
    return await repository.createAlbum(album);
  }
}

