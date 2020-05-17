import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

abstract class DateCustom {
  final String dateModification;
  final String dateCreate =
      DateFormat('dd-MM-y HH:mm:ss').format(DateTime.now());
  DateCustom({
    @required this.dateModification
  });
}
