import 'dart:convert';
import 'dart:io';

import 'package:todo_bloc/features/album/data/models/album.dart';

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();

List<AlbumModel> fixtures(String name) =>
    (json.decode(File('test/fixtures/$name').readAsStringSync()) as List)
        .map((i) => AlbumModel.fromJson(i))
        .toList();
