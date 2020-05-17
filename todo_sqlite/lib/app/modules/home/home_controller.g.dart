// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$dogListAtom = Atom(name: '_HomeControllerBase.dogList');

  @override
  Future<List<DogModel>> get dogList {
    _$dogListAtom.context.enforceReadPolicy(_$dogListAtom);
    _$dogListAtom.reportObserved();
    return super.dogList;
  }

  @override
  set dogList(Future<List<DogModel>> value) {
    _$dogListAtom.context.conditionallyRunInAction(() {
      super.dogList = value;
      _$dogListAtom.reportChanged();
    }, _$dogListAtom, name: '${_$dogListAtom.name}_set');
  }

  final _$getListAsyncAction = AsyncAction('getList');

  @override
  Future<List<DogModel>> getList() {
    return _$getListAsyncAction.run(() => super.getList());
  }

  final _$saveAsyncAction = AsyncAction('save');

  @override
  Future save(DogModel model) {
    return _$saveAsyncAction.run(() => super.save(model));
  }

  final _$deleteAsyncAction = AsyncAction('delete');

  @override
  Future delete(int id) {
    return _$deleteAsyncAction.run(() => super.delete(id));
  }

  final _$updateAsyncAction = AsyncAction('update');

  @override
  Future update(DogModel model) {
    return _$updateAsyncAction.run(() => super.update(model));
  }

  @override
  String toString() {
    final string = 'dogList: ${dogList.toString()}';
    return '{$string}';
  }
}
