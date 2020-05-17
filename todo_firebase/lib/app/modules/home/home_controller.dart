import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_firebase/app/modules/home/models/todo_model.dart';
import 'package:todo_firebase/app/modules/home/services/interface/todo_interface.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final ITodoService todoService;

  @observable
  ObservableStream<List<TodoModel>> todoList;

  _HomeControllerBase({@required this.todoService}) {
    getList();
  }

  @action
  getList() {
    todoList = todoService.get().asObservable();
  }

  @action
  save(TodoModel model) {
    todoService.save(model);
  }

  @action
  delete(TodoModel model) {
    todoService.delete(model);
  }
}
