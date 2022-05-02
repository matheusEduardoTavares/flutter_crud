import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_crud/app/core/utilities/modules_definition.dart';
import 'package:flutter_crud/app/core/widgets/dialogs/confirm_dialog.dart';
import 'package:flutter_crud/app/models/client_model.dart';
import 'package:flutter_crud/app/modules/clients/client_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ClientViewmodel {
  ClientViewmodel({
    required ClientRepository repository
  }) : _repository = repository;

  final ClientRepository _repository;

  var isEncrypt = false;

  final _clientsController = StreamController<List<ClientModel>>();
  Stream<List<ClientModel>> get clientsOut => _clientsController.stream;
  Sink<List<ClientModel>> get clientsIn => _clientsController.sink;

  void orderClient(String key, bool isAscending, List<Map<String, dynamic>> clients) {
    final ordenedClients = _oderEntity(key, isAscending, clients);

    clientsIn.add(ordenedClients.map((e) => ClientModel.fromMap(e)).toList());
  }

  Future<void> updateEntity(Map<String, dynamic> data, BuildContext context) {
    return _upsertEntity(data, context, (clientModel) async {
      await _repository.updateClient(clientModel);
    });
  }

  Future<void> createEntity(BuildContext context) {
    return _upsertEntity(
      {}, 
      context, 
      (clientModel) async {
        await _repository.createClient(clientModel);
      },
      title: 'Criar'
    );
  }

  Future<void> _upsertEntity(
    Map<String, dynamic> data, 
    BuildContext context, 
    Future<void> Function(ClientModel clientModel) upsert, {
      String? title,
    }
  ) async {
    final newData = await Modular.to.pushNamed<Map<String, dynamic>>(
      '${ModulesDefinition.clients}${ModulesDefinition.upsertClient}',
      arguments: {
        'client': data,
        'title': title,
      },
    );

    if (newData != null) {
      await upsert(ClientModel.fromMap(newData));

      await loadData();
    }
  }

  Future<void> deleteEntity(String id, BuildContext context) async {
    final isDelete = await showDialog<bool>(
      context: context, 
      builder: (_) => const ConfirmDialog(
        entity: 'cliente',
      ),
    );

    if (isDelete != null && isDelete) {
      await _repository.deleteClient(id);

      await loadData();
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
    final clients = await _repository.loadClients(
      isEncrypt,
    );
    
    clientsIn.add(clients);
  }
}