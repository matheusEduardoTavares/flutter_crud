import 'package:flutter_crud/app/core/utilities/modules_definition.dart';
import 'package:flutter_crud/app/modules/users/upsert_user/upsert_user_page.dart';
import 'package:flutter_crud/app/modules/users/users_page.dart';
import 'package:flutter_crud/app/modules/users/users_repository.dart';
import 'package:flutter_crud/app/modules/users/users_viewmodel.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UserModule extends Module {

   @override
   final List<Bind> binds = [
     Bind.lazySingleton((i) => UserRepository(restClient: i())),
     Bind.lazySingleton((i) => UserViewmodel(
       repository: i(),
      ))
   ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute, 
      child: (_, args) => UserPage(
        viewmodel: Modular.get(),
      )
    ),
    ChildRoute(
      ModulesDefinition.upsertUser, 
      child: (_, args) => UpsertUserPage(
        userData: args.data['user'],
        title: args.data['title'],
      )
    ),
  ];

}