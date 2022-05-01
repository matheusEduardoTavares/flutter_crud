import 'dart:async';

import 'package:flutter_crud/app/core/local_storage/local_storage.dart';
import 'package:flutter_crud/app/core/local_storage/local_storage_keys.dart';
import 'package:flutter_crud/app/models/login_model.dart';
import 'package:flutter_crud/app/modules/login/login_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginViewmodel {
  LoginViewmodel({
    required LoginRepository repository,
    required LocalStorage localStorage,
  }) : _repository = repository, _localStorage = localStorage;

  final LoginRepository _repository;
  final LocalStorage _localStorage;

  final _loginController = StreamController<bool>();
  Stream<bool> get isLoadingOut => _loginController.stream;
  Sink<bool> get isLoadingIn => _loginController.sink;
  
  Future<void> doLogin(Map<String, dynamic> data) async {
    try {
      isLoadingIn.add(true);
      
      final loginModel = LoginModel.fromMap(data);
      final userData = await _repository.doLogin(loginModel);
      await _localStorage.write<String>(LocalStorageKeys.isLogged, userData.toJson());
      
      Modular.to.navigate(Modular.initialRoute);
    } 
    catch (e) {
      print(e);
    }
    finally {
      isLoadingIn.add(false);
    }
  }
}