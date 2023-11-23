import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

//repositories
import 'package:bexmovil/src/domain/repositories/api_repository.dart';
import 'package:bexmovil/src/domain/repositories/database_repository.dart';

//domain
import 'package:bexmovil/src/domain/models/login.dart';
import 'package:bexmovil/src/domain/models/user.dart';

//cubit
import 'package:bexmovil/src/presentation/cubits/login/login_cubit.dart';

//utils
import 'package:bexmovil/src/utils/resources/data_state.dart';

//requests and response
import 'package:bexmovil/src/domain/models/requests/login_request.dart';
import 'package:bexmovil/src/domain/models/responses/login_response.dart';

class MockApiRepository extends Mock implements ApiRepository {}
class MockDatabaseRepository extends Mock implements DatabaseRepository {}
class MockLogin extends Mock implements Login {}

void main() {
  group('LoginCubit', () {
    late MockApiRepository apiRepositoryMock;
    late MockDatabaseRepository databaseRepositoryMock;
    late MockLogin loginMock;

    // var loginRequest = LoginRequest('000', '000', deviceId, model, version, date, latitude, longitude);

    setUp(() {
      apiRepositoryMock = MockApiRepository();
      databaseRepositoryMock = MockDatabaseRepository();
      loginMock = MockLogin();
    });

    test('initial state of the bloc is [LoginStatus.initial]', () {
      expect(LoginCubit(apiRepositoryMock, databaseRepositoryMock).state, LoginInitial);
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

  //   blocTest<LoginCubit, LoginState>(
  //     'emits [LoginStatus.loading, LoginStatus.success]'
  //         ' with a copyWith of other cat'
  //         'state for successful',
  //     setUp: () {
  //       when(() => loginMock.user).thenReturn(
  //           () => const User(id: 1, email: 'heiderzapa78@gmail.com', name: '000-VENDEDOR')
  //       );
  //       when(() => apiRepositoryMock.login(request: loginRequest)).thenAnswer((_) async => loginMock);
  //     },
  //     build: () => LoginCubit(apiRepositoryMock, databaseRepositoryMock),
  //     act: (cubit) => cubit.emit(const LoginLoading()),
  //     expect: () => [
  //       const LoginLoading(),
  //       LoginSuccess(login: loginMock)
  //     ],
  //   );
  //
  //   blocTest<LoginCubit, LoginState>(
  //     'emits [LoginStatus.loading, LoginStatus.failure] '
  //         'when unsuccessful',
  //     setUp: () {
  //       when(() => apiRepositoryMock.login(request: loginRequest)).thenThrow(ErrorLogin());
  //     },
  //     build: () => LoginCubit(apiRepositoryMock, databaseRepositoryMock),
  //     act: (cubit) => cubit.emit(const LoginLoading()),
  //     expect: () => <LoginState>[
  //       const LoginLoading(),
  //       const LoginFailed()
  //     ],
  //   );
  });
}