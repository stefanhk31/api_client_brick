/// {@template {{class_name.snakeCase()}}_api_client_malformed_response}
/// An exception thrown when a malformed response is received from the api.
/// {@endtemplate}
class {{class_name.pascalCase()}}ApiClientMalformedResponse implements Exception {
  /// {@macro {{class_name.snakeCase()}}_api_client_malformed_response}
  const {{class_name.pascalCase()}}ApiClientMalformedResponse({
    required this.error,
  });

  /// The error related to the malformed response.
  final Object error;
}
