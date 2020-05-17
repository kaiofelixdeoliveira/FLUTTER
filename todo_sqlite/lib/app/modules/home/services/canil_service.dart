import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_sqlite/app/modules/home/models/canil_model.dart';
import 'package:todo_sqlite/app/modules/home/repositories/interfaces/canil_interface.dart';

import 'interfaces/canil_interface.dart';

class CanilService extends Disposable implements ICanilService {
  final ICanilRepository canilRepository;
  CanilService({@required this.canilRepository});

  Future<List<CanilModel>> queryAllRows() async {
    return await canilRepository.queryAllRows();
  }

  Future<int> insert(CanilModel row) async {
    final id = await canilRepository.insert(row);
    print('linha inserida id: $id');
    return id;
  }

  Future<CanilModel> findById(id) async {
    return await canilRepository.findById(id);
  }

  Future<int> update(CanilModel row) async {
    final linesChanges = await canilRepository.update(row);
    print('atualizadas $linesChanges linha(s)');
    return linesChanges;
  }

  Future<int> delete(id) async {
    final lineDelete = await canilRepository.delete(id);
    print(lineDelete);
    return lineDelete;
  }

  Future<int> queryRowCount() async {
    return await canilRepository.queryRowCount();
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
