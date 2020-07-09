import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/features/album/domain/usecases/createAlbum.dart';

import 'core/database/init_database.dart';
import 'features/album/data/repositories/album_repository_impl.dart';
import 'features/album/presentation/bloc/album_bloc.dart';
import './injection_container.dart' as di;
import 'features/album/data/models/album.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter BloC',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (BuildContext context) => di.sl<AlbumBloc>(),
          child: MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamSubscription<DataConnectionStatus> listener;
  var Internetstatus = "Unknown";

  @override
  void initState() {
    super.initState();
    CheckInternet();
    BlocProvider.of<AlbumBloc>(context).add(LoadingSucessAlbumEvent());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    listener.cancel();
    super.dispose();
  }

  CheckInternet() async {
    // Simple check to see if we have internet
    print("The statement 'this machine is connected to the Internet' is: ");
    print(await DataConnectionChecker().hasConnection);
    // returns a bool

    // We can also get an enum instead of a bool
    print("Current status: ${await DataConnectionChecker().connectionStatus}");
    // prints either DataConnectionStatus.connected
    // or DataConnectionStatus.disconnected

    // This returns the last results from the last call
    // to either hasConnection or connectionStatus
    print("Last results: ${DataConnectionChecker().lastTryResults}");

    // actively listen for status updates
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          Internetstatus = "Connectd TO THe Internet";
          print('Data connection is available.');
          setState(() {});
          break;
        case DataConnectionStatus.disconnected:
          Internetstatus = "No Data Connection";
          print('You are disconnected from the internet.');
          setState(() {});
          break;
      }
    });

    // close listener after 30 seconds, so the program doesn't run forever
//    await Future.delayed(Duration(seconds: 30));
//    await listener.cancel();
    return await DataConnectionChecker().connectionStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: BlocListener<AlbumBloc, AlbumState>(
          listener: (context, state) {
            if (state is ErrorState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: _blocBuilder(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        elevation: 10,
        onPressed: () => _modalAdd(context: context),
      ),
    );
  }

  _blocBuilder() {
    return BlocBuilder<AlbumBloc, AlbumState>(
      builder: (context, state) {
        if (state is InitialState) {
          return Center(
            child: Text("Initial"),
          );
        } else if (state is LoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LoadedSucessState) {
          return Column(
            children: <Widget>[
              Text("$Internetstatus", style: TextStyle(backgroundColor: Colors.black, color: Colors.white,fontSize: 20),),
              Text("Total Albums:${state.album.length}"),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.album.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Colors.blue,
                      ),
                      child: ListTile(
                        title: Text(state.album[index].title),
                        trailing: Wrap(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.deepPurple,
                              ),
                              onPressed: () => _modalUpdate(
                                album: state.album[index],
                                context: context,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onDismissed: (DismissDirection direction) {
                        BlocProvider.of<AlbumBloc>(context)
                            .add(DeleteAlbumEvent(state.album[index]));

                        // Then show a snackbar.
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text("dismissed")));
                      },
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is ErrorState) {
          return Center(child: Text("Error"));
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'nothing data :(',
              ),
            ],
          ),
        );
      },
    );
  }
}

_modalAdd({BuildContext context}) {
  String _title;
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Adicionar'),
          content: Wrap(
            children: <Widget>[
              TextFormField(
                onChanged: (newTitle) => _title = newTitle,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'title...',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            FlatButton(
              onPressed: () {
                BlocProvider.of<AlbumBloc>(context)
                    .add(CreateAlbumEvent(AlbumModel(title: _title)));

                Navigator.pop(context);
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      });
}

_modalUpdate({AlbumModel album, BuildContext context}) {
  var _title = album.title;
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Alterar"),
          content: Wrap(
            children: <Widget>[
              TextFormField(
                initialValue: album.title,
                onChanged: (newTitle) => _title = newTitle,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'title',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            FlatButton(
              onPressed: () {
                BlocProvider.of<AlbumBloc>(context)
                    .add(UpdateAlbumEvent(AlbumModel(
                  title: _title,
                  id: album.id,
                  userId: album.userId,
                )));
                Navigator.pop(context);
              },
              child: Text('Alterar'),
            ),
          ],
        );
      });
}
