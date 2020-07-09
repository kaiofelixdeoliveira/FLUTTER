import 'package:flutter/material.dart';
import 'package:todo_stream_video/src/widgets/expandable_text.dart';
import 'package:todo_stream_video/src/widgets/tab_details_video.dart';
import 'package:todo_stream_video/src/widgets/video.dart';
import 'package:todo_stream_video/src/widgets/video_chewie.dart';

class VideoDetailsPage extends StatefulWidget {
  @override
  _VideoDetailsPageState createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends State<VideoDetailsPage> {
  appBarCustom() => AppBar(
      leading: BackButton(color: Colors.white),
      elevation: 0,
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.favorite, color: Colors.white), onPressed: () {}),
        IconButton(
            icon: Icon(Icons.arrow_downward, color: Colors.white),
            onPressed: () {}),
        IconButton(
            icon: Icon(Icons.share, color: Colors.white), onPressed: () {}),
        IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white), onPressed: () {}),
      ],
      backgroundColor: Colors.transparent);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Stack(
                children: <Widget>[
                  ClipRect(
                      child: Container(
                          width: _width,
                          height: _height / 3,
                          child: VideoChewieWidget())),
                  Container(height: _height / 10, child: appBarCustom())
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text("Title Video",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Wrap(
                                children: <Widget>[
                                  Icon(Icons.playlist_play,
                                      color: Colors.white, size: 20),
                                  Text("3.5K")
                                ],
                              ),
                              SizedBox(width: 30),
                              Wrap(children: <Widget>[
                                Icon(Icons.favorite,
                                    color: Colors.white, size: 20),
                                Text("3.5K")
                              ]),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: <Widget>[],
                          ),
                          ExpandableText(
                              "Nos últimos tempos realizamos muitas mudanças que destacam o profissionalismo, a especialização, a trajetória e o conhecimento dos profissionais que atuam de forma freelance na atualidade em nossa plataforma. Fique sabendo com esta nota quais são e em que te beneficiam."),
                        ],
                      ),
                    ),
                    Divider(),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTro7Yy91CzFVEglLCaTs7hf3cN38kuFu2duxDx1hKvoEI2UQEE'),
                      ),
                      title: Text('Title'),
                      subtitle: Text('This is Subtitle'),
                      trailing: MaterialButton(
                        onPressed: () {},
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.white)),
                        child: Text("+ FALLOW"),
                      ),
                    ),
                    SizedBox(
                        width: _width,
                        height: 300.0,
                        child: TabDetailsVideoWidget())
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
