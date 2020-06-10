import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:todo_bloc/core/database/repository_database.dart';
import 'package:todo_bloc/core/error/exception.dart';
import 'package:todo_bloc/features/album/data/models/album.dart';

abstract class AlbumLocalDataSource {
  Future<List<AlbumModel>> getLastAlbums();
  Future<void> cacheAlbums(List<AlbumModel> albumsToCache);
}

class AlbumLocalDataSourceImpl implements AlbumLocalDataSource {
  final DatabaseRepository databaseRepository;

  AlbumLocalDataSourceImpl({@required this.databaseRepository});

  cacheAlbums(List<AlbumModel> albumsToCache) async {
    List<AlbumModel> albumsAdd = List<AlbumModel>();
    List<AlbumModel> albumsUpdate = List<AlbumModel>();

    albumsToCache.forEach((f) async {
      await databaseRepository.findById(f.id).then((album) {
        if (album != null) {
          albumsUpdate.add(album);
        } else {
          albumsAdd.add(f);
        }
      });
    });
    await databaseRepository.update(albumsUpdate);
    await databaseRepository.insert(albumsAdd);
  }

  @override
  Future<List<AlbumModel>> getLastAlbums() async {
    var albums = await databaseRepository.getAll();
    print(albums.length);
    return albums;
  }
}
