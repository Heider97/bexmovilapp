import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

//responses
import 'package:bexmovil/src/domain/models/responses/login_response.dart';

import '../data/api_service.dart';
import '../utils/errors.dart';
import '../utils/test_helper.dart';

class MockHttp extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('Service', () {
    late TestApiService apiService;
    late MockHttp httpClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttp();
      apiService = TestApiService(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not required a httpClient', () {
        expect(TestApiService(), isNotNull);
      });
    });

    group(('loginSearch'), () {
      test(
          'make correct http request with empty response,'
              ' throw [ErrorEmptyResponse]', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await apiService.login(null);
          fail('should throw error empty body');
        } catch (error) {
          expect(
            error,
            isA<ErrorEmptyResponse>(),
          );
        }
        verify(
              () => httpClient.get(
            Uri.parse(
                'https://api.thecatapi.com/v1/images/search?has_breeds=true'),
          ),
        ).called(1);
      });

      test('throws ResultError on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          apiService.login(null),
          throwsA(
            isA<ErrorLogin>(),
          ),
        );
      });

      test('return Cat.json on a valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(TestHelper.loginJsonResponse);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        await apiService.login(null);
        expect(
          LoginResponse.fromMap(jsonDecode(response.body)[0]),
          isA<LoginResponse>(),
        );
      });
    });
  });
}