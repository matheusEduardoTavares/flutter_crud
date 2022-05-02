import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_crud/app/core/utilities/modules_definition.dart';
import 'package:flutter_crud/app/core/widgets/dialogs/confirm_dialog.dart';
import 'package:flutter_crud/app/models/user_model.dart';
import 'package:flutter_crud/app/modules/users/users_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UserViewmodel {
  UserViewmodel({
    required UserRepository repository
  }) : _repository = repository;

  final UserRepository _repository;

  // final _productsController = StreamController<List<ProductModel>>();
  // Stream<List<ProductModel>> get productsOut => _productsController.stream;
  // Sink<List<ProductModel>> get productsIn => _productsController.sink;

  // final _clientsController = StreamController<List<ClientModel>>();
  // Stream<List<ClientModel>> get clientsOut => _clientsController.stream;
  // Sink<List<ClientModel>> get clientsIn => _clientsController.sink;

  final _userLoadingController = StreamController<bool>();
  Stream<bool> get isLoadingOut => _userLoadingController.stream;
  Sink<bool> get isLoadingIn => _userLoadingController.sink;

  final _usersController = StreamController<List<UserModel>>();
  Stream<List<UserModel>> get usersOut => _usersController.stream;
  Sink<List<UserModel>> get usersIn => _usersController.sink;

  void orderUser(String key, bool isAscending, List<Map<String, dynamic>> users) {
    final ordenedUsers = _oderEntity(key, isAscending, users);

    usersIn.add(ordenedUsers.map((e) => UserModel.fromMap(e)).toList());
  }

  Future<void> updateEntity(Map<String, dynamic> data, BuildContext context) {
    return _upsertEntity(data, context, (userModel) async {
      await _repository.updateUser(userModel);
    });
  }

  Future<void> createEntity(BuildContext context) {
    return _upsertEntity(
      {}, 
      context, 
      (userModel) async {
        await _repository.createUser(userModel);
      },
      title: 'Criar'
    );
  }

  Future<void> _upsertEntity(
    Map<String, dynamic> data, 
    BuildContext context, 
    Future<void> Function(UserModel userModel) upsert, {
      String? title,
    }
  ) async {
    final newData = await Modular.to.pushNamed<Map<String, dynamic>>(
      '/user${ModulesDefinition.upsertUser}',
      arguments: {
        'user': data,
        'title': title,
      },
    );

    if (newData != null) {
      _userLoadingController.add(true);

      await upsert(UserModel.fromMap(newData));

      await loadData();

      _userLoadingController.add(false);
    }
  }

  Future<void> deleteEntity(int id, BuildContext context) async {
    final isDelete = await showDialog<bool>(
      context: context, 
      builder: (_) => const ConfirmDialog(),
    );

    if (isDelete != null && isDelete) {
      _userLoadingController.add(true);

      await _repository.deleteUser(id);

      await loadData();

      _userLoadingController.add(false);
    }
  }

  List<Map<String, dynamic>> _oderEntity(String key, bool isAscending, List<Map<String, dynamic>> data) {
    var newList = List<Map<String, dynamic>>.from(data);
    newList.sort((a, b) {
      return a[key].compareTo(b[key]);
    });

    if (!isAscending) {
      newList = newList.reversed.toList();
    }

    return newList;
  }

  Future<void> loadData() async {
    _userLoadingController.add(true);

    final users = await _repository.loadUsers();
    usersIn.add(users);

    _userLoadingController.add(false);
  }
}