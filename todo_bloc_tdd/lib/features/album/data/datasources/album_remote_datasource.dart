import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:todo_bloc/core/error/exception.dart';
import 'package:todo_bloc/features/album/data/models/album.dart';
import 'package:todo_bloc/features/album/domain/entities/album.dart';

abstract class AlbumRemoteDataSource {
  Future<List<AlbumModel>> getAllAlbums();
  Future<AlbumModel> getAlbum(int id);
  Future<AlbumModel> updateAlbum(Album album);
  Future<AlbumModel> deleteAlbum(int id);
  Future<AlbumModel> createAlbum(Album album);
}

const API_URL_BASE = 'https://jsonplaceholder.typicode.com';
const Map<String, String> API_HEADERS = {
  'Content-Type': 'application/json; charset=UTF-8'
};

class AlbumRemoteDataSourceImpl implements AlbumRemoteDataSource {
  final http.Client client;

  AlbumRemoteDataSourceImpl({@required this.client});

  @override
  Future<AlbumModel> getAlbum(int id) async {
    try {
      if (id != null) {
        final response = await http.get('$API_URL_BASE/albums/$id');
        if (response.statusCode == 200) {
          return AlbumModel.fromJson(json.decode(response.body));
        } else {
          throw ServerException();
        }
      }
    } catch (error) {
      throw Exception('Failed to load album ' + error);
    }
    return null;
  }

  Future<List<AlbumModel>> getAllAlbums() async {
    try {
      final response = await http.get('$API_URL_BASE/albums');

      if (response.statusCode == 200) {
        List<AlbumModel> result = (json.decode(response.body) as List)
            .map((i) => AlbumModel.fromJson(i))
            .toList();

        return result;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw Exception('Failed to load albums' + error);
    }
  }

  @override
  Future<AlbumModel> createAlbum(album) async {
    try {
      if (album != null) {
        final response = await http.post(
          '$API_URL_BASE/albums',
          headers: API_HEADERS,
          body: jsonEncode(<String, String>{
            'title': album.title,
          }),
        );

        if (response.statusCode == 201) {
          return AlbumModel.fromJson(json.decode(response.body));
        } else {
          throw ServerException();
        }
      }
    } catch (error) {
      throw Exception('Failed to create album ' + error);
    }
    return null;
  }

  @override
  Future<AlbumModel> deleteAlbum(int id) async {
    try {
      if (id != null) {
        final response = await http.delete(
          '$API_URL_BASE/albums/$id',
          headers: API_HEADERS,
        );
        if (response.statusCode == 200) {
          return AlbumModel.fromJson(json.decode(response.body));
        } else {
          throw ServerException();
        }
      }
    } catch (error) {
      throw Exception('Failed delete album ' + error);
    }
    return null;
  }

  @override
  Future<AlbumModel> updateAlbum(album) async {
    try {
      if (album != null) {
        final response = await http.put(
          '$API_URL_BASE/albums/${album.id}',
          headers: API_HEADERS,
          body: jsonEncode(<String, String>{
            'title': album.title,
          }),
        );
        if (response.statusCode == 200) {
          return AlbumModel.fromJson(json.decode(response.body));
        } else {
          throw ServerException();
        }
      }
    } catch (error) {
      throw Exception('Failed update album ' + error);
    }
    return null;
  }
}
