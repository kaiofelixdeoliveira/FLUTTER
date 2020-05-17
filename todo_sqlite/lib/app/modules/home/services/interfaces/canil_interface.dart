
import 'package:todo_sqlite/app/modules/home/models/canil_model.dart';

abstract class ICanilService {
   Future<int> insert(CanilModel row);
  Future<List<CanilModel>> queryAllRows();
  Future<int> queryRowCount();
  Future<int> update(CanilModel row);
  Future<int> delete(id);
  Future<CanilModel> findById(id);
}