import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:{{class_name.snakeCase()}}_api_client/src/src/exceptions/exceptions.dart';
import 'package:{{class_name.snakeCase()}}_api_client/src/src/{{class_name.snakeCase()}}_inner_api_client.dart';
import 'package:http/http.dart';

/// Generic type representing a JSON factory.
typedef FromJson<T> = T Function(Map<String, dynamic> json);


/// {@template {{class_name.snakeCase()}}_api_client}
/// An API used for interacting with the {{class_name}} backend.
/// {@endtemplate}
class {{class_name.pascalCase()}}ApiClient {
  /// {@macro {{class_name.snakeCase()}}_api_client}
  {{class_name.pascalCase()}}ApiClient({required Client httpClient, required String baseUrl})
      : _client = {{class_name.pascalCase()}}InnerApiClient(httpClient: httpClient),
        _baseUrl = baseUrl;

  final {{class_name.pascalCase()}}InnerApiClient _client;
  final String _baseUrl;

  Future<T> _sendRequest<T>({
    required Uri uri,
    required FromJson<T> fromJson,
    String method = 'GET',
  }) async {
    try {
      final request = Request(method.toUpperCase(), uri);

      final responseStream = await _client.send(request);
      final response = await Response.fromStream(responseStream);
      final responseBody = response.json;

      if (response.statusCode >= 400) {
        throw {{class_name.pascalCase()}}ApiClientFailure(
          statusCode: response.statusCode,
          error: responseBody,
        );
      }

      return fromJson(responseBody);
    } on {{class_name.pascalCase()}}ApiClientMalformedResponse {
      rethrow;
    } on {{class_name.pascalCase()}}ApiClientFailure {
      rethrow;
    } catch (e) {
      throw {{class_name.pascalCase()}}ApiClientFailure(
        statusCode: HttpStatus.internalServerError,
        error: e,
      );
    }
  }
}

extension on Response {
  Map<String, dynamic> get json {
    try {
      final decodedBody = utf8.decode(bodyBytes);
      return jsonDecode(decodedBody) as Map<String, dynamic>;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        {{class_name.pascalCase()}}ApiClientMalformedResponse(error: error),
        stackTrace,
      );
    }
  }
}
