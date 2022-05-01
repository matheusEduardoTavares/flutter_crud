import 'package:flutter_crud/app/core/utilities/modules_definition.dart';
import 'package:flutter_crud/app/modules/auth/auth_page.dart';
import 'package:flutter_crud/app/modules/auth/auth_viewmodel.dart';
import 'package:flutter_crud/app/modules/home/home_module.dart';
import 'package:flutter_crud/app/modules/login/login_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
   @override
   final List<Bind> binds = [
     Bind.lazySingleton((i) => AuthViewmodel(localStorage: i())),
   ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute, 
      child: (_, args) => AuthPage(
        viewmodel: Modular.get()
          ..execute(),
      )
    ),
    ModuleRoute(
      ModulesDefinition.login, 
      module: LoginModule(),
    ),
    ModuleRoute(
      ModulesDefinition.home, 
      module: HomeModule(),
    ),
  ];
}