import 'package:flutter_crud/app/core/rest_client/rest_client.dart';
import 'package:flutter_crud/app/core/utilities/backend_endpoints_definition.dart';
import 'package:flutter_crud/app/models/login_model.dart';
import 'package:flutter_crud/app/models/user_model.dart';

class LoginRepository {
  LoginRepository({
    required RestClient restClient
  }) : _restClient = restClient;

  final RestClient _restClient;

  Future<UserModel> doLogin(LoginModel loginModel) async {
    final response = await _restClient.unauth().post(
      BackendEndpointsDefinition.login,
      data: loginModel.toJson(),
    );

    return UserModel.fromJson(response.data);
  }  
}