import 'package:flutter/material.dart';
import 'package:todo_stream_video/src/pages/upload/upload_video.dart';
import 'package:todo_stream_video/src/pages/video_details.dart';
import 'package:todo_stream_video/src/widgets/custom_list_item.dart';
import 'package:todo_stream_video/src/widgets/video.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Text("MY FEED",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start),
                Divider(),
                myFeed(context),
                SizedBox(height: 10),
                Text("RECENT VIDEOS",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start),
                Divider(),
                recentVideos(_width, _height, context)
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'searchHome',
        onPressed: () {},
        child: Icon(
          Icons.search,
        ),
      ),
    );
  }
}

recentVideos(double width, double heigth, BuildContext context) => Container(
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

myFeed(BuildContext context) => Container(
      height: 220.0,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          InkWell(
            onTap: () => viewDetails(context),
            child: Container(
              margin: EdgeInsets.only(right: 8.0),
              width: 250.0,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 150.00,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTro7Yy91CzFVEglLCaTs7hf3cN38kuFu2duxDx1hKvoEI2UQEE',
                            ),
                            fit: BoxFit.fill)),
                  ),
                  Container(
                    color: Theme.of(context).cardColor,
                    child: ListTile(
                      title: Text('One-line with both widgets'),
                      trailing: Icon(Icons.more_vert),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => viewDetails(context),
            child: Container(
              margin: EdgeInsets.only(right: 8.0),
              width: 250.0,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 150.00,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTro7Yy91CzFVEglLCaTs7hf3cN38kuFu2duxDx1hKvoEI2UQEE',
                            ),
                            fit: BoxFit.fill)),
                  ),
                  Container(
                    color: Theme.of(context).cardColor,
                    child: ListTile(
                      title: Text('One-line with both widgets'),
                      trailing: Icon(Icons.more_vert),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => viewDetails(context),
            child: Container(
              margin: EdgeInsets.only(right: 8.0),
              width: 250.0,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 150.00,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTro7Yy91CzFVEglLCaTs7hf3cN38kuFu2duxDx1hKvoEI2UQEE',
                            ),
                            fit: BoxFit.fill)),
                  ),
                  Container(
                    color: Theme.of(context).cardColor,
                    child: ListTile(
                      title: Text('One-line with both widgets'),
                      trailing: Icon(Icons.more_vert),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => viewDetails(context),
            child: Container(
              margin: EdgeInsets.only(right: 8.0),
              width: 250.0,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 150.00,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTro7Yy91CzFVEglLCaTs7hf3cN38kuFu2duxDx1hKvoEI2UQEE',
                            ),
                            fit: BoxFit.fill)),
                  ),
                  Container(
                    color: Theme.of(context).cardColor,
                    child: ListTile(
                      title: Text('One-line with both widgets'),
                      trailing: Icon(Icons.more_vert),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

viewDetails(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => VideoDetailsPage()));
