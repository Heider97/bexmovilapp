import 'dart:convert';
import 'package:bexmovil/src/presentation/cubits/login/login_cubit.dart';
import 'package:bexmovil/src/utils/resources/data_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

//repositories
import 'package:bexmovil/src/domain/repositories/api_repository.dart';
import 'package:bexmovil/src/data/repositories/api_repository_impl.dart';
import 'package:bexmovil/src/data/datasources/remote/api_service.dart';

//domain
import 'package:bexmovil/src/domain/models/requests/login_request.dart';
import 'package:bexmovil/src/domain/models/responses/login_response.dart';


void main() {
  group('Service', () {
    late ApiService apiService;
    late ApiRepositoryImpl apiRepositoryImpl;

    setUpAll(() {
      // registerFallbackValue(FakeUri());
    });

    setUp(() {
      apiService = ApiService(testing: true);
      apiRepositoryImpl = ApiRepositoryImpl(apiService);
    });

    group('constructor', () {
      test('does not required a httpClient', () {
        expect(ApiService(testing: true), isNotNull);
      });
    });

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
          var badLoginResponse = LoginRequest(
              'no-exist',
              'no-exist',
              'TP1A.220624.014',
              'SM-A035M',
              '1.0.1+1',
              '2023-11-20 09:28:57',
              '6.3242326',
              '-75.5692066');

        final response = await apiRepositoryImpl.login(request: badLoginResponse);

        expect(
          response,
          throwsA(
            isA<DataFailed<LoginResponse>>(),
          ),
        );
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