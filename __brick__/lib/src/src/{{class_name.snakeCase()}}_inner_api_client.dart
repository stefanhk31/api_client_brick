import 'dart:io';

import 'package:http/http.dart';

/// {@template {{class_name.snakeCase()}}_inner_api_client}
/// An internal implementation of an HTTP client to interact with the {{class_name}} API.
/// {@endtemplate}
class {{class_name.pascalCase()}}InnerApiClient extends BaseClient {
  /// {@macro {{class_name.snakeCase()}}_inner_api_client}
  {{class_name.pascalCase()}}InnerApiClient({required Client httpClient}) : _httpClient = httpClient;

  final Client _httpClient;

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers.putIfAbsent(
      HttpHeaders.contentTypeHeader,
      () => ContentType.{{content_type}}.value,
    );
    request.headers.putIfAbsent(
      HttpHeaders.acceptHeader,
      () => ContentType.{{content_type}}.value,
    );
    request.headers.putIfAbsent(
      HttpHeaders.authorizationHeader,
      // TODO: supply authorization credentials
      () => '${{{authorization.pascalCase()}}} xxxxxx'
    );
    return _httpClient.send(request);
  }

  @override
  void close() {
    _httpClient.close();
    super.close();
  }
}
