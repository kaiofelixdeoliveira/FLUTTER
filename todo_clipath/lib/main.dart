import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ClipPath',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

double _height;
double _width;
bool _resized = false;

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final avaliableHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    if (!_resized) {
      _width = MediaQuery.of(context).size.width;
      _height = avaliableHeight * 0.5;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo CliPath"),
      ),
      body: Container(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            AnimatedSize(
              curve: Curves.bounceInOut,
              child: GestureDetector(
                onVerticalDragStart: (details) {
                  setState(() {
                    _resized = true;
                  });
                },
                onVerticalDragEnd: (details) {
                  setState(() {
                    _resized = false;
                    _height = avaliableHeight * 0.5;
                  });
                },
                onVerticalDragUpdate: (details) {
                  var position = details.localPosition.dy;

                  setState(() {
                    if (_resized) {
                      _height = position;
                    }
                  });
                },
                child: Container(
                  width: _width,
                  height: _height,
                  child: ClipPath(
                    clipper: CustomClipPath(),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Colors.green,
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              duration: Duration(seconds: 1),
              vsync: this,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(
                  Icons.account_balance,
                ),
                Icon(
                  Icons.access_alarms,
                ),
                Icon(
                  Icons.home,
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height - 45, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
