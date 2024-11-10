/// {@template my_app_api_client_malformed_response}
/// An exception thrown when a malformed response is received from the api.
/// {@endtemplate}
class MyAppApiClientMalformedResponse implements Exception {
  /// {@macro my_app_api_client_malformed_response}
  const MyAppApiClientMalformedResponse({
    required this.error,
  });

  /// The error related to the malformed response.
  final Object error;
}
