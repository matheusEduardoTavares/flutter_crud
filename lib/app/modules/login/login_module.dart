import 'package:flutter_crud/app/modules/login/login_page.dart';
import 'package:flutter_crud/app/modules/login/login_repository.dart';
import 'package:flutter_crud/app/modules/login/login_viewmodel.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginRepository(restClient: i())),
    Bind.lazySingleton((i) => LoginViewmodel(
      repository: i(), 
      localStorage: i(),
    ))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute, 
      child: (_, args) => LoginPage(
        viewmodel: Modular.get(),
      )
    )
  ];
}