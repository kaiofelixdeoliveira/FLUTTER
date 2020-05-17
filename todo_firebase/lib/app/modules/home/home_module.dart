import 'package:todo_firebase/app/modules/home/repositories/interface/todo_interface.dart';
import 'package:todo_firebase/app/modules/home/services/interface/todo_interface.dart';
import 'package:todo_firebase/app/modules/home/services/todo_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_firebase/app/modules/home/repositories/todo_repository.dart';
import 'package:todo_firebase/app/modules/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_firebase/app/modules/home/home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind<ITodoService>((i) => TodoService(todoRepository: i.get())),
        Bind<ITodoRepository>(
            (i) => TodoRepository(firestore: Firestore.instance)),
        Bind((i) => HomeController(todoService: i.get<ITodoService>())),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}