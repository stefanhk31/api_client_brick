/// {@template my_app_api_client_failure}
/// An exception thrown when an api request failure occurs.
/// {@endtemplate}
class MyAppApiClientFailure implements Exception {
  /// {@macro my_app_api_client_failure}
  const MyAppApiClientFailure({
    required this.statusCode,
    required this.error,
  });

  /// The HTTP status code of this failure.
  final int statusCode;

  /// The error that caused this failure.
  final Object error;

  /// The response body of this failure.
  Map<String, dynamic> get body => {
        'error': error,
      };
}
