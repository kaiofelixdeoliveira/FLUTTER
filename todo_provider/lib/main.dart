import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'src/login_screeen.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      LoginScreen1(backgroundColor: Colors.red,primaryColor: Colors.lightBlue,);
      
    
  }
}
