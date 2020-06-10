import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_bloc/core/error/failure.dart';
import 'package:todo_bloc/features/album/domain/entities/album.dart' as entitie;
import 'package:todo_bloc/features/album/domain/repositories/album_repository.dart';

class GetAlbum {
  final AlbumRepository repository;

  GetAlbum({@required this.repository});

  Future<Either<Failure, entitie.Album>> call(int id) async {
    return await repository.getAlbum(id);
  }
}

