import 'package:flutter_crud/app/core/rest_client/rest_client.dart';
import 'package:flutter_crud/app/core/utilities/backend_endpoints_definition.dart';
import 'package:flutter_crud/app/models/client_model.dart';

class ClientRepository {
  ClientRepository({
    required RestClient restClient
  }) : _restClient = restClient;

  final RestClient _restClient;

  Future<List<ClientModel>> loadClients(bool isEncrypt) async {
    final getClients = await _restClient.get(
      BackendEndpointsDefinition.clients,
      queryParameters: {
        'isEncrypt': isEncrypt,
      }
    );

    return (getClients.data as List).map((e) => ClientModel.fromMap(e)).toList();
  }  

  Future<void> deleteClient(String id) async {
    await _restClient.delete(
      '${BackendEndpointsDefinition.clients}/$id'
    );
  }  

  Future<void> updateClient(ClientModel client) async {
    await _restClient.put(
      '${BackendEndpointsDefinition.clients}/${client.id}',
      data: client.toMap(),
    );
  }

  Future<void> createClient(ClientModel client) async {
    await _restClient.post(
      BackendEndpointsDefinition.clients,
      data: client.toMap(),
    );
  }
}