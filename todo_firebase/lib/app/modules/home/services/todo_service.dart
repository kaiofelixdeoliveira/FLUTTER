import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_firebase/app/modules/home/models/todo_model.dart';
import 'package:todo_firebase/app/modules/home/repositories/interface/todo_interface.dart';
import 'package:todo_firebase/app/modules/home/services/interface/todo_interface.dart';

class TodoService extends Disposable implements ITodoService {


  final ITodoRepository todoRepository;
  TodoService({@required this.todoRepository});

  @override
  Future delete(TodoModel model) {
    return todoRepository.delete(model);
  }

  @override
  Stream<List<TodoModel>> get() {
    print("bateu");
    return todoRepository.get();
  }

  @override
  Future save(TodoModel model) {
    return todoRepository.save(model);
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
