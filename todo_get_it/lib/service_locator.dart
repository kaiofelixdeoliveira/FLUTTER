

import 'package:get_it/get_it.dart';
import 'package:todo_get_it/produto.dart';

GetIt servicelocator;
 void setupLocator() {
   servicelocator.registerFactory(() => Produto());
     //a definir    
}