import 'package:flutter/material.dart';
import 'package:todo_stream_video/src/pages/explore/explore.dart';
import 'package:todo_stream_video/src/pages/home/home.dart';
import 'package:todo_stream_video/src/pages/login/login.dart';
import 'package:todo_stream_video/src/pages/profile/profile.dart';
import 'package:todo_stream_video/src/pages/upload/upload.dart';
import 'package:todo_stream_video/src/pages/video_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(title: 'Home'),
    UploadPage(),
    ProfilePage(),
    ExplorePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'VIMEO APP',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.amber[800],
          accentColor: Colors.amber[800],
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        home: Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cloud_upload),
                title: Text('Upload'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle),
                title: Text('Profile'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                title: Text('Explore'),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        ));
  }
}
