import 'dart:convert';
import 'dart:io';

import 'package:my_app_api_client/my_app_api_client.dart';
import 'package:my_app_api_client/src/src/my_app_inner_api_client.dart';

import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockMyAppInnerApiClient extends Mock implements MyAppInnerApiClient {}

void main() {
  group('MyAppApi', () {
    late MyAppInnerApiClient innerApiClient;
    late MyAppApiClient apiClient;
    const baseUrl = 'http://127.0.0.1';

    setUpAll(() {
      registerFallbackValue(Request('GET', Uri()));
    });

    setUp(() {
      innerApiClient = _MockMyAppInnerApiClient();
      apiClient = MyAppApiClient(
        httpClient: innerApiClient,
        baseUrl: baseUrl,
      );
    });

    test('can be instantiated', () {
      expect(apiClient, isNotNull);
    });
  });
}
