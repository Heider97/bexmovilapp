import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

//cubit
import 'package:bexmovil/src/presentation/cubits/login/login_cubit.dart';
//blocs
import 'package:bexmovil/src/presentation/blocs/recovery_password/recovery_password_bloc.dart';

//presentation
import 'package:bexmovil/src/presentation/views/global/login_view.dart';

//services
import 'package:bexmovil/src/locator.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

class MockRecoveryPasswordBloc
    extends MockBloc<RecoveryPasswordEvent, RecoveryPasswordState>
    implements RecoveryPasswordBloc {}

class FakeLoginState extends Fake implements LoginState {}

void main() {
  late MockLoginCubit cubitLogin;
  late MockRecoveryPasswordBloc blocRecoveryPassword;
  late Dio dio;
  late DioAdapter dioAdapter;
  const loginUrl = 'https://pandapan.bexmovil.com/api/auth/login';

  setUpAll(() {
    dio = Dio(BaseOptions(baseUrl: 'https://pandapan.bexmovil.com/api'));
    dioAdapter = DioAdapter(dio: dio, matcher: const FullHttpRequestMatcher());
    dio.httpClientAdapter = dioAdapter;
    initializeDependencies(testing: true, dio: dio);
    FakeLoginState();
  });

  tearDownAll(() {
    unregisterDependencies();
  });

  // group('LoginPage states ', () {
  //
  //   setUp(() {
  //     cubitLogin = MockLoginCubit();
  //   });
  //
  //   testWidgets(
  //       'render FailureLoginView when state is [LoginStatus.failure]',
  //       (tester) async {
  //     when(() => cubitLogin.state).thenReturn(
  //         () => const LoginFailed(),
  //     );
  //     await tester.pumpWidget(
  //       BlocProvider<LoginCubit>(
  //         lazy: false,
  //         create: (_) => cubitLogin,
  //         child: const MaterialApp(
  //           home: LoginView(),
  //         ),
  //       ),
  //     );
  //     expect(find.byKey(const Key('LoginFailed')),
  //         findsOneWidget);
  //   });
  //
  //   testWidgets('render LoadingView when state is [LoginStatus.loading]',
  //       (tester) async {
  //     when(() => cubitLogin.state).thenReturn(
  //         () => const LoginLoading(),
  //     );
  //     await tester.pumpWidget(
  //         BlocProvider<LoginCubit>(
  //           lazy: false,
  //           create: (_) => cubitLogin,
  //           child: const MaterialApp(
  //             home: LoginView(),
  //           ),
  //         ),
  //     );
  //     expect(
  //         find.byKey(const Key('LoginLoading')), findsOneWidget);
  //   });
  //
  //   testWidgets(
  //       'render SuccessLoginView when state is [LoginStatus.success]',
  //       (tester) async {
  //     when(() => cubitLogin.state).thenReturn(
  //         () => const LoginSuccess(),
  //     );
  //     await tester.pumpWidget(
  //         BlocProvider<LoginCubit>(
  //           lazy: false,
  //           create: (_) => cubitLogin,
  //           child: const MaterialApp(
  //             home: LoginView(),
  //           ),
  //         ),
  //     );
  //     expect(find.byKey(const Key('LoginSuccess')),
  //         findsOneWidget);
  //   });
  //
  //   testWidgets(
  //       'render InitialLoginView when state is [LoginStatus.initial]',
  //       (tester) async {
  //     when(() => cubitLogin.state).thenReturn(
  //         () => const LoginInitial(),
  //     );
  //     await tester.pumpWidget(
  //         BlocProvider<LoginCubit>(
  //           lazy: false,
  //           create: (_) => cubitLogin,
  //           child: const MaterialApp(
  //             home: LoginView(),
  //           ),
  //         ),
  //     );
  //     expect(find.byKey(const Key('LoginInitial')),
  //         findsOneWidget);
  //   });
  // });

  // group('Click on FAB ', () {
  //   testWidgets('call to bloc to get next cat', (tester) async {
  //     when(() => cubitLogin.state).thenReturn(
  //         () => const LoginSuccess(),
  //     );
  //     await tester.pumpWidget(
  //         BlocProvider<LoginCubit>(
  //           lazy: false,
  //           create: (_) => cubitLogin,
  //           child: const MaterialApp(
  //             home: LoginView(),
  //           ),
  //         ),
  //     );
  //     expect(find.byType(FloatingActionButton), findsOneWidget);
  //
  //     await tester.tap(find.byType(FloatingActionButton));
  //     await tester.pumpAndSettle();
  //
  //     verify(() => cubitLogin.emit(const LoginLoading())).called(1);
  //   });
  // });
}
