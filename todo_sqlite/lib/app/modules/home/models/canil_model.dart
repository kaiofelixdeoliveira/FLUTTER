import 'package:flutter/foundation.dart';
import 'package:todo_sqlite/app/modules/home/models/dates_model.dart';

class CanilModel extends DateCustom {
  final int id;
  final String name;

  CanilModel({
    this.id,
    @required this.name,
    dateModification,
  }) : super(dateModification: dateModification);

  factory CanilModel.fromMap(Map<String, dynamic> map) {
    return CanilModel(
        id: map['id'],
        name: map['name'],
        dateModification: map['date_modification']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'date_modification': dateModification};
  }

  @override
  String toString() {
    return 'CanilModel{id: $id, name: $name, date_modification: $dateModification,date_create: $dateCreate}';
  }
}