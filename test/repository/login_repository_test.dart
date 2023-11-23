import 'package:bexmovil/src/domain/models/responses/login_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

//repositories
import 'package:bexmovil/src/data/datasources/remote/api_service.dart';

//domain

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;

  Response<dynamic> response;

  group('Login', () {
    const baseUrl = 'https://pandapan.bexmovil.com/api';

    const userCredentials = <String, dynamic>{
      'email': '000',
      'password': '000',
    };

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: baseUrl));
      dioAdapter = DioAdapter(
        dio: dio,
        matcher: const FullHttpRequestMatcher(),
      );
    });

    group(('login'), () {
      test('good response on 200 response callback', () async {
        const route = '/auth/login';

        dioAdapter.onPost(
          route,
          (server) => server.reply(
            200,
            null,
            // Reply would wait for one-sec before returning data.
            delay: const Duration(seconds: 1),
          ),
          data: userCredentials,
        );

        response = await dio.post(route, data: userCredentials);

        expect(response.statusCode, 200);
      });

      test('throws ResultError on non-200 response', () async {
        const signInRoute = '/auth/login';
        const accountRoute = '/account';

        const accessToken = <String, dynamic>{
          'token': 'ACCESS_TOKEN',
        };

        final headers = <String, dynamic>{
          'Authentication': 'Bearer $accessToken',
        };

        const userInformation = <String, dynamic>{
          'id': 1,
          'email': 'test@example.com',
          'password': 'password',
          'email_verified': false,
        };

        dioAdapter
          ..onPost(
            signInRoute,
            (server) => server.throws(
              401,
              DioException(
                requestOptions: RequestOptions(
                  path: signInRoute,
                ),
              ),
            ),
          )
          ..onPost(
            signInRoute,
            (server) => server.reply(200, accessToken),
            data: userCredentials,
          )
          ..onGet(
            accountRoute,
            (server) => server.reply(200, userInformation),
            headers: headers,
          );

        // Throws without user credentials.
        expect(
          () async => await dio.post(signInRoute),
          throwsA(isA<DioException>()),
        );

        // Returns an access token if user credentials are provided.
        response = await dio.post(signInRoute, data: userCredentials);

        expect(response.data, accessToken);

        // Returns user information if an access token is provided in headers.
        response = await dio.get(
          accountRoute,
          options: Options(headers: headers),
        );

        expect(response.data, userInformation);
      });
    });
  });
}
