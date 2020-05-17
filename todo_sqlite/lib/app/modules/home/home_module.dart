import 'package:todo_sqlite/app/modules/home/repositories/canil_repository.dart';
import 'package:todo_sqlite/app/modules/home/repositories/dog_repository.dart';
import 'package:todo_sqlite/app/modules/home/repositories/interfaces/canil_interface.dart';
import 'package:todo_sqlite/app/modules/home/repositories/interfaces/dog_interface.dart';
import 'package:todo_sqlite/app/modules/home/services/canil_service.dart';
import 'package:todo_sqlite/app/modules/home/services/dog_service.dart';
import 'package:todo_sqlite/app/modules/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_sqlite/app/modules/home/home_page.dart';
import 'package:todo_sqlite/app/modules/home/services/interfaces/canil_interface.dart';
import 'package:todo_sqlite/app/modules/home/services/interfaces/dog_interface.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind<ICanilRepository>((i) => CanilRepository()),
        Bind<IDogRepository>((i) => DogRepository()),
        Bind<ICanilService>((i) => CanilService(canilRepository: i.get())),
        Bind<IDogService>((i) => DogService(dogRepository: i.get())),
        Bind((i) => HomeController(dogService: i.get<IDogService>())),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
