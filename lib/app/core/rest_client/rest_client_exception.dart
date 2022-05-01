import 'package:flutter_crud/app/core/rest_client/rest_client_response.dart';

class RestClientException implements Exception {
  RestClientException({
    this.message,
    this.statusCode,
    required this.error,
    required this.response,
  });

  final String? message;
  final int? statusCode;
  final dynamic error;
  final RestClientResponse response;

  RestClientException copyWith({
    String? message,
    int? statusCode,
    dynamic error,
    RestClientResponse? response,
  }) {
    return RestClientException(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      error: error ?? this.error,
      response: response ?? this.response,
    );
  }
}
