import 'package:flutter/material.dart';
import 'package:todo_sqlite/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/modules/home/database/init.database.dart';



void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //permite carregar dados dados assincronos no main()
  await DatabaseHelper.instance.database;
  runApp(ModularApp(module: AppModule()));
}