import 'package:flutter/material.dart';
import 'package:todo_stream_video/src/widgets/custom_list_item.dart';
import 'package:todo_stream_video/src/widgets/video.dart';

class TabDetailsVideoWidget extends StatefulWidget {
  @override
  TabDetailsVideoWidgetState createState() => new TabDetailsVideoWidgetState();
}

class TabDetailsVideoWidgetState extends State<TabDetailsVideoWidget> {
  bool _isSwitched = true;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: Theme.of(context).cardColor,
              bottom: TabBar(
                tabs: [
                  Tab(
                      child: Text("UP NEXT",
                          style: TextStyle(color: Colors.white, fontSize: 12))),
                  Tab(
                      child: Text("7 COMMENTS",
                          style: TextStyle(color: Colors.white, fontSize: 12))),
                  Tab(
                      child: Text("8 LIKES",
                          style: TextStyle(color: Colors.white, fontSize: 12))),
                ],
              ),
            )),
        body: TabBarView(
          children: [
            recentVideos(_width, _height, context),
            comments(),
            likes()
          ],
        ),
      ),
    );
  }

  recentVideos(double width, double heigth, BuildContext context) => Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("MORE FROM FEED"),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        Text("AutoPlay"),
                        Switch(
                          onChanged: (val) => setState(() => _isSwitched = val),
                          value: true,
                          activeColor: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              ListView(
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
            ],
          ),
        ),
      );

  comments() => Container(
          child: ListView(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
            ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTro7Yy91CzFVEglLCaTs7hf3cN38kuFu2duxDx1hKvoEI2UQEE'),
                ),
                title: Text('Title'),
                subtitle: Text('This is Subtitle'),
                trailing: Text("REPLY")),
            Divider(),
            ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTro7Yy91CzFVEglLCaTs7hf3cN38kuFu2duxDx1hKvoEI2UQEE'),
                ),
                title: Text('Title'),
                subtitle: Text('This is Subtitle'),
                trailing: Text("REPLY"))
          ]));

  likes() => ListTile(
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
      );
}
