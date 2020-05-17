import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_sqlite/app/modules/home/models/dog_model.dart';
import 'package:todo_sqlite/app/modules/home/repositories/interfaces/dog_interface.dart';
import 'package:todo_sqlite/app/modules/home/services/interfaces/dog_interface.dart';

class DogService extends Disposable implements IDogService {
  final IDogRepository dogRepository;
  DogService({@required this.dogRepository});

  Future<List<DogModel>> queryAllRows() async {
    return await dogRepository.queryAllRows();
  }

  Future<int> insert(DogModel row) async {
    final id = await dogRepository.insert(row);
    print('linha inserida id: $id');
    return id;
  }

  Future<DogModel> findById(id) async {
    return await dogRepository.findById(id);
  }

  Future<int> update(DogModel row) async {
    final linesChanges = await dogRepository.update(row);
    print('atualizadas $linesChanges linha(s)');
    return linesChanges;
  }

  Future<int> delete(id) async {
    final lineDelete = await dogRepository.delete(id);
    print(lineDelete);
    return lineDelete;
  }

  Future<int> queryRowCount() async {
    return await dogRepository.queryRowCount();
  }

  @override
  void dispose() {}
}
