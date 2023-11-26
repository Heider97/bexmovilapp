import 'package:bexmovil/src/data/datasources/remote/api_service.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

//repositories
import 'package:bexmovil/src/domain/repositories/api_repository.dart';
import 'package:bexmovil/src/domain/repositories/database_repository.dart';
import 'package:mockito/annotations.dart';
import '../../../repository/api_repository.dart';
import 'package:location_repository/location_repository.dart';

//cubit
import 'package:bexmovil/src/presentation/cubits/login/login_cubit.dart';

//requests and response
import 'package:bexmovil/src/domain/models/responses/login_response.dart';
import 'package:bexmovil/src/domain/models/requests/login_request.dart';

//services
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/services/storage.dart';
import 'package:bexmovil/src/services/navigation.dart';

//utils
import 'package:bexmovil/src/utils/resources/data_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  late Dio dio;
  late DioAdapter dioAdapter;
  const loginUrl = 'https://pandapan.bexmovil.com/api/auth/login';

  setUpAll(() {
    dio = Dio(BaseOptions(baseUrl: 'https://pandapan.bexmovil.com/api'));
    dioAdapter = DioAdapter(dio: dio, matcher: const FullHttpRequestMatcher());
    dio.httpClientAdapter = dioAdapter;
    initializeDependencies(testing: true, dio: dio);
  });

  tearDownAll(() {
    unregisterDependencies();
  });

  group('LoginCubit', () {
    late ApiRepository apiRepositoryMock;
    late DatabaseRepository databaseRepositoryMock;
    late LocationRepository locationRepositoryMock;
    late LocalStorageService storageServiceMock;
    late NavigationService navigationServiceMock;

    var badLoginRequest = LoginRequest('no-exist', 'no-exist', 'TP1A.220624.014', 'SM-A035M',
        '1.3.120+244', '2023-11-20 09:28:57', '6.3242326', '-75.5692066');

    var goodLoginRequest = LoginRequest('000', '000', 'TP1A.220624.014', 'SM-A035M',
        '1.3.120+244', '2023-11-20 09:28:57', '6.3242326', '-75.5692066');

    setUp(() {
      //services
      storageServiceMock = locator<LocalStorageService>();
      navigationServiceMock = locator<NavigationService>();
      //repositories
      apiRepositoryMock = MockApiRepository();
      databaseRepositoryMock = locator<DatabaseRepository>();
      locationRepositoryMock = locator<LocationRepository>();
    });

    test('initial state of the bloc is [LoginStatus.initial]', () {
      expect(
          LoginCubit(
                  apiRepositoryMock,
                  databaseRepositoryMock,
                  locator<LocalStorageService>(),
                  locator<NavigationService>(),
                  locationRepositoryMock)
              .state,
          const LoginInitial());
    });

    blocTest<LoginCubit, LoginState>(
      'emits [LoginStatus.loading, LoginStatus.success]'
      ' with a copyWith of other user'
      'state for successful',
      setUp: () {
        return dioAdapter.onPost(
          loginUrl,
          (request) => request.reply(
              200,
              const DataSuccess(
                  LoginResponse(status: true, message: 'successful'))),
          data: Matchers.any,
          headers: {'Content-Type': 'application/json; charset=utf-8'},
        );
      },
      build: () => LoginCubit(apiRepositoryMock, databaseRepositoryMock,
          storageServiceMock, navigationServiceMock, locationRepositoryMock),
      act: (cubit) => cubit.onPressedLogin(goodLoginRequest, testing: true),
      wait: const Duration(milliseconds: 500),
      expect: () => [const LoginLoading(), const LoginSuccess()],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [LoginStatus.loading, LoginStatus.failure] '
      'when unsuccessful',
      setUp: () {
        return dioAdapter.onPost(
          loginUrl,
          (request) =>
              request.reply(401, const DataFailed('Unexpected error occurred')),
          data: Matchers.any,
          headers: {'Content-Type': 'application/json; charset=utf-8'},
        );
      },
      build: () => LoginCubit(apiRepositoryMock, databaseRepositoryMock,
          storageServiceMock, navigationServiceMock, locationRepositoryMock),
      act: (cubit) => cubit.onPressedLogin(badLoginRequest, testing: true),
      wait: const Duration(milliseconds: 500),
      expect: () => <LoginState>[
        const LoginLoading(),
        const LoginFailed(error: "Unexpected error occurred")
      ],
    );
  });
}
