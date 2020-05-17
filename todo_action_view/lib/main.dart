import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('app.channel.shared.document');
  static const methodChannel = "getSharedDocument";
  static File _document;
  
  @override
  void initState() {
    super.initState();
    getSharedDocument();
  }

  getSharedDocument() async {
    var sharedDocument = await platform.invokeMethod(methodChannel);
    if (sharedDocument != null) {
      Permission permission = Permission.storage;
      final permissionStatusCurrent = await permission.request();

      if (permissionStatusCurrent == PermissionStatus.granted) {
        setState(() {
          _document = File(sharedDocument);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
   
      print(_document);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                _document != null ? _document.path : "nothing",
                style: Theme.of(context).textTheme.display1,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
