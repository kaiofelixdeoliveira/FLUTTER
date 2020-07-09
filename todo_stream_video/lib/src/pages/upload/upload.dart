import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_stream_video/src/pages/login/login.dart';
import 'package:todo_stream_video/src/pages/upload/upload_video.dart';
import 'package:video_player/video_player.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final ImagePicker _picker = ImagePicker();
  bool isVideo = false;
  VideoPlayerController _controller;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _login = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefValue) => {
          setState(() {
            _login = prefValue.getBool('login') ?? false;
          })
        });
  }

  Future<PickedFile> _onImageButtonPressed(ImageSource source,
      {BuildContext context}) async {
    if (_controller != null) {
      await _controller.setVolume(0.0);
    }
    if (isVideo) {
      final PickedFile video = await _picker.getVideo(
        source: source,
        maxDuration: const Duration(seconds: 10),
      );
      return video;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload"),
      ),
      body: _login
          ? Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      backgroundColor: Colors.red,
                      onPressed: () async {
                        isVideo = true;
                        final video =
                            await _onImageButtonPressed(ImageSource.gallery);
                        if (video != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UploadVideoPage()));
                        }
                      },
                      heroTag: 'video0',
                      tooltip: 'Pick Video from gallery',
                      child: const Icon(
                        Icons.video_library,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      backgroundColor: Colors.red,
                      onPressed: () async {
                        isVideo = true;
                        final video =
                            await _onImageButtonPressed(ImageSource.camera);
                        if (video != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UploadVideoPage()));
                        }
                      },
                      heroTag: 'video1',
                      tooltip: 'Take a Video',
                      child: const Icon(Icons.videocam, color: Colors.white),
                    ),
                  ),
                ],
              ))
          : LoginPage(),
    );
  }
}
