// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:io';

import 'package:my_app_api_client/my_app_api_client.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockHttpClient extends Mock implements Client {}

class _MockRequest extends Mock implements Request {}

void main() {
  group('MyAppApiClient', () {
    late Client httpClient;
    late Request request;
    late MyAppInnerApiClient innerApiClient;

    setUpAll(() {
      registerFallbackValue(Request('GET', Uri()));
    });

    setUp(
      () {
        httpClient = _MockHttpClient();
        innerApiClient = MyAppInnerApiClient(
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
        MyAppInnerApiClient,
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
              HttpHeaders.contentTypeHeader: ContentType.json.value,
              HttpHeaders.acceptHeader: ContentType.json.value,
              // TODO: supply authorization credentials
              HttpHeaders.authorizationHeader: 'Basic xxxxxx'
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
