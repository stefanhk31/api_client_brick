import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:my_app_api_client/src/src/exceptions/exceptions.dart';
import 'package:my_app_api_client/src/src/my_app_inner_api_client.dart';
import 'package:http/http.dart';

/// Generic type representing a JSON factory.
typedef FromJson<T> = T Function(Map<String, dynamic> json);


/// {@template my_app_api_client}
/// An API used for interacting with the MyApp backend.
/// {@endtemplate}
class MyAppApiClient {
  /// {@macro my_app_api_client}
  MyAppApiClient({required Client httpClient, required String baseUrl})
      : _client = MyAppInnerApiClient(httpClient: httpClient),
        _baseUrl = baseUrl;

  final MyAppInnerApiClient _client;
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
        throw MyAppApiClientFailure(
          statusCode: response.statusCode,
          error: responseBody,
        );
      }

      return fromJson(responseBody);
    } on MyAppApiClientMalformedResponse {
      rethrow;
    } on MyAppApiClientFailure {
      rethrow;
    } catch (e) {
      throw MyAppApiClientFailure(
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
        MyAppApiClientMalformedResponse(error: error),
        stackTrace,
      );
    }
  }
}
