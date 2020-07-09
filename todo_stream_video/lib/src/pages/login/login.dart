import 'package:flutter/material.dart';
import 'package:todo_stream_video/src/widgets/clipath.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.cloud_upload,
          size: 70,
          color: Colors.white,
        ),
        MaterialButton(
          onPressed: () {},
          color: Theme.of(context).primaryColor,
          child: Text("CONTINUE WITH FACEBOOK"),
        ),
        MaterialButton(
          onPressed: () {},
          color: Colors.blue,
          child: Text("CONTINUE WITH GOOGLE"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Checkbox(
              value: true,
              activeColor: Colors.white,
              checkColor: Colors.black,
              onChanged: (bool ckeck) {},
            ),
            Text("I AGREE TERMS USE"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Have an account?  "),
            Text(
              "Log in",
              style: TextStyle(fontSize: 15, color: Colors.blueAccent),
            )
          ],
        )
      ],
    );
  }
}
