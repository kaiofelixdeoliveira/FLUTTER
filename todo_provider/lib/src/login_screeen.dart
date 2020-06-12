import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/main.dart';

class LoginScreen1 extends StatefulWidget {
  final Color primaryColor;
  final Color backgroundColor;
  final AssetImage backgroundImage;

  LoginScreen1(
      {Key key, this.primaryColor, this.backgroundColor, this.backgroundImage});

  @override
  _LoginScreen1State createState() => _LoginScreen1State();
}

class _LoginScreen1State extends State<LoginScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
            child: Consumer<Counter>(
                builder: (context, counter, _) => Text('${counter.count}')),
          )),
      floatingActionButton: FloatingActionButton(
        /// Calls `context.read` instead of `context.watch` so that it does not rebuild
        /// when [Counter] changes.
        onPressed: () =>
            Provider.of<Counter>(context, listen: false).increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
