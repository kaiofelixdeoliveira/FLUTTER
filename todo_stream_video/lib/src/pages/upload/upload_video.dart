import 'package:flutter/material.dart';
import 'package:todo_stream_video/src/pages/home/home.dart';
import 'package:todo_stream_video/src/widgets/video.dart';

class UploadVideoPage extends StatefulWidget {
  @override
  _UploadVideoPageState createState() => _UploadVideoPageState();
}

class _UploadVideoPageState extends State<UploadVideoPage> {
  TextEditingController _controllerTitle;
  TextEditingController _controllerDescription;
  void initState() {
    super.initState();
    _controllerTitle = TextEditingController();
    _controllerDescription = TextEditingController();
  }

  void dispose() {
    _controllerTitle.dispose();
    _controllerDescription.dispose();
    super.dispose();
  }

  uploadButton() {
    return MaterialButton(
      elevation: 5,
      padding: EdgeInsets.all(5),
      onPressed: () => Navigator.pop(context),
      color: Colors.blue,
      child: Text("UPLOAD"),
    );
  }

  appBarCustom() => AppBar(
      leading: BackButton(color: Colors.white),
      elevation: 0,
      actions: <Widget>[uploadButton()],
      title: Text("Video Settings", style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.transparent);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    ClipRect(
                        child: Container(
                            width: _width,
                            height: _height / 3,
                            child: VideoPlayerScreen())),
                    Container(height: _height / 10, child: appBarCustom())
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextField(
                      controller: _controllerTitle,
                      decoration: InputDecoration(
                          labelText: 'Title', hintText: "Untitle"),
                    ),
                    TextField(
                      controller: _controllerDescription,
                      decoration: InputDecoration(labelText: 'Description'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
