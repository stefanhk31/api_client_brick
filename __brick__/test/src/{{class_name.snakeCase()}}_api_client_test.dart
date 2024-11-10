import 'dart:convert';
import 'dart:io';

import 'package:{{class_name.snakeCase()}}_api_client/{{class_name.snakeCase()}}_api_client.dart';
import 'package:{{class_name.snakeCase()}}_api_client/src/src/{{class_name.snakeCase()}}_inner_api_client.dart';

import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _Mock{{class_name.pascalCase()}}InnerApiClient extends Mock implements {{class_name.pascalCase()}}InnerApiClient {}

void main() {
  group('{{class_name.pascalCase()}}Api', () {
    late {{class_name.pascalCase()}}InnerApiClient innerApiClient;
    late {{class_name.pascalCase()}}ApiClient apiClient;
    const baseUrl = 'http://127.0.0.1';

    setUpAll(() {
      registerFallbackValue(Request('GET', Uri()));
    });

    setUp(() {
      innerApiClient = _Mock{{class_name.pascalCase()}}InnerApiClient();
      apiClient = {{class_name.pascalCase()}}ApiClient(
        httpClient: innerApiClient,
        baseUrl: baseUrl,
      );
    });

    test('can be instantiated', () {
      expect(apiClient, isNotNull);
    });
  });
}
