// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:io';

import 'package:{{class_name.snakeCase()}}_api_client/{{class_name.snakeCase()}}_api_client.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockHttpClient extends Mock implements Client {}

class _MockRequest extends Mock implements Request {}

void main() {
  group('{{class_name.pascalCase()}}ApiClient', () {
    late Client httpClient;
    late Request request;
    late {{class_name.pascalCase()}}InnerApiClient innerApiClient;

    setUpAll(() {
      registerFallbackValue(Request('GET', Uri()));
    });

    setUp(
      () {
        httpClient = _MockHttpClient();
        innerApiClient = {{class_name.pascalCase()}}InnerApiClient(
          httpClient: httpClient,
        );

        when(() => httpClient.send(any())).thenAnswer(
          (_) async => StreamedResponse(
            Stream.value(utf8.encode('')),
            HttpStatus.ok,
          ),
        );
        request = _MockRequest();
        when(() => request.headers).thenReturn({});
      },
    );

    test('can be instantiated', () {
      expect(
        {{class_name.pascalCase()}}InnerApiClient,
        isNotNull,
      );
    });

    group('send', () {
      test('adds content type, accept, and authorization headers', () async {
        await innerApiClient.send(request);
        expect(
          request.headers,
          equals(
            {
              HttpHeaders.contentTypeHeader: ContentType.{{content_type}}.value,
              HttpHeaders.acceptHeader: ContentType.{{content_type}}.value,
              // TODO: supply authorization credentials
              HttpHeaders.authorizationHeader: '{{authorization.pascalCase()}} xxxxxx'
            },
          ),
        );
      });
    });

    group('close', () {
      test('closes inner client on close', () {
        when(() => httpClient.close()).thenAnswer((_) {});
        innerApiClient.close();
        verify(() => httpClient.close()).called(1);
      });
    });
  });
}
