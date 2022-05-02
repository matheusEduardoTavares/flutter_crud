import 'package:flutter_crud/app/core/utilities/modules_definition.dart';
import 'package:flutter_crud/app/modules/clients/client_page.dart';
import 'package:flutter_crud/app/modules/clients/client_repository.dart';
import 'package:flutter_crud/app/modules/clients/client_viewmodel.dart';
import 'package:flutter_crud/app/modules/clients/upsert_client/upsert_client_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ClientModule extends Module {

   @override
   final List<Bind> binds = [
     Bind.lazySingleton((i) => ClientRepository(restClient: i())),
     Bind.lazySingleton((i) => ClientViewmodel(
       repository: i(),
      ))
   ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute, 
      child: (_, args) => ClientPage(
        viewmodel: Modular.get(),
      )
    ),
    ChildRoute(
      ModulesDefinition.upsertClient, 
      child: (_, args) => UpsertClientPage(
        clientData: args.data['client'],
        title: args.data['title'],
      )
    ),
  ];

}