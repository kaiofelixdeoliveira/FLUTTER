import 'package:flutter/material.dart';
import 'package:todo_stream_video/src/widgets/custom_list_item.dart';
import 'package:todo_stream_video/src/widgets/video.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _quantVideos = 0;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    //<!--avatar-->
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        height: _height / 6,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTro7Yy91CzFVEglLCaTs7hf3cN38kuFu2duxDx1hKvoEI2UQEE',
                                ),
                                fit: BoxFit.fill),
                            shape: BoxShape.circle),
                      ),
                    ),
                    //<!--avatar-->
                    //<!--placar-->
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.topCenter,
                        //height: _height / 6,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              cards("0", "fallowers"),
                              cards("34", "fallowing"),
                              cards("21", "likes"),
                            ],
                          ),
                        ),
                      ),
                    )
                    //<!--placar-->
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("Kaio Felix De Oliveira",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.white)),
                    child: Text("EDIT PROFILE"),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(_quantVideos.toString() + '  PUBLIC VIDEOS')
                ],
              ),
              Divider(),
              myVideos(_width, _height, context)
            ],
          ),
        ),
      ),
    );
  }

  photoUser(height) => Container(
      height: height / 6,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTro7Yy91CzFVEglLCaTs7hf3cN38kuFu2duxDx1hKvoEI2UQEE'),
              fit: BoxFit.fill),
          shape: BoxShape.circle));

  cards(content, title) => Container(
      margin: EdgeInsets.all(2),
      width: 70,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Text(content,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Text(title, style: TextStyle(color: Colors.white54))
          ],
        ),
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(5)));

  myVideos(double width, double heigth, BuildContext context) => Container(
        child: ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            CustomListItem(
              subtitle: 'Three-line ListTile',
              thumbnail: Container(
                height: 100,
                decoration: const BoxDecoration(color: Colors.blue),
                child: VideoPlayerScreen(),
              ),
              title: 'The Flutter YouTube Channel',
            ),
            Divider(),
            CustomListItem(
              subtitle: 'Three-line ListTile',
              thumbnail: Container(
                height: 100,
                decoration: const BoxDecoration(color: Colors.blue),
                child: VideoPlayerScreen(),
              ),
              title: 'The Flutter YouTube Channel',
            ),
            Divider(),
            CustomListItem(
              subtitle: 'Three-line ListTile',
              thumbnail: Container(
                height: 100,
                decoration: const BoxDecoration(color: Colors.blue),
                child: VideoPlayerScreen(),
              ),
              title: 'The Flutter YouTube Channel',
            ),
            Divider(),
            CustomListItem(
              subtitle: 'Three-line ListTile',
              thumbnail: Container(
                height: 100,
                decoration: const BoxDecoration(color: Colors.blue),
                child: VideoPlayerScreen(),
              ),
              title: 'The Flutter YouTube Channel',
            ),
          ],
        ),
      );
}
