import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

//repositories
import 'package:bexmovil/src/data/datasources/remote/api_service.dart';

//domain

void main() {
  final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
  final dioAdapter = DioAdapter(
    dio: dio,
    matcher: const FullHttpRequestMatcher(needsExactBody: true),
  );

  group('Service', () {
    // group('constructor', () {
    //   test('does not required a httpClient', () {
    //     expect(ApiService(), isNotNull);
    //   });
    // });

    group(('login'), () {
      // test(
      //     'make correct http request with empty response,'
      //         ' throw [ErrorEmptyResponse]', () async {
      //   final response = MockResponse();
      //   var goodLoginResponse = LoginRequest(
      //       '000',
      //       '000',
      //       'TP1A.220624.014',
      //       'SM-A035M',
      //       '2023-11-20 09:28:57',
      //       '6.3242326',
      //       '-75.5692066');
      //
      //   when(() => response.statusCode).thenReturn(200);
      //   when(() => response.body).thenReturn('');
      //   when(() => httpClient.post(any())).thenAnswer((_) async => response);
      //   try {
      //     await apiService.login(goodLoginResponse);
      //     fail('should throw error empty body');
      //   } catch (error) {
      //     expect(
      //       error,
      //       isA<ErrorEmptyResponse>(),
      //     );
      //   }
      //   verify(
      //         () => httpClient.post(
      //       Uri.parse(
      //           'https://pandapan.bexmovil.com/auth/login'),
      //     ),
      //   ).called(1);
      // });

      test('throws ResultError on non-200 response', () async {
        const path = 'https://pandapan.bexmovil.com/api/auth/login';

        dioAdapter.onPost(
          path,
          (server) => server.reply(
            200,
            {'message': 'Success!'},
            // Reply would wait for one-sec before returning data.
            delay: const Duration(seconds: 1),
          ),
        );

        final response = await dio.post(path);

        print(response.data); // {message: Success!}
      });

      //
      // test('return Login.json on a valid response', () async {
      //   var goodLoginResponse = LoginRequest(
      //       '000',
      //       '000',
      //       'TP1A.220624.014',
      //       'SM-A035M',
      //       '1.3.120+244',
      //       '2023-11-20 09:28:57',
      //       '6.3242326',
      //       '-75.5692066');
      //
      //   final response = MockResponse();
      //   when(() => response.statusCode).thenReturn(200);
      //   when(() => httpClient.post(any())).thenAnswer((_) async => response);
      //
      //   await apiService.login(goodLoginResponse);
      //   expect(
      //     LoginResponse.fromMap(jsonDecode(response.body)),
      //     isA<LoginResponse>(),
      //   );
      // });
    });
  });
}
