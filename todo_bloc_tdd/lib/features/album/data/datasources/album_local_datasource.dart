import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_bloc/core/error/exception.dart';
import 'package:todo_bloc/features/album/data/models/album.dart';

abstract class AlbumLocalDataSource {
  Future<List<AlbumModel>> getLastAlbums();
  Future<void> cacheAlbums(List<AlbumModel> albumsToCache);
}
const CACHED_ALBUMS = 'CACHED_ALBUMS';
class AlbumLocalDataSourceImpl implements AlbumLocalDataSource {
  
  //final SharedPreferences sharedPreferences;

  //AlbumLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheAlbums(List<AlbumModel> albumsToCache) {
      return null;/* sharedPreferences.setString(
      CACHED_ALBUMS,
      json.encode(albumsToCache.toJson()),
    ); */
  }

  @override
  Future<List<AlbumModel>> getLastAlbums() {
  /*   final jsonString = sharedPreferences.getString(CACHED_ALBUMS);
    if (jsonString != null) {
      return Future.value(
        
        (json.decode(jsonString) as List)
            .map((i) => AlbumModel.fromJson(i))
            .toList()
        
        );
    } else {
      throw CacheException();
    } */
  }
}
