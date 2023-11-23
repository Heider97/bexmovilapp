import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location_repository/location_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

//repositories

import 'package:bexmovil/src/domain/repositories/api_repository.dart';
import 'package:bexmovil/src/domain/repositories/database_repository.dart';

//domain
import 'package:bexmovil/src/domain/models/login.dart';

//cubit
import 'package:bexmovil/src/presentation/cubits/login/login_cubit.dart';

//utils
import 'package:bexmovil/src/utils/resources/data_state.dart';

//requests and response
import 'package:bexmovil/src/domain/models/requests/login_request.dart';

//services
import 'package:bexmovil/src/services/storage.dart';
import 'package:bexmovil/src/services/navigation.dart';

@GenerateNiceMocks([MockSpec<ApiRepository>()])
@GenerateNiceMocks([MockSpec<DatabaseRepository>()])
@GenerateNiceMocks([MockSpec<LocationRepository>()])
@GenerateNiceMocks([MockSpec<LocalStorageService>()])
@GenerateNiceMocks([MockSpec<NavigationService>()])
import 'login_cubit_test.mocks.dart';


class MockLogin extends Mock implements Login {}

extension PostExpectation on Answering<Future<void>> {
  void thenAnswerWithVoid() => (_) async {};
}

void main() {
  group('LoginCubit', () {
    late ApiRepository apiRepositoryMock;
    late DatabaseRepository databaseRepositoryMock;
    late LocationRepository locationRepositoryMock;
    late LocalStorageService storageServiceMock;
    late NavigationService navigationServiceMock;

    late MockLogin loginMock;

    var loginRequest = LoginRequest('000', '000', 'TP1A.220624.014', 'SM-A035M',
        '1.3.120+244', '2023-11-20 09:28:57', '6.3242326', '-75.5692066');

    setUp(() {
      apiRepositoryMock = MockApiRepository();
      databaseRepositoryMock = MockDatabaseRepository();
      locationRepositoryMock = MockLocationRepository();
      storageServiceMock = MockLocalStorageService();
      navigationServiceMock = MockNavigationService();
      loginMock = MockLogin();
    });

    test('initial state of the bloc is [LoginStatus.initial]', () {
      expect(
          LoginCubit(
                  apiRepositoryMock,
                  databaseRepositoryMock,
                  storageServiceMock,
                  navigationServiceMock,
                  locationRepositoryMock)
              .state,
          const LoginInitial());
    });

    // blocTest<LoginCubit, LoginState>(
    //   'emits [LoginStatus.loading, LoginStatus.emptyBreeds] '
    //       'state when cat.breeds are empty',
    //   setUp: () {
    //     when(() => loginMock.user).thenReturn(() => null);
    //     when(() => apiRepositoryMock.login(request: loginRequest)).thenAnswer((_) async => DataState<LoginResponse>);
    //   },
    //   build: () => LoginCubit(apiRepositoryMock, databaseRepositoryMock),
    //   act: (bloc) => bloc.emit(LoginSuccess(login: loginMock)),
    //   expect: () => <LoginState>[
    //     const LoginState(status: LoginStatus.loading),
    //     const LoginState(status: LoginStatus.emptyBreeds),
    //   ],
    // );
    //
    // blocTest<LoginCubit, LoginState>(
    //   'emits [LoginStatus.loading, LoginStatus.emptyBreeds] '
    //       'state when cat.breeds are null',
    //   setUp: () {
    //     when(() => loginMock.user).thenReturn(() => null);
    //     when(() => apiRepositoryMock.login(request: loginRequest)).thenAnswer((_) async => loginMock);
    //   },
    //   build: () => LoginCubit(apiRepositoryMock, databaseRepositoryMock),
    //   act: (cubit) => cubit?.add(SearchLogin()),
    //   expect: () => [
    //     const LoginLoading(),
    //     const LoginState(status: LoginStatus.emptyBreeds)
    //   ],
    // );

    // blocTest<LoginCubit, LoginState>(
    //   'emits [LoginStatus.loading, LoginStatus.success]'
    //   ' with a copyWith of other user'
    //   'state for successful',
    //   // setUp: () {
    //   //   when(() => loginMock.user).thenReturn(() => const User(
    //   //       id: 1, email: 'heiderzapa78@gmail.com', name: '000-VENDEDOR'));
    //   //   when(() => apiRepositoryMock.login(request: loginRequest))
    //   //       .thenReturn(() async => const DataSuccess(LoginResponse(status: true, message: 'successful')));
    //   // },
    //   build: () => LoginCubit(apiRepositoryMock, databaseRepositoryMock,
    //       storageServiceMock, navigationServiceMock, locationRepositoryMock),
    //   act: (cubit) => cubit.onPressedLogin(loginRequest, testing: true),
    //   expect: () => [const LoginLoading(), const LoginSuccess()],
    // );
    //
    // blocTest<LoginCubit, LoginState>(
    //   'emits [LoginStatus.loading, LoginStatus.failure] '
    //   'when unsuccessful',
    //   setUp: () {
    //     when(() => apiRepositoryMock.login(request: loginRequest))
    //         .thenReturn(() async => const DataFailed('Unauthentic'));
    //   },
    //   build: () => LoginCubit(apiRepositoryMock, databaseRepositoryMock,
    //       storageServiceMock, navigationServiceMock, locationRepositoryMock),
    //   act: (cubit) => cubit.onPressedLogin(loginRequest, testing: true),
    //   expect: () => <LoginState>[
    //     const LoginLoading(),
    //     const LoginFailed(
    //         error:
    //             "Unauthentic")
    //   ],
    // );
  });
}
