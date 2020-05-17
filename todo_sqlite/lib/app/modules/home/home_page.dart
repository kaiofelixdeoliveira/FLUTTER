import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_sqlite/app/modules/home/models/dog_model.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  void initState() {
    super.initState();
    //controller.getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _modalAdd,
          child: Icon(Icons.add),
        ),
        body: FutureBuilder<List<DogModel>>(
          future: controller.getList(),
          builder: (BuildContext context, snapshot) {
            Widget child;

            if (snapshot.hasData) {
              child = ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Center(
                      child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(snapshot.data[index].name),
                        subtitle:
                            Text(snapshot.data[index].dateCreate.toString()),
                        trailing: Wrap(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () => setState(() {
                                controller.delete(snapshot.data[index].id);
                              }),
                            ),
                             IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.deepPurple,
                              ),
                              onPressed: () => 
                                _modalUpdate(model:snapshot.data[index])
                              ,
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  ));
                },
              );
            } else if (snapshot.hasError) {
              child = Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              );
            } else {
              child = Center(child: CircularProgressIndicator());
            }
            return Container(
              child: child,
            );
          },
        ));
  }

  _modalAdd({DogModel model}) {
    model ??= DogModel(name: null);
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Adicionar'),
            content: TextFormField(
              initialValue: model.name,
              onChanged: (v) => model = DogModel(name: v),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'escreva...',
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Modular.to.pop();
                },
                child: Text('Cancelar'),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    controller.save(model);
                  });

                  Modular.to.pop();
                },
                child: Text('Adicionar'),
              ),
            ],
          );
        }); 
  }
  _modalUpdate({DogModel model}) {
    
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Alterar"),
            content: TextFormField(
              initialValue: model.name,
              onChanged: (v) => model = DogModel(name: v, id:model.id),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'escreva...',
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Modular.to.pop();
                },
                child: Text('Cancelar'),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    controller.update(model);
                  });

                  Modular.to.pop();
                },
                child: Text('Alterar'),
              ),
            ],
          );
        }); 
  }
}
