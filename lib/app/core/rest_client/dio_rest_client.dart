import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_crud/app/core/local_storage/local_storage.dart';
import 'package:flutter_crud/app/core/network_address.dart';
import 'package:flutter_crud/app/core/rest_client/interceptors/auth_interceptor.dart';
import 'package:flutter_crud/app/core/rest_client/rest_client.dart';
import 'package:flutter_crud/app/core/rest_client/rest_client_exception.dart';
import 'package:flutter_crud/app/core/rest_client/rest_client_response.dart';

class DioRestClient implements RestClient {
  DioRestClient({
    required LocalStorage localStorage,
    bool? useHttpsSecurityProtocol,
    BaseOptions? options,
  }) {
    _dio = Dio(options ?? _options);

    if (useHttpsSecurityProtocol ?? false) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return null;
      };
    }

    _dio.interceptors.addAll([
      AuthInterceptor(
        localStorage: localStorage,
      ),
    ]);
  }

  late Dio _dio;

  final _options = BaseOptions(
    baseUrl: NetworkAddress.url,
    contentType: 'application/json',
  );

  @override
  RestClient auth() {
    _options.extra['auth_required'] = true;
    return this;
  }

  @override
  RestClient unauth() {
    _options.extra['auth_required'] = false;
    return this;
  }

  @override
  Future<RestClientResponse<T>> post<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioError catch (e) {
      throw RestClientException(
        error: e.error,
        message: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        response: _dioErrorConverter(e.response),
      );
    }
  }

  @override
  Future<RestClientResponse<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioError catch (e) {
      throw RestClientException(
        error: e.error,
        message: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        response: _dioErrorConverter(e.response),
      );
    }
  }

  @override
  Future<RestClientResponse<T>> put<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioError catch (e) {
      throw RestClientException(
        error: e.error,
        message: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        response: _dioErrorConverter(e.response),
      );
    }
  }

  @override
  Future<RestClientResponse<T>> delete<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioError catch (e) {
      throw RestClientException(
        error: e.error,
        message: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        response: _dioErrorConverter(e.response),
      );
    }
  }

  @override
  Future<RestClientResponse<T>> patch<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioError catch (e) {
      throw RestClientException(
        error: e.error,
        message: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        response: _dioErrorConverter(e.response),
      );
    }
  }

  @override
  Future<RestClientResponse<T>> request<T>(String path,
      {required String method,
      data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? extra}) async {
    try {
      final response = await _dio.request<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          method: method,
          extra: extra,
        ),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioError catch (e) {
      throw RestClientException(
        error: e.error,
        message: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        response: _dioErrorConverter(e.response),
      );
    }
  }

  @override
  Future<RestClientResponse> download(String path,
      {required dynamic savePath,
      data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.download(
        path,
        savePath,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioError catch (e) {
      throw RestClientException(
        error: e.error,
        message: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        response: _dioErrorConverter(e.response),
      );
    }
  }

  RestClientResponse<T> _dioErrorConverter<T>(Response? response) {
    return RestClientResponse<T>(
      data: response?.data,
      statusCode: response?.statusCode,
      statusMessage: response?.statusMessage,
    );
  }
}
