import 'package:dio/dio.dart';
import 'package:flutter_crud/app/core/local_storage/local_storage.dart';
import 'package:flutter_crud/app/core/local_storage/local_storage_keys.dart';
import 'package:flutter_crud/app/core/utilities/modules_definition.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required LocalStorage localStorage,
  }) : 
  _localStorage = localStorage;

  final LocalStorage _localStorage;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({
      'Content-Type': 'application/json',
    });

    if (options.extra['auth_required'] == true) {
      final accessToken = await _localStorage.read<String>(LocalStorageKeys.isLogged);

      if (accessToken == null) {
        return handler.reject(
          DioError(
            requestOptions: options,
            error: 'Expire Token',
            type: DioErrorType.cancel,
          )
        );
      }

      options.headers['Authorization'] = accessToken;
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.requestOptions.extra['auth_required'] == true) {
      final statusCode = err.response?.statusCode;
      if (statusCode == 403 || statusCode == 401) {
        return _loginExpire();
      }
    }

    return handler.next(err);
  }

  Future<void> _loginExpire() async {
    await _localStorage.clear();

    Modular.to.navigate(ModulesDefinition.login);
  }
}
