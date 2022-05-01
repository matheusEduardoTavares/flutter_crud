import 'package:flutter_crud/app/core/local_storage/local_storage.dart';
import 'package:flutter_crud/app/core/local_storage/shared_prefences_local_storage.dart';
import 'package:flutter_crud/app/core/rest_client/dio_rest_client.dart';
import 'package:flutter_crud/app/core/rest_client/rest_client.dart';
import 'package:flutter_crud/app/modules/auth/auth_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {

   @override
   final List<Bind> binds = [
     Bind.lazySingleton<LocalStorage>((i) => SharedPrefencesLocalStorage()),
     Bind.lazySingleton<RestClient>((i) => DioRestClient(
       localStorage: i(),
     )),
   ];

   @override
   final List<ModularRoute> routes = [
     ModuleRoute(
       Modular.initialRoute, 
       module: AuthModule(),
      )
   ];
}