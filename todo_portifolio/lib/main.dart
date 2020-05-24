import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: uri_does_not_exist
import 'dart:html' as HTML;

import 'package:todo_portifolio/home/home.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Portifolio', theme: _theme(), home: HomePage());
  }

  ThemeData _theme() {
    var lightTheme = ThemeData.dark();

    return lightTheme.copyWith(
        brightness: Brightness.dark,
        textTheme: lightTheme.textTheme.copyWith(
            body1: lightTheme.textTheme.body1.copyWith(height: 1.25),
            body2: lightTheme.textTheme.body2
                .copyWith(height: 1.25, fontWeight: FontWeight.w800)),
        appBarTheme: AppBarTheme(color: Color.fromARGB(255, 30, 30, 30)));
  }
}
