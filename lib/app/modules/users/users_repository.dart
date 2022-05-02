import 'package:flutter_crud/app/core/rest_client/rest_client.dart';
import 'package:flutter_crud/app/core/utilities/backend_endpoints_definition.dart';
import 'package:flutter_crud/app/models/user_model.dart';

class UserRepository {
  UserRepository({
    required RestClient restClient
  }) : _restClient = restClient;

  final RestClient _restClient;

  Future<List<UserModel>> loadUsers(bool isEncrypt) async {
    final getUsers = await _restClient.get(
      BackendEndpointsDefinition.users,
      queryParameters: {
        'isEncrypt': isEncrypt,
      }
    );

    return (getUsers.data as List).map((e) => UserModel.fromMap(e)).toList();
  }  

  Future<void> deleteUser(String id) async {
    await _restClient.delete(
      '${BackendEndpointsDefinition.users}/$id'
    );
  }  

  Future<void> updateUser(UserModel user) async {
    await _restClient.put(
      '${BackendEndpointsDefinition.users}/${user.id}',
      data: user.toMap(),
    );
  }

  Future<void> createUser(UserModel user) async {
    await _restClient.post(
      BackendEndpointsDefinition.users,
      data: user.toMap(),
    );
  }
}