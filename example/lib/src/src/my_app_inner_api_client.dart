import 'dart:io';

import 'package:http/http.dart';

/// {@template my_app_inner_api_client}
/// An internal implementation of an HTTP client to interact with the MyApp API.
/// {@endtemplate}
class MyAppInnerApiClient extends BaseClient {
  /// {@macro my_app_inner_api_client}
  MyAppInnerApiClient({required Client httpClient}) : _httpClient = httpClient;

  final Client _httpClient;

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers.putIfAbsent(
      HttpHeaders.contentTypeHeader,
      () => ContentType.json.value,
    );
    request.headers.putIfAbsent(
      HttpHeaders.acceptHeader,
      () => ContentType.json.value,
    );
    request.headers.putIfAbsent(
      HttpHeaders.authorizationHeader,
      // TODO: supply authorization credentials
      () => 'Basic xxxxxx'
    );
    return _httpClient.send(request);
  }

  @override
  void close() {
    _httpClient.close();
    super.close();
  }
}
