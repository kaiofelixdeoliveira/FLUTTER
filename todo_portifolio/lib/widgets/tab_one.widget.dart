import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_portifolio/widgets/animated_background.widget.dart';
import 'package:url_launcher/url_launcher.dart';

class TabOne extends StatelessWidget {
  tabOne() {
    return Stack(
      children: <Widget>[
        FancyBackgroundApp(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    children: <Widget>[
                      imageProfile(),
                      nameProfile(),
                      contact(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  contact() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      MaterialButton(
        onPressed: () => _launchURLBlog(),
        splashColor: Colors.white,
        color: Colors.black,
        textColor: Colors.white,
        child: FaIcon(
          FontAwesomeIcons.blog,
          size: 20,
          color: Colors.white,
        ),
        padding: EdgeInsets.all(16),
        shape: CircleBorder(),
      ),
      MaterialButton(
        splashColor: Colors.white,
        onPressed: () {},
        color: Colors.black,
        textColor: Colors.white,
        child: FaIcon(
          FontAwesomeIcons.linkedinIn,
          size: 20,
          color: Colors.white,
        ),
        padding: EdgeInsets.all(16),
        shape: CircleBorder(),
      ),
      MaterialButton(
        splashColor: Colors.white,
        onPressed: () => _launchURLGitHub(),
        color: Colors.black,
        textColor: Colors.white,
        child: FaIcon(
          FontAwesomeIcons.github,
          size: 20,
          color: Colors.white,
        ),
        padding: EdgeInsets.all(16),
        shape: CircleBorder(),
      ),
    ]);
  }

  imageProfile() {
    return Card(
      child: CircleAvatar(
          maxRadius: 80.0,
          backgroundImage: AssetImage("assets/images/profile.jpeg")),
      elevation: 20.0,
      shape: CircleBorder(),
      clipBehavior: Clip.antiAlias,
    );
  }

  nameProfile() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            "Olá meu nome é",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          Text(
            "Kaio Felix de Oliveira",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Divider(),
          Text(
            "Programador",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          Text(
            "Residente em São Paulo",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          Divider(),
          Row(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.heartbeat,
                size: 25,
                color: Colors.red,
              ),
              Text(
                " Código com ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              FaIcon(
                FontAwesomeIcons.coffee,
                size: 25,
                color: Colors.black87,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _launchURLGitHub() async {
    const url = 'https://github.com/kaiofelixdeoliveira';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLBlog() async {
    const url = 'https://medium.com/@kaiofelixdeoliveira';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return tabOne();
  }
}
