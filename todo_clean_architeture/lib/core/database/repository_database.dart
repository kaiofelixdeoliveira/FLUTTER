import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_bloc/features/album/data/models/album.dart';

import 'init_database.dart';

abstract class DatabaseRepository {
  Future<List<AlbumModel>> getAll();
  insert(List<AlbumModel> rows);
  update(List<AlbumModel> rows);
  Future<AlbumModel> findById(id);
}

class DatabaseRepositoryImpl implements DatabaseRepository {
  static final _table = "album";
  Future<Database> database;
  DatabaseRepositoryImpl({@required this.database});

  @override
  Future<List<AlbumModel>> getAll() async {
    final Database db = await database;
    try {
      final album = await db.query(_table);

      return List.generate(album.length, (i) {
        return AlbumModel(
          id: album[i]['id'],
          userId: album[i]['userId'],
          title: album[i]['title'],
        );
      });
    } catch (error) {
      print(error);
    }
    return null;
  }

  @override
  insert(List<AlbumModel> rows) async {
    final Database db = await database;
    Batch batch = db.batch();
    try {
      rows.forEach((row) async {
        batch.insert(_table, row.toJson());
      });
      await batch.commit(noResult: true);
    } catch (error) {
      print(error);
    }
  }

  @override
  update(List<AlbumModel> rows) async {
    final Database db = await database;
    Batch batch = db.batch();
    try {
      rows.forEach((row) async {
        batch
            .update(_table, row.toJson(), where: 'id = ?', whereArgs: [row.id]);
      });
      await batch.commit(noResult: true);
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<AlbumModel> findById(id) async {
    final Database db = await database;
    try {
      List<Map<String, dynamic>> maps = await db.query("$_table",
          columns: ["id", "userId", "title"], where: 'id = ?', whereArgs: [id]);

      if (maps.length > 0) {
        return AlbumModel.fromJson(maps.first);
      }
    } catch (error) {
      print(error);
    }

    return null;
  }
}
