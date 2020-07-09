import 'package:flutter/material.dart';
import 'package:todo_stream_video/src/widgets/custom_list_item.dart';
import 'package:todo_stream_video/src/widgets/video.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final List<Map<String, dynamic>> _categoriesList = [
    {
      "color": Colors.redAccent,
      "name": "Music",
      "icon": Icon(Icons.music_video, size: 30)
    },
    {
      "color": Colors.yellowAccent,
      "name": "Animation",
      "icon": Icon(Icons.android, size: 30)
    },
    {
      "color": Colors.blueAccent,
      "name": "Experimental",
      "icon": Icon(Icons.explore, size: 30)
    },
    {
      "color": Colors.pinkAccent,
      "name": "Sports",
      "icon": Icon(Icons.shopping_cart, size: 30)
    },
    {
      "color": Colors.greenAccent,
      "name": "Comedy",
      "icon": Icon(Icons.chrome_reader_mode, size: 30)
    },
    {
      "color": Colors.amberAccent,
      "name": "Documentary",
      "icon": Icon(Icons.filter_b_and_w, size: 30)
    },
  ];

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Text("CATEGORIES",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start),
                Divider(),
                categories(context, _categoriesList),
                SizedBox(height: 10),
                Text("STAF PICKS",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start),
                Divider(),
                staffPicks(_width, _height)
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'searchExplore',
        onPressed: () {},
        child: Icon(
          Icons.search,
        ),
      ),
    );
  }
}

staffPicks(double width, double heigth) => Container(
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
          CustomListItem(
            subtitle: 'Three-line ListTile',
            thumbnail: Container(
              height: 100,
              decoration: const BoxDecoration(color: Colors.blue),
              child: VideoPlayerScreen(),
            ),
            title: 'The Flutter YouTube Channel',
          ),
          CustomListItem(
            subtitle: 'Three-line ListTile',
            thumbnail: Container(
              height: 100,
              decoration: const BoxDecoration(color: Colors.blue),
              child: VideoPlayerScreen(),
            ),
            title: 'The Flutter YouTube Channel',
          ),
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

categories(BuildContext context, List<Map<String, dynamic>> categories) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 120.0,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              return index < 3
                  ? Container(
                      margin: EdgeInsets.only(right: 8.0),
                      width: 120.0,
                      child: Column(
                        children: <Widget>[
                          Container(
                              height: 60.0,
                              decoration: BoxDecoration(
                                  color: categories[index]["color"]
                                      .withOpacity(0.8)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  categories[index]["icon"],
                                ],
                              )),
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            color: Theme.of(context).cardColor,
                            child: ListTile(
                                title: Text(
                              categories[index]["name"],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13),
                            )),
                          ),
                        ],
                      ),
                    )
                  : null;
            },
          ),
        ),
        Container(
          height: 120.0,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(right: 8.0),
                width: 120.0,
                child: Column(
                  children: <Widget>[
                    Container(
                        height: 60.0,
                        decoration: BoxDecoration(
                            color: categories[index]["color"].withOpacity(0.8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            categories[index]["icon"],
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      color: Theme.of(context).cardColor,
                      child: ListTile(
                          title: Text(
                        categories[index]["name"],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13),
                      )),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
