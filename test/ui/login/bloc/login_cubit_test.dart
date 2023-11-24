import 'dart:convert';
import 'package:bexmovil/src/data/datasources/remote/api_service.dart';
import 'package:bexmovil/src/data/repositories/api_repository_impl.dart';
import 'package:bexmovil/src/locator.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:location_repository/location_repository.dart';
import 'package:mockito/annotations.dart';

//repositories

import 'package:bexmovil/src/domain/repositories/api_repository.dart';
import 'package:bexmovil/src/domain/repositories/database_repository.dart';

//cubit
import 'package:bexmovil/src/presentation/cubits/login/login_cubit.dart';

//requests and response
import 'package:bexmovil/src/domain/models/requests/login_request.dart';

//services
import 'package:bexmovil/src/services/storage.dart';
import 'package:bexmovil/src/services/navigation.dart';

@GenerateNiceMocks([MockSpec<ApiRepositoryImpl>()])
@GenerateNiceMocks([MockSpec<DatabaseRepository>()])
@GenerateNiceMocks([MockSpec<LocationRepository>()])
@GenerateNiceMocks([MockSpec<LocalStorageService>()])
@GenerateNiceMocks([MockSpec<NavigationService>()])
import 'login_cubit_test.mocks.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  late Dio dio;
  late DioAdapter dioAdapter;
  const loginUrl = 'https://pandapan.bexmovil.com/api/auth/login';

  setUpAll(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = dioAdapter;
    initializeDependencies(testing: true, dio: dio);
  });

  tearDownAll(() {
    unregisterDependencies();
  });

  group('LoginCubit', () {
    late ApiRepositoryImpl apiRepositoryMock;
    late DatabaseRepository databaseRepositoryMock;
    late LocationRepository locationRepositoryMock;
    late LocalStorageService storageServiceMock;
    late NavigationService navigationServiceMock;

    var loginRequest = LoginRequest('000', '000', 'TP1A.220624.014', 'SM-A035M',
        '1.3.120+244', '2023-11-20 09:28:57', '6.3242326', '-75.5692066');

    setUp(() {

      storageServiceMock = locator<LocalStorageService>();
      navigationServiceMock = locator<NavigationService>();

      apiRepositoryMock = ApiRepositoryImpl(
          ApiService(dio: dio, storageService: locator<LocalStorageService>()));
      databaseRepositoryMock = MockDatabaseRepository();
      locationRepositoryMock = MockLocationRepository();
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
            (request) =>
                request.reply(200, {'status': true, 'message': 'successful'}),
            data: jsonEncode(loginRequest.toMap()));
      },
      build: () => LoginCubit(apiRepositoryMock, databaseRepositoryMock,
          storageServiceMock, navigationServiceMock, locationRepositoryMock),
      act: (cubit) => cubit.onPressedLogin(loginRequest, testing: true),
      expect: () => [const LoginLoading(), const LoginSuccess()],
    );

    // blocTest<LoginCubit, LoginState>(
    //   'emits [LoginStatus.loading, LoginStatus.failure] '
    //   'when unsuccessful',
    //   setUp: () {
    //     return dioAdapter.onPost(
    //         loginUrl,
    //         (request) =>
    //             request.reply(401, {'status': false, 'message': 'Unexpected error occurred'}),
    //         data: jsonEncode(loginRequest.toMap()));
    //   },
    //   build: () => LoginCubit(apiRepositoryMock, databaseRepositoryMock,
    //       storageServiceMock, navigationServiceMock, locationRepositoryMock),
    //   act: (cubit) => cubit.onPressedLogin(loginRequest, testing: true),
    //   wait: const Duration(milliseconds: 500),
    //   expect: () => <LoginState>[
    //     const LoginLoading(),
    //     const LoginFailed(error: "Unexpected error occurred")
    //   ],
    // );
  });
}
