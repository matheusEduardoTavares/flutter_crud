import 'package:flutter_crud/app/core/local_storage/local_storage.dart';
import 'package:flutter_crud/app/core/local_storage/local_storage_keys.dart';
import 'package:flutter_crud/app/core/utilities/modules_definition.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthViewmodel {
  AuthViewmodel({
    required LocalStorage localStorage,
  }) : _localStorage = localStorage;

  final LocalStorage _localStorage;

  Future<void> execute() async {
    final isLogged = await _localStorage.contains(LocalStorageKeys.isLogged);

    if (isLogged) {
      Modular.to.navigate(ModulesDefinition.home);
    }
    else {
      Modular.to.navigate(ModulesDefinition.login);
    }
  }
}